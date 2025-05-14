docker exec -it orders-db mysql -u dev --password=pwd -e "use orders; show tables; select count(*) from orders;"
