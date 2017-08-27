# run site
$ docker container run -d seqvence/static-site

# run conttainer in detached mode
$ docker container run --name static-site -e AUTHOR="Gabriel C" -d -p 32769:80 seqvence/static-site
  #- d will create a container with the process detached from our terminal
  # -P will publish all the exposed container ports to random ports on the Docker host
  # -e is how you pass environment variables to the container
  # --name allows you to specify a container name
  # AUTHOR is the environment variable name and Your Name is the value that you can pass

# Get container ports
$ docker container port static-site
  # Output
  443/tcp -> 0.0.0.0:32768
  80/tcp -> 0.0.0.0:32769
  # Then on this case the page is on
  http://192.168.99.100:32769/

# stop and remove container
$ docker container stop static-site
$ docker container rm static-site
