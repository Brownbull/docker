# pull image
$ docker pull postgres

# create docker file from https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/
https://github.com/andreagrandi/postgresql-docker/blob/master/Dockerfile

# the build the image
$ docker build --rm=true -t brownbull/postgres1

# run container
$ docker run -i -t -p 5432:5432 brownbull/postgres1

# Graphic Interface
# install pgAdmin and restart device
https://www.pgadmin.org/download/

# Once installed just must run the container
$ docker run -d -i -t -p 5432:5432 brownbull/postgres1

# then from Dockerfile get usr and password and use it to set a new conection on pgAdmin
    # set newconection then go to Connection tab
        # Host name/address : use ip from docker console or docker inspect
        # port : default is 5432
        # username : from Dockerfile
