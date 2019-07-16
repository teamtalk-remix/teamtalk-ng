cmake_minimum_required(VERSION 3.12)
PROJECT(msfs LANGUAGES CXX)

AUX_SOURCE_DIRECTORY(./ SRC_LIST)

ADD_EXECUTABLE(msfs ${SRC_LIST})
target_compile_features(msfs PRIVATE cxx_std_11)
target_compile_definitions(msfs PRIVATE -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DAC_HAS_INFO
  -DAC_HAS_WARNING -DAC_HAS_ERROR -DAC_HAS_CRITICAL -DTIXML_USE_STL
  -DAC_HAS_DEBUG -DLINUX_DAEMON)
target_include_directories(msfs PRIVATE .. ../base ../base/pb/protocol)
TARGET_LINK_LIBRARIES(msfs PRIVATE pthread base slog)
