# Basic commands on Stack level
# Stack is a group of interrelated services that share dependencies

# Deploy an App on a Cluster
$ docker stack deploy -c docker-compose.yml getstartedlab # http://192.168.99.101/ or http://192.168.99.102/

# See running images on Cluster
$ docker stack ps getstartedlab

# See Services in an app
$ docker stack services <appname> # List the services associated with an app

# Shutdown an App on a Cluster
$ docker stack rm getstartedlab
