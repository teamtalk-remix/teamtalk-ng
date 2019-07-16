cmake_minimum_required(VERSION 3.12)
project(security LANGUAGES CXX)
AUX_SOURCE_DIRECTORY(. SRC_LIST)

ADD_LIBRARY(security SHARED ${SRC_LIST})
target_include_directories(security PRIVATE ../include)
target_compile_definitions(security PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
 -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
 -DAC_HAS_DEBUG -DLINUX_DAEMON -DSERVER)
