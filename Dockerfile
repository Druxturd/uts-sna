# redlock db image
FROM mysql:latest AS db

ENV MYSQL_ROOT_PASSWORD=redlock
ENV MYSQL_DATABASE=redlockdb
ENV MYSQL_USER=redlock
ENV MYSQL_PASSWORD=redlock

# create table users
RUN echo "USE redlockdb; CREATE TABLE users (ID INT PRIMARY KEY, Nama VARCHAR(255), Alamat VARCHAR(255), Jabatan VARCHAR(255));" >> /docker-entrypoint-initdb.d/init.sql

# insert dummy data to table users
RUN echo "USE redlockdb; INSERT INTO users VALUES (1, 'Wiryahadi', 'Jalan Anggrek', 'Mahasiswa'), (2, 'Gunawan', 'Jalan Syahdan', 'Mahasiswa'), (3, 'redlock-db', 'Jalan Kijang', 'Container');" >> /docker-entrypoint-initdb.d/init.sql

EXPOSE 3306

# redlock-web-2.0 image
FROM php:8.1-apache AS web

WORKDIR /var/www/html

COPY ./src /var/www/html

# install php extension to connect php web server to the mysql database
RUN docker-php-ext-install mysqli

# set owrnership 'u' and 'g' to www-data
# and remove permission to 'w' and 'x' for others
RUN chown -R www-data:www-data /var/www/html && chmod -R o-wx /var/www/html

ENV DB_HOST redlock-db-container
ENV DB_NAME redlockdb
ENV DB_USER redlock
ENV DB_PASSWORD redlock

EXPOSE 80

CMD ["apache2-foreground"]
