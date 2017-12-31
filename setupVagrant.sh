#!/bin/bash
echo "Provisioning virtual machine..."
apt-get update
apt-get install -y virtualbox-guest-additions-iso
echo "Kill all Docker Containers"
docker kill $(docker ps -q)
# installing PCF CLI
if [ -f "/vagrant/cf-cli-installer_6.30.0_x86-64.deb" ]
then
  echo "Installing Cloud Foundry CLI"
  dpkg -i /vagrant/cf-cli-installer_6.30.0_x86-64.deb
else
  echo "Cloud Foundry CLI not found"
fi
echo "Installing Concourse CI"
wget https://github.com/concourse/concourse/releases/download/v3.8.0/fly_linux_amd64
mv fly_linux_amd64 fly
cp fly /usr/local/bin/fly
chmod 0755 /usr/local/bin/fly
echo "Starting Portainer"
docker run --name portainer -d -p 9002:9000 --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
echo "Configuring Concourse CI"
mkdir -p /vagrant/concourse_ci/keys/web /vagrant/concourse_ci/keys/worker
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/web/tsa_host_key -N ''
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/web/session_signing_key -N ''
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/worker/worker_key -N ''
cp /vagrant/concourse_ci/keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp /vagrant/concourse_ci/keys/web/tsa_host_key.pub ./keys/worker
echo "Starting Concourse CI"
export CONCOURSE_EXTERNAL_URL=http://127.0.0.1:9004
docker-compose -f /vagrant/concourse_ci/docker-compose.yml up -d
echo "Starting Registry"
# docker-compose?
docker run -d -p 5000:5000 --name registry-srv registry:2
docker run -d -p 9001:8080 --name registry-gui --link registry-srv -e REGISTRY_URL=http://registry-srv:5000/v2 -e REGISTRY_NAME=localhost:5000 hyper/docker-registry-web 
echo "Starting Minio"
export MINIO_DOCKER_NAME=minio-target
export MINIO_ACCESS_KEY=admin
export MINIO_SECRET_KEY=Password1!
export MINIO_BUCKET=releases
docker run --name $MINIO_DOCKER_NAME -d -p 9000:9000 -e MINIO_ACCESS_KEY=$MINIO_ACCESS_KEY -e MINIO_SECRET_KEY=$MINIO_SECRET_KEY minio/minio server /data
docker run --rm --link $MINIO_DOCKER_NAME:minio -e MINIO_BUCKET=$MINIO_BUCKET --entrypoint sh minio/mc -c "\
  while ! nc -z minio 9000; do echo 'Wait minio to startup...' && sleep 0.1; done; \
  sleep 5 && \
  mc config host add myminio http://minio:9000 \$MINIO_ENV_MINIO_ACCESS_KEY \$MINIO_ENV_MINIO_SECRET_KEY && \
  mc rm -r --force myminio/\$MINIO_BUCKET || true && \
  mc mb myminio/\$MINIO_BUCKET && \
  mc policy download myminio/\$MINIO_BUCKET \
"
echo "Starting Gitlab"
docker run --detach --name gitlab \
	--hostname gitlab.example.com \
	--publish 30080:30080 \
	--publish 30022:22 \
	--env GITLAB_OMNIBUS_CONFIG="external_url 'http://127.0.0.1:30080'; gitlab_rails['gitlab_shell_ssh_port']=30022;" \
	gitlab/gitlab-ce
echo "Ready"
