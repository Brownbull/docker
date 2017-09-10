# requirements.txt
$ python -m pip install django
$ python -m pip install psycopg2

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

# Create polls app
# go to folder where manage.py is and execute
$ python manage.py startapp polls

# you have created
polls/
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py

# DATABASE  
# First add database in settings.py file at database section
# then use migrate to create neccesary things on database
$ python manage.py migrate

# if you want to use a nw database you can crate it on pgadmin query tool like this:
CREATE DATABASE mysite
    WITH 
    OWNER = brownbull
    ENCODING = 'UTF8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

# then on settings.py on database section you can put the following:
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mysite',
        'USER': 'brownbull',
        'PASSWORD': 'password4brownbull',
        'HOST': '192.168.99.100',
        'PORT': '5432',
    }
}

# now you can go and write models in app/models.py
# example of models.py
    from django.db import models

    class Question(models.Model):
        question_text = models.CharField(max_length=200)
        pub_date = models.DateTimeField('date published')

    class Choice(models.Model):
        question = models.ForeignKey(Question, on_delete=models.CASCADE)
        choice_text = models.CharField(max_length=200)
        votes = models.IntegerField(default=0)

# so now you can isntall the appin djangoframework at mysite/settings.py
INSTALLED_APPS = [
    'polls.apps.PollsConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]

# and now you can run 
$ python manage.py makemigrations polls
# should see
    Migrations for 'polls':
    polls/migrations/0001_initial.py:
        - Create model Choice
        - Create model Question
        - Add field question to choice

# you can read what have performed at
C:\Users\final\Desktop\Git\docker\Django\project1\polls\migrations\0001_initial.py

# but none tables has been created until you execute on base of that file
$ python manage.py sqlmigrate polls 0001

# if everything is ok you should see this:
BEGIN;
--
-- Create model Choice
--
CREATE TABLE "polls_choice" (
    "id" serial NOT NULL PRIMARY KEY,
    "choice_text" varchar(200) NOT NULL,
    "votes" integer NOT NULL
);
--
-- Create model Question
--
CREATE TABLE "polls_question" (
    "id" serial NOT NULL PRIMARY KEY,
    "question_text" varchar(200) NOT NULL,
    "pub_date" timestamp with time zone NOT NULL
);
--
-- Add field question to choice
--
ALTER TABLE "polls_choice" ADD COLUMN "question_id" integer NOT NULL;
ALTER TABLE "polls_choice" ALTER COLUMN "question_id" DROP DEFAULT;
CREATE INDEX "polls_choice_7aa0f6ee" ON "polls_choice" ("question_id");
ALTER TABLE "polls_choice"
  ADD CONSTRAINT "polls_choice_question_id_246c99a640fbbd72_fk_polls_question_id"
    FOREIGN KEY ("question_id")
    REFERENCES "polls_question" ("id")
    DEFERRABLE INITIALLY DEFERRED;

COMMIT;

# after that the query must be executed
$ python manage.py migrate

# now tbales are created and you can check them by query tool on pgadmin
SELECT * FROM public.polls_choice
ORDER BY id ASC;

# remember making model changes
Change your models (in models.py).
Run python manage.py makemigrations to create migrations for those changes
Run python manage.py migrate to apply those changes to the database.

# API
# call shell
$ python manage.py shell
>>>

# Once you’re in the shell, explore the database API:
    >>> from polls.models import Question, Choice   # Import the model classes we just wrote.

    # No questions are in the system yet.
    >>> Question.objects.all()
    <QuerySet []>

    # Create a new Question.
    # Support for time zones is enabled in the default settings file, so
    # Django expects a datetime with tzinfo for pub_date. Use timezone.now()
    # instead of datetime.datetime.now() and it will do the right thing.
    >>> from django.utils import timezone
    >>> q = Question(question_text="What's new?", pub_date=timezone.now())

    # Save the object into the database. You have to call save() explicitly.
    >>> q.save()

    # Now it has an ID. Note that this might say "1L" instead of "1", depending
    # on which database you're using. That's no biggie; it just means your
    # database backend prefers to return integers as Python long integer
    # objects.
    >>> q.id
    1

    # Access model field values via Python attributes.
    >>> q.question_text
    "What's new?"
    >>> q.pub_date
    datetime.datetime(2012, 2, 26, 13, 0, 0, 775217, tzinfo=<UTC>)

    # Change values by changing the attributes, then calling save().
    >>> q.question_text = "What's up?"
    >>> q.save()

    # objects.all() displays all the questions in the database.
    >>> Question.objects.all()
    <QuerySet [<Question: Question object>]>

# you can MODIFY models during execution and apply changes from models.py

