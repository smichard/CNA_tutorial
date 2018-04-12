# CNA Tutorial

scope, WIP, notation <>

## Prerequisite

* [Virtualbox](https://www.virtualbox.org/)  
* [Vagrant](https://www.vagrantup.com)  
* Putty

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


<a href="http://192.168.58.3:9000"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Portainer01.JPG" width = "500" align="left"></a>
[Portainer](http://192.168.58.3:9000)  
username:  
password:  
link: [192.168.58.3:9000](http://192.168.58.3:9000)  
Portainer is a lightweight management UI which allows you to easily manage your different Docker environments. Portainer is meant to be as simple to deploy as it is to use. It consists of a single container that can run on any Docker engine. Portainer allows you to manage your Docker containers, images, volumes, networks and more ! It is compatible with the standalone Docker engine and with Docker Swarm mode.  
[find more](https://github.com/portainer/portainer)  


<a href="192.168.58.5:8080"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Container_Registry01.JPG" width = "500" align="left"></a>  

[Container Registry GUI](192.168.58.5:8080)  
username:  
password:  
link: [192.168.58.5:8080](http://192.168.58.5:8080)  
description ...  
[find more](link)  


[Minio  S3-target](http://192.168.58.6:9000)  
![Minio S3-target](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/Minio01.JPG)  
Minio is an object storage server released under Apache License v2.0. It is compatible with Amazon S3 cloud storage service. It is best suited for storing unstructured data such as photos, videos, log files, backups and container / VM images. Size of an object can range from a few KBs to a maximum of 5TB.

Minio server is light enough to be bundled with the application stack, similar to NodeJS, Redis and MySQL.  
[find more](https://www.minio.io/)  

[GitLab](http://192.168.58.7:30080)  
![GitLab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_0/GitLab01.JPG)
GitLab is the first single application built from the ground up for all stages of the DevOps lifecycle for Product, Development, QA, Security, and Operations teams to work concurrently on the same project. GitLab enables teams to collaborate and work from a single conversation, instead of managing multiple threads across disparate tools. GitLab provides teams a single data store, one user interface, and one permission model across the DevOps lifecycle allowing teams to collaborate, significantly reducing cycle time and focus exclusively on building great software quickly.  
[GitLab](https://about.gitlab.com/)  

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

## 1. Introduction to Git
* Topics 1
* Topics 2
* Topics 3

## 2. Introduction Cloud Foundry
* Topics 1
* Topics 2
* Topics 3

login, push app, push app with manifest, scale app, blue green deployment, zero downtime push  
```bash
cd chapter_1_1
```
[Follow Read Me of Chapter 1_1](https://github.com/smichard/CNA_tutorial/tree/master/chapter_1_1)

## 3. Introduction to Concourse CI to build a CI / CD pipeline
* Topics 1
* Topics 2
* Topics 3

semver -> gitlab -> concourse -> Minio -> ECS Testdrive
webhook to slack

gitlab -> concourse, credentials  
```bash
cd chapter_1_2
```
[Follow ReadMe of Chapter 1_2](https://github.com/smichard/CNA_tutorial/tree/master/chapter_1_2)

## 4. Introduction to Docker
* Topics 1
* Topics 2
* Topics 3

### 2.1 Docker hello-world  

### 2.2 build Docker container

### 2.3 Using concourse to build container

### 2.4 push artifacts to S3 target
