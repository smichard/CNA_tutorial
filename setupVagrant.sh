#!/bin/bash
echo "Provisioning virtual machine..."
apt-get update
apt-get install -y virtualbox-guest-additions-iso
apt-get install -y bridge-utils
echo "Kill all Docker Containers"
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)

## Create shared docker network
ip addr del 192.168.58.2/24 dev eth1
docker network create --driver bridge --subnet=192.168.58.0/24 --gateway=192.168.58.2 --opt "com.docker.network.bridge.name"="docker1" shared_nw
brctl addif docker1 eth1

# installing PCF CLI
if [ -f "/vagrant/cf-cli-installer_6.30.0_x86-64.deb" ]
then
  echo "Installing Cloud Foundry CLI"
  dpkg -i /vagrant/cf-cli-installer_6.30.0_x86-64.deb
else
  echo "Cloud Foundry CLI not found"
fi
echo "Installing fly CLI"
wget https://github.com/concourse/concourse/releases/download/v3.10.0/fly_linux_amd64
mv fly_linux_amd64 fly
cp fly /usr/local/bin/fly
chmod 0755 /usr/local/bin/fly
echo "Starting Portainer"
docker run --name portainer --net shared_nw --ip 192.168.58.3 -d --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer
echo "Configuring Concourse CI"
mkdir -p /vagrant/concourse_ci/keys/web /vagrant/concourse_ci/keys/worker
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/web/tsa_host_key -N ''
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/web/session_signing_key -N ''
ssh-keygen -t rsa -f /vagrant/concourse_ci/keys/worker/worker_key -N ''
cp /vagrant/concourse_ci/keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
cp /vagrant/concourse_ci/keys/web/tsa_host_key.pub ./keys/worker
echo "Starting Concourse CI"
export CONCOURSE_EXTERNAL_URL=http://192.168.58.8:8080
docker-compose -f /vagrant/concourse_ci/docker-compose.yml up -d
echo "Starting Registry"
# docker-compose?
docker run -d --net shared_nw --ip 192.168.58.4 --name registry-srv registry:2
docker run -d --net shared_nw --ip 192.168.58.5 --name registry-gui --link registry-srv -e REGISTRY_URL=http://registry-srv:5000/v2 -e REGISTRY_NAME=localhost:5000 hyper/docker-registry-web
echo "Starting Minio"
docker run --name minio-target -d --net shared_nw --ip 192.168.58.6 -e MINIO_ACCESS_KEY=admin -e MINIO_SECRET_KEY=Password1! minio/minio server /data
echo "Starting Gitlab"
docker run --detach --name gitlab \
	--hostname gitlab.example.com \
  --net shared_nw \
  --ip 192.168.58.7 \
	--publish 30080:30080 \
	--publish 30022:22 \
	--env GITLAB_OMNIBUS_CONFIG="external_url 'http://127.0.0.1:30080'; gitlab_rails['gitlab_shell_ssh_port']=30022;" \
	gitlab/gitlab-ce
echo "Ready"
