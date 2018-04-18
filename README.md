# CNA Tutorial

**work in progress**  
- [ ] chapter 3
  - [ ] test code
  - [ ] add text
  - [ ] add screenshots
- [ ] chapter 2
- [ ] optimize Vagrantfile, plain ubuntu
The aim of this tutorial is to introduce the basic concepts of cloud native application development.  
Starting by introducing the basic concepts of version control systems like **git**. This tutorial demonstrates the basic interaction with **Cloud Foundry** and shows how to push a small static website to Cloud Foundry. Furthermore the tutorial shows how to build a continuous integration pipeline with **Concourse CI in** order to push application code to Cloud Foundry. Furthermore the integration of S3 targets and slack into integration pipelines are shown. Lastly this tutorial intends to give a short introduction to the use of **Docker** containers.  

## Prerequisite
The prerequisites for using this tutorial is the installation of **VirtualBox** and **Vagrant** on your local system. In addition, it makes sense to use a SSH client such as **Putty** and a text editor such as **Atom**:
* [Virtualbox](https://www.virtualbox.org/)  
* [Vagrant](https://www.vagrantup.com)  
* [Putty](https://www.putty.org/)
* [Atom](https://atom.io/)

Once the software is downloaded and installed just clone this repository, go to the cloned folder and spin the development environment up by using vagrant:
```bash
git clone https://github.com/smichard/CNA_tutorial.git
cd CNA_tutorial
vagrant up
```
Any text that is shown in brackets (e. g. `<some_text>`) requires an adjustment in the course of this tutorial.

## Tutorial environment
**wip**  
describe environment


| Component     | IP           | Port  |
| ------------- |------------  | ----- |
| Docker Host   | 192.168.58.2 |       |
| Portainer     | [192.168.58.3](http://192.168.58.3:9000) | 9000  |
| Container registry srv  | 192.168.58.4 | 5000  |
| Container registry gui  | [192.168.58.5](http://192.168.58.5:8080) | 8080  |
| Minio S3-target  | [192.168.58.6](http://192.168.58.6:9000) | 9000  |
| GitLab        | [192.168.58.7](http://192.168.58.7:30080) | 30080 |
| Concourse | [192.168.58.8](http://192.168.58.8:8080) | 8080  |

<a href="http://192.168.58.7:30080"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_gitlab.JPG" width = "400" align="left"></a>
[GitLab](http://192.168.58.7:30080)  
Username: root  
Password: <set_your_password>  
Link: [192.168.58.7:30080](http://192.168.58.7:30080)  
GitLab is the first single application built from the ground up for all stages of the DevOps lifecycle for Product, Development, QA, Security, and Operations teams to work concurrently on the same project. GitLab enables teams to collaborate and work from a single conversation, instead of managing multiple threads across disparate tools. GitLab provides teams a single data store, one user interface, and one permission model across the DevOps lifecycle allowing teams to collaborate, significantly reducing cycle time and focus exclusively on building great software quickly.  
[GitLab](https://about.gitlab.com/)  

<a href="http://192.168.58.8:8080"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_concourseci.JPG" width = "400" align="left"></a>
[Concourse](http://192.168.58.8:8080)  
Username: admin  
Password: Password1!  
link: [192.168.58.8:8080](http://192.168.58.8:8080)  
Concourse CI is an open source continuous integration tool written in Go. Concourse limits itself to three core concepts: tasks, resources, and the jobs that compose them. Interesting features like timed triggers and synchronizing usage of external environments are modeled in terms of these.  
[Concourse CI](https://concourse-ci.org/)  

<a href="http://192.168.58.6:9000"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_minio.JPG" width = "400" align="left"></a>
[Minio  S3-target](http://192.168.58.6:9000)  
Username: admin  
Password: Password1!  
Link: [192.168.58.6:9000](http://192.168.58.6:9000)  
Minio is an object storage server released under Apache License v2.0. It is compatible with Amazon S3 cloud storage service. It is best suited for storing unstructured data such as photos, videos, log files, backups and container / VM images. Size of an object can range from a few KBs to a maximum of 5TB.   Minio server is light enough to be bundled with the application stack, similar to NodeJS, Redis and MySQL.  
[find more](https://www.minio.io/)  

<a href="192.168.58.5:8080"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_registry.JPG" width = "400" align="left"></a>  
[Container Registry GUI](192.168.58.5:8080)  
Username: <set_your_username>  
Password: <set_your_password>  
Link: [192.168.58.5:8080](http://192.168.58.5:8080)  
A web UI, authentication service and event recorder for a private docker registry v2. Supports the following features:  
* browsing repositories, tags and images in docker registry v2
* optional token based authentication provider with role-based permissions
* Docker registry notification recording and audit
[find more](https://github.com/mkuchin/docker-registry-web)  

<a href="http://192.168.58.3:9000"><img src = "https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_portainer.JPG" width = "400" align="left"></a>
[Portainer](http://192.168.58.3:9000)  
Username: admin  
Password: <set_your_password>  
Link: [192.168.58.3:9000](http://192.168.58.3:9000)  
Portainer is a lightweight management UI which allows you to easily manage your different Docker environments. Portainer is meant to be as simple to deploy as it is to use. It consists of a single container that can run on any Docker engine. Portainer allows you to manage your Docker containers, images, volumes, networks and more ! It is compatible with the standalone Docker engine and with Docker Swarm mode.  
[find more](https://github.com/portainer/portainer)  


## Getting Started
Check if all services have been started successfully, the easiest way is by using Portatiner. Login to Portainer using your credentials, choose connect to local, and go to the container tab. All services should be up und running:  
![Portainer](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_portainer_2.JPG)

Connect to your vagrant box e.g. by using Putty:  
![Putty](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_putty.JPG)  
Hostname: 127.0.0.1  
Port: 2222  
Username: vagrant  
Password: vagrant
```bash
cd /vagrant
ls
```
![Summary](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/intro_summary.JPG)
## 1. Introduction to Git
* Topics 1
* Topics 2
* Topics 3  
[Follow Read Me of Chapter 1](https://github.com/smichard/CNA_tutorial/tree/master/chapter_1)

## 2. Introduction Cloud Foundry
* connect to Cloud Foundry
* pushing an app to Cloud Foundry
* scaling an app
* pushing an app to Cloud Foundry using a manifest
* blue / green deployment with zero downtime
```bash
cd chapter_2
```
[Follow Read Me of Chapter 2](https://github.com/smichard/CNA_tutorial/tree/master/chapter_2)

## 3. Introduction to Concourse CI to build an integration pipeline
* install the fly CLI in order to connect to the Concourse CI target
* create an integration pipeline with Concourse CI
* set concourse pipeline
* zero downtime deployment to Cloud Foundry through Concourse CI
* versioning semver
* push to S3 target -> minio -> ECS Testdrive
* slack integration
```bash
cd chapter_3
```
[Follow Read Me of Chapter 3](https://github.com/smichard/CNA_tutorial/tree/master/chapter_3)

## 4. Introduction to Docker
* Docker hello-world
* Build a custom Docker container
* Using Concourse CI to build a Docker container  
[Follow Read Me of Chapter 4](https://github.com/smichard/CNA_tutorial/tree/master/chapter_4)
