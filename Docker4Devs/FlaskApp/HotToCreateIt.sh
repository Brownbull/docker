# We’ll do this by first pulling together the components for a random cat picture generator built with Python Flask, then dockerizing it by writing a Dockerfile. Finally, we’ll build the image, and then run it.
# Create FlaskApp dorectpry
# Create app.y
http://training.play-with-docker.com/webapps/#apppy
# Create requirements.txt
http://training.play-with-docker.com/webapps/#requirementstxt
# Create templates/Index.html
http://training.play-with-docker.com/webapps/#templatesindexhtml
# Create Dockerfile
http://training.play-with-docker.com/webapps/#232-write-a-dockerfile

# then Build the imgae
$ docker image build -t brownbull/flaskapp .

# run conttainer in detached mode
$ docker container run --name flaskapp -e AUTHOR="Gabriel C" -d -p 8888:5000 brownbull/flaskapp
