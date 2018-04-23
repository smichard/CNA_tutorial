## Chapter 3

The scope of this chapter is to walk through the following topics:
* install the fly CLI in order to connect to the Concourse CI target
* create an integration pipeline with Concourse CI
* set and activate concourse pipeline
* zero downtime deployment to Cloud Foundry through Concourse CI
* versioning semver
* push to S3 target -> minio -> ECS Testdrive
* slack integration

### Create GitLab project
First go to the [GitLab](http://192.168.58.7:30080) instance in order to create a new project / repository for the current directory. Login as `root` with the password you set earlier.  
Initialize the git repository using the CLI:
```bash
git remote add origin http://192.168.58.7:30080/root/<my_project_name>.git
git add .
git commit -m "Initial commit"
git push -u origin master
```
### Install the fly CLI
The fly CLI is the main tool to interact with Concourse CI, there is no GUI configuration wizard. The first step to get started with Concourse CI is to download the fly CLI. The fly CLI is available through the running Concourse CI instance.  
Go to the [Concourse CI](http://192.168.58.8:8080) instance and download the Linux binaries.
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_1.JPG)
Copy the downloaded binaries to the current directory and install the fly CLI
```bash
mv fly_linux_amd64 fly
cp fly /usr/local/bin/fly
```
To communicate with Concourse CI you have to authenticate yourself and specify a target name. Think of the target as a alias for the endpoint such as you don't have to specify the url all the time once the target is set.  
Login to Concourse CI:
```bash
fly -t <my_target> login -c http://192.168.58.8:8080
```
[Find More](https://concourse-ci.org/fly.html)

### Create concourse pipeline  
Introduction to conourse, bladi, bladi, bla
structure, ressource and jobs  
**ressource:**  
**ressource_type:**  
**jobs:**  
**task:**  
basically ressources, can act as input and output, some can be both, some can only either be in or output, define one input (GitLab Ressource) and one output (cf target) [Find More](https://concourse-ci.org/resources.html)
build job, bladi bladi bla, best practise create folder for ci
[Find More](https://concourse-ci.org/jobs.html)
```bash
resources:
- name: app_sources
  type: git
  source:
    uri: http://192.168.58.7:30080/root/<my-gitlab-project>.git
    username: {{gitlab_username}}
    password: {{gitlab_password}}
    branch: master
  check_every: 10s

- name: cloud_foundry
  type: cf
  source:
    api: https://api.run.pivotal.io
    username: {{cf_username}}
    password: {{cf_password}}
    organization: <my_cf_org>
    space: <my_cf_space>
    skip_cert_check: false

jobs:
  - name: deploy-app
    public: true
    serial: true
    plan:
    - get: app_sources
      version: every
      trigger: true
    - put: cloud_foundry
      params:
        path: app_sources/website/
        manifest: app_sources/manifest.yml
```
create `credentials.yml` file
add `credentials.yml` file to the `.gitignore` file in the root directory of your git repository in order to prevent it from check in
```bash
gitlab_username: <my_gitlab_username>
gitlab_password: <my_gitlab_password>
cf_username: <my_cf_username>
cf_password: <my_cf_password>
```

### Set concourse pipeline
set pipeline [Find More](https://concourse-ci.org/pipelines.html)
```bash
fly -t <my_target> set-pipeline -p <my_pipeline> -c ci/pipeline.yml -l ci/credentials.yml
```
login to [Concourse](http://192.168.58.8:8080)  
unpause pipeline
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)
execute pipeline gui,  
perform some changes, helper script
```bash
./update_script.sh
git add -A
git commit -m "<my_comment>"
git push origin master
```

### Zero downtime deployment to cloud foundry
explain ressource types [Find More](https://concourse-ci.org/resource-types.html)
copy pipeline  and create networks
```bash
cp ci/pipeline.yml ci/pipeline_zero.yml
```


add ressource type, pipeline_zero.yml
```bash
resource_types:
- name: cf_cli_resource
  type: docker-image
  source:
    repository: pivotalpa/cf-cli-resource
    tag: latest
```
adjust resources
```bash
- name: cloud_foundry
  type: cf_cli_resource
  source:
    api: https://api.run.pivotal.io
    username: {{cf_username}}
    password: {{cf_password}}
    org: <my_cf_org>
    space: <my_cf_space>
    skip_cert_check: false
```
adjust job
```bash
jobs:
  - name: deploy-app
    public: true
    serial: true
    plan:
    - get: app_sources
      version: every
      trigger: true
    - put: cf-push
      resource: cloud_foundry
      params:
        command: zero-downtime-push
        path: app_sources/website/
        manifest: app_sources/manifest.yml
        current_app_name: <my_app_name>
```

```bash
fly -t <my_target> set-pipeline -p <my_pipeline> -c ci/pipeline_zero.yml -l ci/credentials.yml
```
trigger pipeline, through git

### versioning semver
create new branch
```bash
git branch version
```
delete all files, and a file `version` content 0.1.0
```bash
git add -A
git commit -m "versioning added"
git push origin version
git checkout master
```
add smever ressource
adjust resources
```bash
- name: version
  type: semver
  source:
    uri: http://192.168.58.7:30080/root/<my-gitlab-project>.git
    branch: version
    username: {{gitlab_username}}
    password: {{gitlab_password}}
    file: version
    driver: git
    initial_version: 0.1.0
```

add new job
```bash
- name: bump-version-minor
  public: true
  plan:
    - aggregate:
      - get:  app_sources
        passed: [ deploy-app ]
        trigger: true
      - get: version
        trigger: false
      - put: version
        params: {bump: minor}
```

explain versioning
```bash
fly -t <my_target> set-pipeline -p <my_pipeline> -c ci/pipeline_zero.yml -l ci/credentials.yml
```
trigger pipeline, through git
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)
gitlab screen shot to show versioning
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)

### push to S3 target -> minio
login to [Minio](http://192.168.58.6:9000)  
create bucket
![Minio](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_minio.JPG)
add S3 ressources
```bash
- name: minio_target
  type: s3
  source:
    endpoint: http://192.168.58.6:9000
    bucket: releases
    regexp: app_artifact-(.*).tar.gz
    access_key_id: {{minio_username}}
    secret_access_key: {{minio_password}}
```
add minio credentialy to `credentials.yml`
```bash
minio_username: <my_gitlab_username>
minio_password: <my_gitlab_password>
```

add job
```bash
- name: minio-backup
  public: true
  serial: true
  plan:
  - get: version
    trigger: false
  - get: app_sources
    trigger: true
    passed: [ deploy-app ]
  - task: create-artifact
    file: app_sources/ci/tasks/create_artifact.yml
  - put: minio_target
    params:
      file: ./artifact/app_artifact-*.tar.gz
      acl: public-read
```
```bash
fly -t <my_target> set-pipeline -p <my_pipeline> -c ci/pipeline_zero.yml -l ci/credentials.yml
```
trigger pipeline, through git
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)
minio screen shot to show upload
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)

### slack integration
add ressource types
```bash
- name: slack_notification
  type: docker-image
  source:
    repository: cfcommunity/slack-notification-resource
    tag: latest
```

add ressource
```bash
- name: slack_msg
  type: slack_notification
  source:
    url: {{slack_hook}}
```

login to slack, configure apps, custom integration, add configuration, copy webhook url, add slack credentials to `credentials.yml`
```bash
slack_hook: <my_slack_hook>
```

adjust deploy jobs
```bash
jobs:
  - name: deploy-app
    public: true
    serial: true
    plan:
    - get: app_sources
      version: every
      trigger: true
    - put: cf-push
      resource: cloud_foundry
      params:
        command: zero-downtime-push
        path: app_sources/website/
        manifest: app_sources/manifest.yml
        current_app_name: <my_app_name>
      on_success:
        put: slack_msg
        params:
          channel: '#general'
          text: |
            The build $BUILD_JOB_NAME with build ID $BUILD_ID for pipeline $BUILD_PIPELINE_NAME completed succesfully. Check the current development state at: http://192.168.58.8:8080/builds/$BUILD_ID
      on_failure:
        put: slack_msg
        params:
          channel: '#general'
          text: |
            The build $BUILD_JOB_NAME with build ID $BUILD_ID for pipeline $BUILD_PIPELINE_NAME failed. Check it out at:
            http://192.168.58.8:8080/builds/$BUILD_ID
```
trigger pipeline, through git
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/co_concourse_2.JPG)


At the end of this chapter delete all apps and switch to the parent directory:
```bash
cf delete <my_app_name>
cf apps
cd ..
```

[Go Back](https://github.com/smichard/CNA_tutorial)
