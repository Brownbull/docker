# First get Alpine image refresh
$ docker image pull alpine

# then youcan run it
$ docker container run alpine ls -l

# Hello world
$ docker container run alpine echo "Hello from alpine"

# Run alpine shell
$ docker container run -it alpine /bin/sh # $ exit
