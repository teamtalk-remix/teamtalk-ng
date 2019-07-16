cmake_minimum_required(VERSION 3.12)
project(msgserver)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)

ADD_EXECUTABLE(msg_server ${SRC_LIST})
target_compile_features(msg_server PRIVATE cxx_std_11)
target_compile_definitions(msg_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
    -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
    -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(msg_server PRIVATE .. ../base ../base/pb/protocol)
TARGET_LINK_LIBRARIES(msg_server base protobuf-lite slog crypto pthread)
