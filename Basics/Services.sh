# Basic commands on Services level
docker-compose.yml # file that defines how Docker containers should behave in production

# Start swarn
$ docker swarn init
$ docker swarm init --advertise-addr 192.168.99.100 # init a node in swarm in docker toolbox

# Start Services
$ docker stack deploy -c docker-compose.yml getstartedlab # Run the specified Compose file
  # getstartedlab is the service name
  # http://192.168.99.100/

# See Services in an app
$ docker stack services <appname> # List the services associated with an app

# See containers relalted to a Service
$ docker stack ps getstartedlab

# Scale Services
# you can modify .yml file and rerun Start Service command, no need to kill or restart anything
$ docker stack deploy -c docker-compose.yml getstartedlab

# Shutdown Stack
$ docker stack rm getstartedlab

# Shutdown swarn
$ docker swarm leave --force
