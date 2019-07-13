# TeamTalk-NG Server

TeamTalk-NG is an enterprise instant messaging system
forked from [Mogu TeamTalk][].

## Build from source

TeamTalk-NG Server uses CMake build system.

### Debian 10
```sh
# install build dependencies
apt install -y \
  cmake gcc g++ protobuf-compiler \
  libjsoncpp-dev liblog4cxx-dev libssl-dev libcurl4-openssl-dev libprotobuf-dev libmariadb-dev libmariadb-dev-compat libhiredis-dev
# build
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
# install
make install
```

### CentOS 7

``` sh
# ensure you have EPEL configured
yum -y install epel-release
# install build dependencies
yum -y install \
  cmake3 make gcc gcc-c++ protobuf-compiler \
  protobuf-lite-devel log4cxx-devel hiredis-devel mariadb-devel \
  libuuid-devel libcurl-devel jsoncpp-devel
# build
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
# install
make install
```

## Container Build

`Dockerfile`s and related  artifacts are located in `containers/`.

The simplest way to build TeamTalk-NG container images locally is using [Docker Compose][]. Make sure you have [Docker][] and [Docker Compose][] installed. Then run:

```sh
docker-compose build
```


## Deployment

You have multiple options to deploy the TeamTalk-NG server.

### Run containerized TeamTalk-NG server on a single host

Make sure you have [Docker][] and [Docker Compose][] installed.

- Take a look at the `docker-compose.yaml` file at the project root and configuration files of TeamTalk-NG services at `config/`, then customize anything you need.
If you need to connect outside of your host, replace the IP addresses `127.0.0.1` in `loginserver.conf` and `msgserver.conf` with the IP address of your host.
- Pull the prebuilt container images:
  ```sh
  docker-compose pull
  ```
  This is an one-time setup command, but you can rerun to update your pulled images.
  If you prefer to build container images by yourself, refer to the [Container Build](#container-build) section.
- Start MySQL server and import the database schema. This is an one-time setup unless you delete the created Docker volumes.
  ```sh
  # start the db container in the background
  docker-compose up -d db
  # open a shell session to the db container
  docker-compose exec db bash
  ## in the shell session of the `db` container, import the DB schema from /vol/db/ttopen.sql into database `teamtalk`.
  mysql -u root teamtalk < /vol/db/ttopen.sql
  ## exit from the shell session
  exit
  ```
- Start all containers in the background:
  ```sh
  docker-compose up -d
  ```
- Check if all containers are started by running:
  ```sh
  docker-compose ps
  ```
  If everything goes fine, you should see something like this:
  ```
           Name                   Command           State           Ports
  --------------------------------------------------------------------------------
  server_dashboard_1   /usr/local/bin/run-      Up      0.0.0.0:10080->8080/tc
                          httpd.sh                         p
  server_db-       ./db_proxy_server        Up      0.0.0.0:32781->10600/t
  proxy_1                                                   cp
  server_db_1      container-entrypoint     Up      0.0.0.0:32769->3306/tc
                          run-m ...                        p
  server_file_1    ./file_server            Up      0.0.0.0:8600->8600/tcp
                                                            , 0.0.0.0:32785->8601/
                                                            tcp
  server_http-     ./http_msg_server        Up      0.0.0.0:8400->8400/tcp
  msg_1
  server_login_1   ./login_server           Up      0.0.0.0:32786->8008/tc
                                                            p, 0.0.0.0:8080->8080/
                                                            tcp, 0.0.0.0:32784->81
                                                            00/tcp
  server_msfs_1    ./msfs                   Up      0.0.0.0:8700->8700/tcp
  server_msg_1     ./msg_server             Up      0.0.0.0:8000->8000/tcp
  server_push_1    ./push_server            Up      0.0.0.0:32783->8500/tc
                                                            p
  server_redis_1   container-entrypoint     Up      0.0.0.0:32771->6379/tc
                          run-redis                        p
  server_route_1   ./route_server           Up      0.0.0.0:32782->8200/tc
                                                            p
  ```
  If a container is not running, try restarting it with:
  ```
  docker-compose restart $some_service
  ```
  Because service startup order is not guaranteed in the current setup, you may encounter connection issues between `msg` and `db-proxy` services.
  Try restarting the `msg` service when it happens:
  ```sh
  docker-compose restart msg
  ```
- The web console can be accessed from http://localhost:10080. Default username and password should be `admin` and `admin`.


[Mogu TeamTalk]: https://github.com/meili/TeamTalk
