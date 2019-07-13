FROM docker.io/centos:7 AS builder

# install build dependencies
RUN yum -y install epel-release && yum clean all
RUN yum -y --setopt=skip_missing_names_on_install=0 install \
  wget cmake3 make gcc gcc-c++ protobuf-compiler \
  protobuf-lite-devel log4cxx-devel hiredis-devel mariadb-devel \
  libuuid-devel libcurl-devel jsoncpp-devel \
  && yum clean all
ENV CMAKE=cmake3

# Copy source files
RUN mkdir -p /usr/local/src/teamtalk
ADD . /usr/local/src/teamtalk/
WORKDIR /usr/local/src/teamtalk/server

# build TeamTalk server with -DCMAKE_BUILD_TYPE=Release
RUN mkdir -p ./build \
  && cd ./build \
  && $CMAKE -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/teamtalk .. \
  && make \
  && make install

# build the resulting image
FROM docker.io/centos:7
LABEL name="teamtalk-cloud" \
  description="experimental cloud-native TeamTalk distribution" \
  maintainer="Yuxiang Zhu <vfreex@gmail.com>"
RUN yum -y install epel-release && yum clean all
RUN yum -y --setopt=skip_missing_names_on_install=0 install less \
  protobuf-lite log4cxx mariadb-libs hiredis libuuid jsoncpp &&\
  yum clean all
COPY --from=builder /opt/teamtalk/ /opt/teamtalk/
WORKDIR /opt/teamtalk/
ENV PATH=/opt/teamtalk/bin:$PATH
