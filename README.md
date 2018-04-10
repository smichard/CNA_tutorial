# CNA Tutorial

scope, WIP, notation <>

## Prerequisite

[Virtualbox](https://www.virtualbox.org/)  
[Vagrant](https://www.vagrantup.com)  

```bash
git clone https://github.com/smichard/CNA_tutorial.git
cd CNA_tutorial
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


<img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Portainer01.JPG" width = "500" align="left">
[Portainer](http://192.168.58.3:9000)  
username:  
password:  
link: [http://192.168.58.3:9000](http://192.168.58.3:9000)
Portainer is a lightweight management UI which allows you to easily manage your different Docker environments. Portainer is meant to be as simple to deploy as it is to use. It consists of a single container that can run on any Docker engine. Portainer allows you to manage your Docker containers, images, volumes, networks and more ! It is compatible with the standalone Docker engine and with Docker Swarm mode.  
[find more](https://github.com/portainer/portainer)  

<img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Container_Registry01.JPG" width = "500" align="left">  
[Container Registry GUI](http://192.168.58.5:8080)  
username:  
password:  
link: [http://192.168.58.5:8080](http://192.168.58.5:8080)  
description ...  
[find more](link)  


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
cd chapter_1_1
```
[Follow ReadMe of Chapter 1_1](https://github.com/smichard/CNA_tutorial/tree/master/chapter_1_1)

### 1.2 Continuous Integration Pipeline with Concourse CI

gitlab -> concourse, credentials  
```bash
cd chapter_1_2
```
[Follow ReadMe of Chapter 1_2](https://github.com/smichard/CNA_tutorial/tree/master/chapter_1_2)

### 1.3 Backing Up App artifacts to S3 target  

semver -> gitlab -> concourse -> Minio -> ECS Testdrive

### 1.5 Using slack    

webhook to slack

## 2. Container Tutorial

### 2.1 Docker hello-world  

Dockerfile  

### 2.2 build Docker container

### 2.3 Using concourse to build container

### 2.4 push artifacts to S3 target
