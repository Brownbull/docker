# pull image
$ docker pull postgres

# create docker files from https://www.andreagrandi.it/2015/02/21/how-to-create-a-docker-image-for-postgresql-and-persist-data/
https://github.com/andreagrandi/postgresql-docker/blob/master/Dockerfile

# the build the image
$ cd "C:\Users\final\Desktop\Git\docker\Postgres"
$ docker build --rm=true -t brownbull/postgres1 .

# run container
$ docker run -d -i -t -p 5432:5432 brownbull/postgres1

# persist Data
# install fig
$ python -m pip install fig

# on same folder of Dockerfile create docker-compose.yml
dbdata:
  image: brownbull/postgres1
  volumes:
    - /var/lib/postgresql
  command: true

db:
  image: brownbull/postgres1
  volumes_from:
    - dbdata
  ports:
    - "5432:5432"
# now you can run this with
$ docker stack deploy -c docker-compose.yml postgres01
$ docker-compose up -d
# then go to django folder and run
$ python manage.py runserver

# in case of failure
# no such image: sha256....
$ docker-compose ps
$ docker-compose rm
    
# Graphic Interface
# tips from https://stackoverflow.com/questions/25540711/docker-postgres-pgadmin-local-connection
# install pgAdmin and restart device
https://www.pgadmin.org/download/

# Once installed just must run the container
$ docker run -d -i -t -p 5432:5432 brownbull/postgres1

# then from Dockerfile get usr and password and use it to set a new conection on pgAdmin
    # set newconection then go to Connection tab
        # Host name/address : use ip from docker console or docker inspect
        # port : default is 5432
        # username : from Dockerfile
