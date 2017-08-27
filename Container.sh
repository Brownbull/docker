# Basic commands on Container level
# Components of getStarted Container
Dockerfile # Initial Setup, define what goes on in the environment inside the Container
  requirements.txt # Contains things to install via pip
  app.py # Main script

# Run conttainer in detached mode
$ docker container run --name <containerName> -e AUTHOR="Gabriel C" -d -P <containerLocation>
  #- d will create a container with the process detached from our terminal
  # -P will publish all the exposed container ports to random ports on the Docker host
  # -e is how you pass environment variables to the container
  # --name allows you to specify a container name
  # AUTHOR is the environment variable name and Your Name is the value that you can pass

# See running containers
$ docker ps
  # -a see all containers
  # -q see only CONTAINER_ID

# Build Container
$ cd "path/where/Dockerfile/is"
$ docker build -t friendlyhello . # -t put tag to the image

# Get container ports
$ docker container port <containerName>

# Remove Container
$ docker rm CONTAINER_ID
$ docker rm $(docker ps -a -q) # remove all containers
