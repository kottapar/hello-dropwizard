# Introduction

This will help setup a development environment for developing Java apps. We're assuming that you have an IDE installed on your laptop or PC.

# Setup the dev environment

Prerequisites
-------------
1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html)
3. Download and extract the latest source of this project

Creating the VM
---------------
1. Change your path to the project directory (`cd hello-dropwizard`)
2. If you're in windows extract the zip package and navigate to this dir
3. Linux or Mac: Execute `setupdev.sh`
4. Windows: Execute `setupdev-windows.bat`
5. Once the VM is created run `vagrant ssh` to login to the VM.
6. The project directory will be mounted as `/vagrant`

Note: The first time you run this, it will take some time to provision the VM. Subsequent runs will be quick.

Starting the app
----------------
1. Navigate to the project directory in the VM `cd /vagrant`
2. Run `docker-compose up -d` to spin up the docker containers with the app
```
vagrant@devhost:/vagrant$ docker-compose up -d
Starting dropwiz ...
Starting nginx ...
Starting dropwiz
Starting nginx ... done
vagrant@devhost:/vagrant$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
893e960534e2        nginx               "nginx -g 'daemon of…"   12 minutes ago      Up 7 seconds        0.0.0.0:80->80/tcp   nginx
714d766dd7c7        dropwiz             "sh -c '/usr/bin/jav…"   12 minutes ago      Up 7 seconds        8080-8081/tcp        dropwiz

```
This will start two containers `dropwiz`, the app and `nginx`, the reverse proxy.

Stopping the app
----------------
1. Run `docker-compose down` to stop the containers.

```
root@ubuntu:~/hello-drop/hello-dropwizard# docker-compose down
Stopping nginx   ... done
Stopping dropwiz ... done
Removing nginx   ... done
Removing dropwiz ... done
Removing network hellodropwizard_proxy-bridge
root@ubuntu:~/hello-drop/hello-dropwizard#
```
