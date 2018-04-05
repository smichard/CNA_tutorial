# CNA Tutorial

scope, WIP

## Prerequisite

[Virtualbox](https://www.virtualbox.org/)  
[Vagrant](https://www.vagrantup.com)  

```bash
vagrant up
```

## Tutorial environment



| Component     | IP           | Port  |
| ------------- |------------  | ----- |
| Docker Host   | 192.168.58.2 |       |
| Portainer     | [192.168.58.3](http://192.168.58.3:9000) | 9000  |
| Container registry srv  | 192.168.58.4 | 5000  |
| Container registry gui  | [192.168.58.5](http://192.168.58.5:8080) | 8080  |
| Minio S3-target  | [192.168.58.6](http://192.168.58.6:9000) | 9000  |
| GitLab        | [192.168.58.7](http://192.168.58.7:30080) | 30080 |
| Concourse | [192.168.58.8](http://192.168.58.8:8080) | 8080  |


Screenshots  
[Portainer](http://192.168.58.3:9000)  
![Portainer](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Portainer01.JPG)  
[Container Registry GUI](http://192.168.58.5:8080)  
![Container registry](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Container_Registry01.JPG)  
[Minio  S3-target](http://192.168.58.6:9000)  
![Minio S3-target](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Minio01.JPG)  
[GitLab](http://192.168.58.7:30080)  
![GitLab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/GitLab01.JPG)
[Concourse](http://192.168.58.8:8080)  
![Concourse web](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Concourse01.JPG)

## How to
explain various services how to access  
use e.g. Putty to connect to vagrant box
Hostname: 127.0.0.1
Port: 2222
User: vagrant
Password: vagrant
```bash
cd /vagrant
ls
```

## 1. Cloud Foundry Tutorial

### 1.1 Pushing an app to Cloud Foundry  
login, push app, push app with manifest, scale app, blue green deployment, zero downtime push  
```bash
cd chapter_01_1
```
[Follow ReadMe of Chapter 1](https://github.com/smichard/CNA_tutorial/tree/master/chapter_01_1)

### 1.2 Using Concourse to push apps to Cloud Foundry

gitlab -> concourse, credentials  

### 1.4 Using versioning

semver

### 1.3 Pushing artifacts to S3 target  

gitlab -> concourse -> Minio -> ECS Testdrive

### 1.5 Using slack    

webhook to slack

## 2. Docker Tutorial

### 2.1 Docker hello-world  

Dockerfile  

### 2.2 build Docker container

### 2.3 Using concourse to build container

### 2.4 push artifacts to S3 target
