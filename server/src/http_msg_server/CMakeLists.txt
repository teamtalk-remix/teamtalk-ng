cmake_minimum_required(VERSION 3.12)
project(http_msg_server LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)

find_package(jsoncpp CONFIG REQUIRED)
get_target_property(jsoncpp_INCLUDE_DIR jsoncpp_lib INTERFACE_INCLUDE_DIRECTORIES)

ADD_EXECUTABLE(http_msg_server ${SRC_LIST})
target_compile_features(http_msg_server PRIVATE cxx_std_11)
target_compile_definitions(http_msg_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
    -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
    -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(http_msg_server PRIVATE .. ../base ../base/pb/protocol
    ${jsoncpp_INCLUDE_DIR} ${jsoncpp_INCLUDE_DIR}/jsoncpp)
target_link_libraries(http_msg_server base protobuf-lite slog jsoncpp pthread)
