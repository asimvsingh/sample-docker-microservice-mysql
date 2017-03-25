# worker-docker-microservice

This project sets up a simple node.js microservice running in a docker container, interacting with a mysql database.
For more info please visit [Application used from this site http://www.dwmkerr.com/learn-docker-by-building-a-microservice ]

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
# Worker App setup
Worker app will be running in a docker container, and will take database connection information as input ( as environment variables)

```bash
cd ./worker-service
build.sh 					#This will build the worker-app docker image
./start-web-app.sh <version_number>             #This will start/run the worker-app docker image in a container
```
Worker app is a node js app that is exposed at http://localhost:8123 with 2 working endpoints : /users, /search?email..
This app interacts with a mysql database to get data to populate the search results.

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
```
