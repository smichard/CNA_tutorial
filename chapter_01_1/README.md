## Chapter 1.1

scope

### Prerequisite

get Cloud Foundry account e. g. at [Pivotal Web Services](https://run.pivotal.io/)
login through web, create spaces  
link to Org and spaces explanation
screen shot
![Cloud_Foundry](https://github.com/smichard/CNA_tutorial/blob/master/tutorial_assets/chapter_1/cloud_foundry_spaces.JPG)
[Find More](http://docs.cloudfoundry.org/concepts/roles.html)

### 1.1.1 Connect to Cloud Foundry Instance
```bash
cf login -a https://api.run.pivotal.io
```
provide credentials and select space

### 1.1.1 Pushing an app to Cloud Foundry  
```bash
cf push <my_app_name> -b static_file_buildpack
```
you app should be available through:  
https://<my_app_name>.cfapps.io  

check status of all running apps in one space:  
```bash
cf apps
```

check status of a specific app:  
```bash
cf app <my_app_name>
```
[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/deploy-app.html)
### 1.1.2 Scaling an app
scale app by number of instances
```bash
cf scale <my_app_name> -i 5
```

scale app by increasing the memory of the application
```bash
cf scale <my_app_name> -m 128M
```

delete app with:
check status of all running apps in one space:  
```bash
cf delete <my_app_name>
```
[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/cf-scale.html)

### 1.1.3 Pushing an app to Cloud Foundry using a manifest
creating a 'manifest.yml' file, place it in the same folder
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
this manifest will push the app with the name <my_app_name> to Cloud Foundry with a memory of 64M for each application, in total two instances are spun up  

use './update_script.sh' to perform changes and perform 'cf push' again. the app gets pushed a second time, this involves building the droplet and spinning up the app again. this procedure -> downtime

[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/manifest.html)

### blue / green deployment with zero downtime push
to perform zero downtime push we need a plugin to the CF CLI, download the latest version from [GitHub](https://github.com/contraband/autopilot/releases)
```bash
cf install-plugin <path_to_downloaded_binary>
```
add an environment variable to the manifest created earlier
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
perform 'cf push' again and check that the environment variable has been set
```bash
cf env <my_app_name>
```
use './update_script.sh' to perform changes and create a second manifest file called 'manifest_green.yml' and place it in the same folder,
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
perform zero downtime push, the application (green version) gets pushed to Cloud Foundry, once running the route connected to same app, route to disconnected from blue version, blue version gets deleted
```bash
cf zero-downtime-push <my_app_name> -f manifest_green.yml
```
[Find More](http://docs.cloudfoundry.org/devguide/deploy-apps/blue-green.html)

[Go Back](https://github.com/smichard/CNA_tutorial)
