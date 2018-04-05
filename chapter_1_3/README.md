## Chapter 1.2

scope

### 1.2.1 Create GitLab project
go to [GitLab](http://192.168.58.7:30080)
set password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_1)
login as 'root' with selected password
![Git_Lab](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/2_gitlab_2)
since already existing git repository, adding second remote

```bash
git remote add gitlab http://127.0.0.1:30080/root/<my-gitlab-project>.git
git push -u gitlab master
```

### 1.2.2 create concourse pipeline  

### 1.2.3 install fly cli

### 1.2.4 set concourse pipeline

### 1.2.5 zero downtime deployment to cloud foundry

[Go Back](https://github.com/smichard/CNA_tutorial)
