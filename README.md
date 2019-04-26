# Introduction

This project sets up a development environment using Vagrant and Docker for developing Java apps. We're assuming that you have an IDE installed on your laptop or PC.

# Setup the dev environment

Prerequisites
-------------
1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html)
3. Download and extract the latest source of this project

Creating the VM
---------------
1. Change your path to the project directory (`cd hello-dropwizard`)
2. If you're in windows extract the zip package and navigate to the dir `hello-dropwizard`
3. **Linux or Mac**: Execute `setupdev.sh`
4. **Windows**: Execute `setupdev-windows.bat`
   - This script installs the `vagrant-vbguest` plugin - keeps the VM's guest-additions up-to-date.
   - It runs `export VAGRANT_CWD=./vagrants` or `SET VAGRANT_CWD=./vagrants` to set the path to the Vagrantfile.
   - It then runs the `vagrant up` command to spin up the VM.
5. Once the VM is created run `vagrant ssh` to login to the VM.
6. The project directory will be mounted as `/vagrant`
7. Configuration for the VM can be edited by modifying the values in `vagrants/vmconfig.yml`

Note: The first run will take time as it will download the base VM image and installs the packages. Subsequent runs will be quick.

Starting the app
----------------
1. Run `vagrant ssh` and navigate to the project directory in the VM `cd /vagrant`
2. If this is the first run then the docker image has to be created for the app. 
   - Run `docker build -t dropwiz --build-arg artifactid=hello-dropwizard --build-arg artver=1.0 .`
   - This uses the `Dockerfile` to build the image for our app.
   - `artifactid` and `artver` are the arguments it uses to create the application jar file `hello-dropwizard-1.0-SNAPSHOT.jar`
   - Feel free to change these values to build newer image versions.
3. Run `docker images` to list and verify that the image is created
4. Run `docker-compose up -d` to spin up the docker containers.
   - This will use the `docker-compose.yml` file to create services `dropwiz` and `ngproxy` using the app image we just created and nginx image.

```
vagrant@devhost:/vagrant$ docker-compose up -d
Creating network "vagrant_proxy-bridge" with the default driver
Pulling ngproxy (nginx:latest)...
latest: Pulling from library/nginx
27833a3ba0a5: Pull complete
ea005e36e544: Pull complete
d172c7f0578d: Pull complete
Digest: sha256:e71b1bf4281f25533cf15e6e5f9be4dac74d2328152edf7ecde23abc54e16c1c
Status: Downloaded newer image for nginx:latest
Creating nginx ...
Creating dropwiz ...
Creating nginx
Creating nginx ... done

vagrant@devhost:/vagrant$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                NAMES
cba79308c8ef        nginx               "nginx -g 'daemon of…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   nginx
d3c10118b3f2        dropwiz             "sh -c '/usr/bin/jav…"   About a minute ago   Up About a minute   8080-8081/tcp        dropwiz
vagrant@devhost:/vagrant$
```

Stopping the app
----------------
1. Run `docker-compose down` to stop the containers.

Saving and restoring image
--------------------------
1. If you intend to destroy the VM and recreate it or share the app locally without uploading to a repository, then you can save the app image.
2. Navigate to `/vagrant` in the VM and run `docker save dropwiz > dropwiz-v1.0.tar` to save the image.
3. The image will be saved as /vagrant/dropwiz-v1.0.tar on the host system.
4. This can then be shared and loaded on another VM using `docker load < dropwiz-v1.0.tar`

Stop, suspend or recreate the VM
--------------------------------
Run `export VAGRANT_CWD=./vagrants` or `SET VAGRANT_CWD=./vagrants` if your host is linux/mac or windows respectively.

Stop the VM
-----------
1. To shutdown the OS and stop the VM run `vagrant halt`. Run `vagrant up` to start.
2. If you want something similar to hibernate in windows, then just run `vagrant suspend`

destroying and recreating the VM
--------------------------------
1. If you want to completely remove the VM and recreate it then run `vagrant destroy`
2. `Ctrl+D` to exit the VM to your host machine
3. Run `vagrant destroy` to destroy this VM
4. Run `setupdev.sh` or `setupdev-windows.sh` to start all over again.





