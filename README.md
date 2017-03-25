# worker-docker-microservice 
This project sets up a simple node.js microservice running in a docker container, interacting with a mysql database.

# Pre-requisites

You must have Docker installed for this code to work! Check the [Installation Guide](https://docs.docker.com/engine/installation/) if you haven't got it installed.

# Database Setup 
If you have a mysql database ready please create the tables required for the node.js application. We will setup this applicaiton later in the doc.


```bash
cd ./test-database/files
mysql -h <DATABASE_HOST> -u<user> -p<passwd> < setup.sql
```
A test database container is also provided. 

Test database docker container setup

```bash
cd ./test-database
./build.sh					#builds the test database docker image 
./start-db-container.sh <version_number>        # starts the database container	
```
How to stop and remove the test databse base docker container.
```bash
docker stop db
docker rm db
```

# Worker App setup
Worker app will be running in a docker container, and will take database connection information as input ( as environment variables)

```bash
cd ./worker-service
build.sh 					#This will build the worker-app docker image
./start-web-app.sh <version_number>             #This will start/run the worker-app docker image in a container
```
Worker app is a node js app that is exposed at http://localhost:8123 with 2 working endpoints : /users, /search?email..
This app interacts with a mysql database to get data to populate the search results.

How to stop and remove the worker app docker container

```bash
docker stop worker-app
docker rm worker-app
```
# Test
To test the entire setup:
1. Make sure the test database container or your own mysql server is running and is setup with the test tables in ```./test-database/files/setup.sql``` file.
2. Make sure the worker node js app docker container is running.
```bash
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                    NAMES
97a4c29dc12d        sample-node-app-v1   "node /app/index.js"     30 minutes ago      Up 30 minutes       0.0.0.0:8123->8123/tcp   worker-app
5c245804000c        sample-db-v3         "docker-entrypoint.sh"   3 hours ago         Up 3 hours          0.0.0.0:3306->3306/tcp   db
```
To test
```bash
cd ./test
./test.sh <base_url>  				#example ./test.sh http://localhost
temp$ ./test.sh http://localhost		#sample test run
Test Passed: list users
Test Passed: search users
```
# Future/Advance work ( suggested work , not tested )
If you want to compose the entire stack into one using Docker compose, docker-compose.yml file is also provided here.
Please instal [Docker Compose](https://docs.docker.com/compose/install/) before proceeding with docker compose
```bash
version: '2'
services:
  worker-service:
    build: ./worker-service
    container_name: worker-app
    ports:
     - "8123:8123"
    environment:
     - DATABASE_HOST= localhost
     - DATABASE_NAME=users
     - DATABASE_USER=users_service
     - DATABASE_PORT=3306
  db:
    build: ./test-database
```
Now build and run your container with :
```
docker-compose build				# this will build the containers defined in docker-compose.yml
docker-compose up 				# this will start the containers
```
Now you can run test.sh to test the stack the same way.


