# TeamTalk-NG Server

TeamTalk-NG is an enterprise instant messaging system
forked from [Mogu TeamTalk][].

## Build

TeamTalk-NG Server uses CMake build system.

## Debian 10
```sh
# install build dependencies
apt install -y cmake gcc g++ protobuf-compiler \
 libjsoncpp-dev liblog4cxx-dev libssl-dev libcurl4-openssl-dev libprotobuf-dev libmariadb-dev libmariadb-dev-compat libhiredis-dev
# build
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
# install
make install
```

## CentOS 7

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

[Mogu TeamTalk]: https://github.com/meili/TeamTalk
