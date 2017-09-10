# First install django 
$ python -m pip install django

# then create or goto a directory to create a project
$ cd $ProjectPath
$ mkdir $ProjectPath

# then you can create an application as follows
$ django-admin $StartProject $SiteName

# now you have created a folder with basic information
$SiteName/
    manage.py
    $SiteName/
        __init__.py
        settings.py
        urls.py
        wsgi.py

# Run development Server
# cd to $SiteName Directory
$ cd $SiteName

# run server
$ python manage.py runserver

# by default server runs at http://localhost:8000/
http://localhost:8000/

