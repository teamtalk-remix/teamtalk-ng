cmake_minimum_required(VERSION 3.12)

include(GNUInstallDirs)
set(CMAKE_INSTALL_RPATH .:${CMAKE_INSTALL_FULL_LIBDIR})

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_subdirectory(slog)
add_subdirectory(base)
add_subdirectory(libsecurity/src)
add_subdirectory(login_server)
add_subdirectory(msg_server)
add_subdirectory(http_msg_server)
add_subdirectory(route_server)
add_subdirectory(db_proxy_server)
add_subdirectory(msfs)
add_subdirectory(file_server)
add_subdirectory(push_server)

install(TARGETS slog login_server msg_server http_msg_server
    route_server db_proxy_server msfs file_server push_server
  RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
