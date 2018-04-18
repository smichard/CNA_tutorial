## Chapter 2

The scope of this chapter is to walk through the following topics:
* connect to Cloud Foundry
* pushing an app to Cloud Foundry
* scaling an app
* pushing an app to Cloud Foundry using a manifest
* blue / green deployment with zero downtime

### Prerequisite
Get a Cloud Foundry account e. g. at [Pivotal Web Services](https://run.pivotal.io/). Login to your newly created account and start creating spaces. Every application in Cloud Foundry is scoped to a space. Each space itself belongs to an org. Each org contains at least one space. A space provides users with access to a shared location for application development, deployment, and maintenance.  
![Cloud_Foundry](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/cf_cloud_foundry_spaces.JPG)
[Find More](http://docs.cloudfoundry.org/concepts/roles.html)

### Connect to Cloud Foundry Instance
Connect to your Cloud Foundry instance via the CLI:
```bash
cf login -a https://api.run.pivotal.io
```
Provide your credentials and select a space you created earlier.

### Pushing an app to Cloud Foundry  
Use the CLI to push the local files to Cloud Foundry.
```bash
cf push <my_app_name> -b staticfile_buildpack
```
In order to push an application to Cloud Foundry you need to specify a buildpack. Buildpacks provide framework and runtime support for apps. Buildpacks typically examine your apps to determine what dependencies to download. In the above example you specified the static_file_buildpack since the application files just make up a staic website.  

Congratulations, you just pushed your first app to Cloud Foundry.  
Your app should be available through:  
https://<my_app_name>.cfapps.io  

Check the status of all running apps in the space you specified earlier:  
```bash
cf apps
```

You can also check status of a specific app:  
```bash
cf app <my_app_name>
```
[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/deploy-app.html)

### Scaling an app
Factors such as user load, or the number and nature of tasks performed by an application, can change the disk space and memory the application uses. For many applications, increasing the available disk space or memory can improve overall performance. Similarly, running additional instances of an application can allow the application to handle increases in user load and concurrent requests.  
Use the CLI to scale your application to 5 app instances:
```bash
cf scale <my_app_name> -i 5
```

You can also use the CLI to increase the memory available to your app to improve the app performance:
```bash
cf scale <my_app_name> -m 128M
```

You can also scale the app using the webportal of the Cloud Foundry provider you choosed:
![Cloud_Foundry](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/cf_cloud_foundry_scaling.JPG)

Finally delete the app with:
```bash
cf delete <my_app_name>
cf apps
```
[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/cf-scale.html)

### Pushing an app to Cloud Foundry using a manifest file
The use of the `cf push` command deploys apps with a default number of instances, disk space limit, and memory limit. You can override the default values by invoking cf push with flags and values, or by specifying key-value pairs in a manifest file. Manifests provide consistency and reproducibility, and can help you automate deploying apps. By default, the cf push command deploys an application using a manifest.yml file in the current working directory.  
Create a `manifest.yml` file in the current folder:
```bash
---
applications:
- name: <my_app_name>
  memory: 64M
  instances: 2
  routes:
   - route: <my_app_name>.cfapps.io
  buildpack: staticfile_buildpack
```
Once the manifest is created successfully perform the push command again:
```bash
cf push
```
This manifest pushs the app with the name <my_app_name> to Cloud Foundry with a memory of 64M assigned to each of the 2 application instances.    

Use the helper script `./update_script.sh` to perform changes to the app sources and perform `cf push` again. The app gets pushed a second time. The cf CLI automatically performs an incremental push of the application bits, thus only newly created application bits or thoose that have been changed since the last push get uploaded to Cloud Foundry. However, such a push always induces downtime to the application since the application droplet gets re-build and is restarted.

[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html)

### blue / green deployment with zero downtime push
To perform zero downtime pushs you need to install a plugin to the cf CLI. Download the latest version of the **Autopilot** from [GitHub](https://github.com/contraband/autopilot/releases)
```bash
cf install-plugin <path_to_downloaded_binary>
```
Add an environment variable to the manifest you created earlier:
```bash
---
applications:
- name: <my_app_name>
  memory: 64M
  instances: 2
  routes:
   - route: <my_app_name>.cfapps.io
  buildpack: staticfile_buildpack
  env:
   APP_VERSION: blue
```
Perform `cf push` again and check that the environment variable has been set:
```bash
cf env <my_app_name>
```
Environment variables are the means by which the Cloud Foundry runtime communicates with a deployed application about its environment.  
Use the helper script `./update_script.sh` to perform changes to the application code and create a second manifest file called `manifest_green.yml` and place it in the same folder:
```bash
---
applications:
- name: <my_app_name>
  memory: 64M
  instances: 2
  routes:
   - route: <my_app_name>.cfapps.io
  buildpack: staticfile_buildpack
  env:
   APP_VERSION: green
```
Now, you can perform a zero downtime push:
```bash
cf zero-downtime-push <my_app_name> -f manifest_green.yml
```
This way the existing, old version of the app (blue version) get renamed while the route mapping to this app remains intact. Then the new application (green version) gets pushed to Cloud Foundry with the same route bindings. As soon as the green version of the app is up and running the traffic begins to be load balanced between the two applications. Finally the old application gets deleted along with the route mappings. All traffic is then directed to the new application.  
Finally, check the environment variable of the app again, it should now display the green application variable:
```bash
cf env <my_app_name>
```
At the end of this chapter delete all apps and switch to the parent directory:
```bash
cf delete <my_app_name>
cf apps
cd ..
```



[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/blue-green.html)

[Go Back](https://github.com/smichard/CNA_tutorial)
