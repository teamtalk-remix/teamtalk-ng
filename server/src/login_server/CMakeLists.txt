cmake_minimum_required(VERSION 3.12)
project(loginserver LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)

add_executable(login_server ${SRC_LIST})
target_compile_features(login_server PRIVATE cxx_std_11)
target_compile_definitions(login_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
    -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
    -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(login_server PRIVATE ../base ../base/pb/protocol)

find_package(jsoncpp CONFIG REQUIRED)
get_target_property(jsoncpp_INCLUDE_DIR jsoncpp_lib INTERFACE_INCLUDE_DIRECTORIES)
target_include_directories(login_server PRIVATE .. ${jsoncpp_INCLUDE_DIR} ${jsoncpp_INCLUDE_DIR}/jsoncpp)

target_link_libraries(login_server PRIVATE base slog pthread protobuf-lite jsoncpp)
