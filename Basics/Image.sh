# Basic commands on Image level
# An Image is a builded Container
Container
  # build process
    Image

# local Docker Image registry
$ docker images
  # -a see all images

# Run Image
# online
$ docker run -p 4000:80 friendlyhello # http://192.168.99.100:4000/ -p is for publishing
# batch
docker run -d -p 4000:80 friendlyhello # -d detached mode
  # See ip content
  $ curl http://192.168.99.100:4000

# Stop Image
$ docker stop CONTAINER_ID # can be obtained from docker ps
$ docker kill CONTAINER_ID # force shutdown

# Upload Image
# login in Docker
$ docker login # put for username and password
# tag image
$ docker tag friendlyhello brownbull/get-started:part-1
# push image
$ docker push brownbull/get-started:part-1
# OPTIONAL: run image from docker
$ docker run -p 4000:80 brownbull/get-started:part-1

# Remove Image
$ docker rmi <imagename>
$ docker rmi $(docker images -q)  # remove all Images
