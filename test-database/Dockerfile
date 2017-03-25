FROM mysql:5

ENV MYSQL_ROOT_PASSWORD 123
ENV MYSQL_DATABASE users
ENV MYSQL_USER users_service
ENV MYSQL_PASSWORD 123

ADD ./files/start.sh /docker-entrypoint-initdb.d
ADD ./files/setup.sql /docker-entrypoint-initdb.d
