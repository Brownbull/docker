# trying to follow tutorial in 
https://docs.docker.com/compose/django/#define-the-project-components

# created folder Web1
# create Dockerfile, docker-compose.yml based on brownbull/postgres1 image
# now creating django project on docker
$ docker-compose run web django-admin.py startproject project1 .
# remember to stop container on $ docker ps

# OR copy django folders and modify manage.py call
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "mysite.settings")

# then execute 
$ docker-compose build
$ docker-compose up -d

# then you must execute 
$ docker-compose run web python manage.py migrate

# create superuser
$ docker-compose run web python manage.py createsuperuser

# if everything is ok try to go the web
http://192.168.99.100:8000/admin
http://192.168.99.100:8000/polls

# ERRORS
# DisallowedHost at /admin
# go to settings.py and add host in ALLOWED_HOSTS = ['XX.XX.XX.XX']
ALLOWED_HOSTS = ['192.168.99.100']
