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
    >>> from polls.models import Question, Choice

    # Make sure our __str__() addition worked.
    >>> Question.objects.all()
    <QuerySet [<Question: What's up?>]>

    # Django provides a rich database lookup API that's entirely driven by
    # keyword arguments.
    >>> Question.objects.filter(id=1)
    <QuerySet [<Question: What's up?>]>
    >>> Question.objects.filter(question_text__startswith='What')
    <QuerySet [<Question: What's up?>]>

    # Get the question that was published this year.
    >>> from django.utils import timezone
    >>> current_year = timezone.now().year
    >>> Question.objects.get(pub_date__year=current_year)
    <Question: What's up?>

    # Request an ID that doesn't exist, this will raise an exception.
    >>> Question.objects.get(id=2)
    Traceback (most recent call last):
        ...
    DoesNotExist: Question matching query does not exist.

    # Lookup by a primary key is the most common case, so Django provides a
    # shortcut for primary-key exact lookups.
    # The following is identical to Question.objects.get(id=1).
    >>> Question.objects.get(pk=1)
    <Question: What's up?>

    # Make sure our custom method worked.
    >>> q = Question.objects.get(pk=1)
    >>> q.was_published_recently()
    True

    # Give the Question a couple of Choices. The create call constructs a new
    # Choice object, does the INSERT statement, adds the choice to the set
    # of available choices and returns the new Choice object. Django creates
    # a set to hold the "other side" of a ForeignKey relation
    # (e.g. a question's choice) which can be accessed via the API.
    >>> q = Question.objects.get(pk=1)

    # Display any choices from the related object set -- none so far.
    >>> q.choice_set.all()
    <QuerySet []>

    # Create three choices.
    >>> q.choice_set.create(choice_text='Not much', votes=0)
    <Choice: Not much>
    >>> q.choice_set.create(choice_text='The sky', votes=0)
    <Choice: The sky>
    >>> c = q.choice_set.create(choice_text='Just hacking again', votes=0)

    # Choice objects have API access to their related Question objects.
    >>> c.question
    <Question: What's up?>

    # And vice versa: Question objects get access to Choice objects.
    >>> q.choice_set.all()
    <QuerySet [<Choice: Not much>, <Choice: The sky>, <Choice: Just hacking again>]>
    >>> q.choice_set.count()
    3

    # The API automatically follows relationships as far as you need.
    # Use double underscores to separate relationships.
    # This works as many levels deep as you want; there's no limit.
    # Find all Choices for any question whose pub_date is in this year
    # (reusing the 'current_year' variable we created above).
    >>> Choice.objects.filter(question__pub_date__year=current_year)
    <QuerySet [<Choice: Not much>, <Choice: The sky>, <Choice: Just hacking again>]>

    # Let's delete one of the choices. Use delete() for that.
    >>> c = q.choice_set.filter(choice_text__startswith='Just hacking')
    >>> c.delete()

# Django Admin
# create admin
$ python manage.py createsuperusers
    user : brownbull
    pass : o92823...


