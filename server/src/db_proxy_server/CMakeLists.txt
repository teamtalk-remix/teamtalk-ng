cmake_minimum_required(VERSION 3.12)
PROJECT(db_proxy_server LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)
AUX_SOURCE_DIRECTORY(./business SRC_LIST)

find_package(jsoncpp CONFIG REQUIRED)
get_target_property(jsoncpp_INCLUDE_DIR jsoncpp_lib INTERFACE_INCLUDE_DIRECTORIES)

ADD_EXECUTABLE(db_proxy_server ${SRC_LIST})
target_compile_features(db_proxy_server PRIVATE cxx_std_11)
target_include_directories(db_proxy_server PRIVATE ./businiess .. ../base ../base/pb/protocol ${jsoncpp_INCLUDE_DIR} ${jsoncpp_INCLUDE_DIR}/jsoncpp)
TARGET_LINK_LIBRARIES(db_proxy_server PRIVATE pthread base protobuf-lite mysqlclient_r hiredis jsoncpp slog curl crypto)
target_link_directories(db_proxy_server PRIVATE /usr/lib64/mysql)
