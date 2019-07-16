cmake_minimum_required(VERSION 3.12)
PROJECT(pushserver LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST1)
AUX_SOURCE_DIRECTORY(./socket SRC_LIST2)

ADD_EXECUTABLE(push_server ${SRC_LIST1} ${SRC_LIST2})
target_compile_features(push_server PRIVATE cxx_std_11)
target_compile_definitions(push_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
    -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
    -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(push_server PRIVATE .. ../base ../base/pb/protocol)
TARGET_LINK_LIBRARIES(push_server PRIVATE base pthread protobuf-lite ssl slog)
