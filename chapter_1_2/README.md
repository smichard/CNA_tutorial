## Chapter 1.2

scope

### 1.2.1 Create GitLab project
go to [GitLab](http://192.168.58.7:30080)
set password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_1.JPG)
login as 'root' with selected password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_2.JPG)
since already existing git repository, adding second remote

```bash
git remote add gitlab http://127.0.0.1:30080/root/<my-gitlab-project>.git
git push -u gitlab master
```

### 1.2.2 create concourse pipeline  
Introduction to conourse, bladi, bladi, bla
basically ressources, can act as input and output, some can be both, some can only either be in or output, define one input (GitLab Ressource) and one output (cf target)
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

### 1.2.4 set concourse pipeline

### 1.2.5 zero downtime deployment to cloud foundry

[Go Back](https://github.com/smichard/CNA_tutorial)
