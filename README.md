# Introduction

This will help setup a development environment for developing Java app. We're assuming that you have an IDE installed on your laptop or PC.

# Setup the dev environment

Prerequisites
-------------
Docker and Docker-compose

git clone the repo and traverse to the root of the project, hello-dropwizard in this case.

Spin up the dev env
-------------------
```
root@ubuntu:~/hello-drop/hello-dropwizard# docker-compose up -d
Starting dropwiz ...
Starting nginx ...
Starting dropwiz
Starting nginx ... done
root@ubuntu:~/ravi/hello-drop/hello-dropwizard# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
893e960534e2        nginx               "nginx -g 'daemon of…"   12 minutes ago      Up 7 seconds        0.0.0.0:80->80/tcp   nginx
714d766dd7c7        dropwiz             "sh -c '/usr/bin/jav…"   12 minutes ago      Up 7 seconds        8080-8081/tcp        dropwiz
root@ubuntu:~/hello-drop/hello-dropwizard#
```
This will start two containers dropwiz, the app and nginx, the reverse proxy.

To bring down the env, run docker-compose down and you should see them spinning down.

```
root@ubuntu:~/hello-drop/hello-dropwizard# docker-compose down
Stopping nginx   ... done
Stopping dropwiz ... done
Removing nginx   ... done
Removing dropwiz ... done
Removing network hellodropwizard_proxy-bridge
root@ubuntu:~/hello-drop/hello-dropwizard#
```

Metrics to Graphite
-------------------
I've tried sending the metrics to Graphite by spinning up a Graphite+carbon-cache container. For some reason the app couldn't send them. So it's still WIP.
```
dropwiz    | WARN  [2019-04-14 05:50:02,751] com.codahale.metrics.graphite.GraphiteReporter: Unable to report to Graphite
dropwiz    | ! java.net.ConnectException: Connection refused (Connection refused)
dropwiz    | ! at java.net.PlainSocketImpl.socketConnect(Native Method)
```
