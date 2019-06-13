# AngularDocker

Dockerizing an Angular App

Project Setup
Install the Angular CLI globally

$ npm install -g @angular/cli@7.3.9

Generate a new app:

$ ng new myapp

$ cd myapp

Add Dockerfile and nginx file into myapp.

Build the Project

docker build -t Docker_repo_path:v1 .

Then, spin up the container once the build is done:

docker run -v ${PWD}:/app -v /app/node_modules -p 4201:4200 --rm myapp:v1
