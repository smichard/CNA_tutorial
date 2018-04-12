## Chapter 1.2

scope

### 1.2.1 Create GitLab project
go to [GitLab](http://192.168.58.7:30080)
set password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_1.JPG)
login as 'root' with selected password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_2.JPG)
initialize git repo

```bash
git remote add origin http://192.168.58.7:30080/root/<my_project_name>.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

### 1.2.2 create concourse pipeline  
Introduction to conourse, bladi, bladi, bla
basically ressources, can act as input and output, some can be both, some can only either be in or output, define one input (GitLab Ressource) and one output (cf target) [Find More](https://concourse-ci.org/resources.html)
build job, bladi bladi bla
[Find More](https://concourse-ci.org/jobs.html)
```bash
resources:
- name: app_sources
  type: git
  source:
    uri: http://127.0.0.1:30080/root/<my-gitlab-project>.git
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
create 'credentials.yml' file
add 'credentials.yml' file to the '.gitignore' file in the root directory of your git repository in order to prevent it from check in
```bash
cf_username: <my_cf_username>
cf_password: <my_cf_password>
```

### 1.2.3 install fly cli
download fly cli, explain fly CLI [Find More](https://concourse-ci.org/fly.html)
![concourse](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_concourse_1.JPG)
```bash
mv fly_linux_amd64 fly
cp fly /usr/local/bin/fly
```
login to concourse ci
```bash
fly -t <my_target> login -c http://192.168.58.8:8080
```

### 1.2.4 set concourse pipeline
set pipeline [Find More](https://concourse-ci.org/pipelines.html)
```bash
fly -t <my_target> set-pipeline -c ci/pipeline.yml -l ci/credentials.yml
```
unpause pipeline, perform changes
```bash
./website/update_script.sh
git add -A
git commit -m "<my_comment>"
git push gitlab master
```

### 1.2.5 zero downtime deployment to cloud foundry
explain ressource types [Find More](https://concourse-ci.org/resource-types.html)
add ressource type
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

[Go Back](https://github.com/smichard/CNA_tutorial)
