# Windows Setup
install docker toolbox from https://docs.docker.com/toolbox/overview/

# Open docker
# Hello world
$ docker run hello-world

# check version
$ docker --version

# Docker infrastucture
Stack # defines interactions of all the Services
  Swarm #
    Services # defines how Images behave in production
      Image # builded Container
        Container # contain app, code and dependencies
