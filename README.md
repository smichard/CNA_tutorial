# CNA Tutorial

scope

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
![Portainer](CNA_tutorial/0_tutorial/0_Tutorial_Setup/Portainer01.jpg)  
[Container Registry GUI](http://192.168.58.5:8080)  
![Container registry](CNA_tutorial/0_tutorial/0_Tutorial_Setup/Container_Registry01.jpg)  
[Minio  S3-target](http://192.168.58.6:9000)  
![Minio S3-target](CNA_tutorial/0_tutorial/0_Tutorial_Setup/Minio01.jpg)  
[GitLab](http://192.168.58.7:30080)  
![GitLab](CNA_tutorial/0_tutorial/0_Tutorial_Setup/GitLab01.jpg)
[Concourse](http://192.168.58.8:8080)  
![Concourse web](CNA_tutorial/0_tutorial/0_Tutorial_Setup/Concourse01.jpg)

## 1. Cloud Foundry Tutorial

### 1.1 Pushing an app to Cloud Foundry  
login, push app with manifest, scale app  

### 1.2 Using Concourse to push apps to Cloud Foundry 

gitlab -> concourse, credentials  

### 1.3 Pushing artifacts to S3 target  

gitlab -> concourse -> Minio -> ECS Testdrive

### 1.4 Using versioning

semver

### 1.5 Using slack    

webhook to slack

## 2. Docker Tutorial

### 2.1 Docker hello-world  

Dockerfile  

### 2.2 build Docker container

### 2.3 Using concourse to build container

### 2.4 push artifacts to S3 target
