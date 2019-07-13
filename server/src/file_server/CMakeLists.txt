cmake_minimum_required(VERSION 3.12)
PROJECT(fileserver LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST1)

ADD_EXECUTABLE(file_server ${SRC_LIST1})
target_compile_features(file_server PRIVATE cxx_std_11)
target_compile_definitions(file_server PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
    -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
    -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(file_server PRIVATE ../ ../base ../base/pb/protocol)
TARGET_LINK_LIBRARIES(file_server PRIVATE pthread base protobuf-lite uuid slog)
