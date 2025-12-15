docker run -d -p 3307:3306 --name orders-db -e MYSQL_ROOT_PASSWORD=5up3r5tr0ng -e MYSQL_DATABASE=orders -e MYSQL_USER=dev -e MYSQL_PASSWORD=pwd --mount source=orders-db-vol,target=/var/lib/mysql orders-db-img
docker ps -a
