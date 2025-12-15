# Create a local docker container with MySql 8.2 and a sample database

- `dump.sql` contains data taken from our live system in Korea but has sensitive data removed
- When the container first starts the `dump.sql` is extracted from dump.sql.qz and then runs to create database named `orders`

## Build container

```
 ./1_build.sh
[+] Building 1.6s (8/8) FINISHED                                                                                                                                                                                                                                                             docker:desktop-linux
 => [internal] load build definition from dockerfile  0.0s
 => => transferring dockerfile: 0.0s
 => [internal] load metadata for docker.io/library/mysql:8.2                                                                                                                                                                                                                                                 1.5s
 => [auth] library/mysql:pull token for registry-1.docker.io                                                                                                                                                                                                                                                 0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                                                                                            0.0s
 => => transferring context: 2B                                                                                                                                                                                                                                                                              0.0s
 => [internal] load build context                                                                                                                                                                                                                                                                            0.0s
 => => transferring context: 35B                                                                                                                                                                                                                                                                             0.0s
 => [1/2] FROM docker.io/library/mysql:8.2@sha256:212fe73edca5df6ff14826d5eb975c914bfb91f82a2e923f9050568f99525da1                                                                                                                                                                                           0.0s
 => CACHED [2/2] COPY dump.sql.gz /docker-entrypoint-initdb.d/                                                                                                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                                                                                                                                                       0.0s
 => => exporting layers                                                                                                                                                                                                                                                                                      0.0s
 => => writing image sha256:8b82c78615faefeec7bfe0c47704947a6578a4b1b1043ebb5e2c87790557c113                                                                                                                                                                                                                 0.0s
 => => naming to docker.io/library/orders-db-img                                                                                                                                                                                                                                                             0.0s

 2 warnings found (use docker --debug to expand):
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data (ARG "MYSQL_PASSWORD") (line 7)
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data (ENV "MYSQL_PASSWORD") (line 11)

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/6vvd0wtilowbmz1qj0a9p39zy

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview
```

## Run container

N.B. you may want to check first if you are using port 3399 already before you run this script.
You can change the external port used in the 2_run.sh if you are already using port 3399

```
./2_run.sh
3d4375698243059f54f9db478aa5bb803f4f4d8ef9e93148a4dc58ad31780889
CONTAINER ID   IMAGE           COMMAND                  CREATED                  STATUS                  PORTS                                         NAMES
3d4375698243   orders-db-img   "docker-entrypoint.s…"   Less than a second ago   Up Less than a second   0.0.0.0:3307->3306/tcp, [::]:3307->3306/tcp   orders-db
```

## Verify database `orders` is running inside the container

It takes some time for the import of the data inside the mysql docker container from the dump.sql.gz into the orders dataabse
You can check the progress by running the following script.

```
./3_connect.sh
```

### When you see something like the following then wait and try the command again

```
./3_connect.sh
mysql: [Warning] Using a password on the command line interface can be insecure.
| Tables_in_orders |
+------------------+
| categories |
| countries |
| coupon_usages |
| coupons |
| customers |
+------------------+
ERROR 1146 (42S02) at line 1: Table 'orders.orders' doesn't exist
```

### When it is completes you will see the order count 8345 as shown below:

```
./3_connect.sh
mysql: [Warning] Using a password on the command line interface can be insecure.
+------------------------------------+
| Tables_in_orders |
+------------------------------------+
| categories |
| countries |
| coupon_usages |
| coupons |
| customers |
| food_courts |
| grouped_texts |
| inventory_items |
| inventory_transactions |
| locales |
| menu_option_choice_to_menu_options |
| menu_option_choices |
| menu_option_to_menus |
| menu_options |
| menu_to_inventory_items |
| menus |
| order_items |
| orders |
+------------------------------------+
+----------+
| count(\*) |
+----------+
| 8345 |
+----------+
```

## Databae diagram

![Orders Diagram](orders.png)

## clean up

If you want to remove the docker images, container and volumes you can run `cleanup.sh`:

```
./cleanup.sh
orders-db
orders-db
Untagged: orders-db-img:latest
Deleted: sha256:8b82c78615faefeec7bfe0c47704947a6578a4b1b1043ebb5e2c87790557c113
orders-db-vol
```
