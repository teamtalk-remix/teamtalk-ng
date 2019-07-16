cmake_minimum_required(VERSION 3.12)
project(routeserver LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)

ADD_EXECUTABLE(route_server ${SRC_LIST})
target_compile_features(route_server PRIVATE cxx_std_11)
target_compile_definitions(route_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
-DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
-DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(route_server PRIVATE .. ../base ../base/pb/protocol)
TARGET_LINK_LIBRARIES(route_server PRIVATE base slog protobuf-lite pthread)
