# Basic commands on Container level
# Components of getStarted Container
Dockerfile # Initial Setup, define what goes on in the environment inside the Container
  requirements.txt # Contains things to install via pip
  app.py # Main script

# See running containers
$ docker ps
  # -a see all containers
  # -q see only CONTAINER_ID

# Build Container
$ cd "path/where/Dockerfile/is"
$ docker build -t friendlyhello . # -t put tag to the image

# Remove Container
$ docker rm CONTAINER_ID
$ docker rm $(docker ps -a -q) # remove all containers
