
# OPENSSL_HOME environment variable is used to check for OPENSSL headers and static library

# OPENSSL_INCLUDE_DIR: directory containing headers
# OPENSSL_LIB_DIR: directory containing lib
# OPENSSL_STATIC_LIB: path to ssl.a
# OPENSSL_FOUND: whether OPENSSL has been found

if( NOT "${OPENSSL_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${OPENSSL_HOME}" _ssl_path)
endif()

message (STATUS "OPENSSL_HOME: ${OPENSSL_HOME}")

set(OPENSSL_LIB_NAME ssl)

find_path (OPENSSL_INCLUDE_DIR openssl/ssl.h HINTS
  ${_ssl_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (OPENSSL_LIBRARY NAMES ssl HINTS
  ${_ssl_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (OPENSSL_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${OPENSSL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_ssl_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (OPENSSL_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${OPENSSL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_ssl_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (OPENSSL_INCLUDE_DIR AND OPENSSL_LIBRARY)
  set (OPENSSL_FOUND TRUE)
else ()
  set (OPENSSL_FOUND FALSE)
endif ()

if (OPENSSL_FOUND)
  message (STATUS "Found the OPENSSL header path OPENSSL_INCLUDE_DIR: ${OPENSSL_INCLUDE_DIR}")
  message (STATUS "Found the OPENSSL lib path OPENSSL_LIB_DIR: ${OPENSSL_LIB_DIR}")
  message (STATUS "Found the OPENSSL static library OPENSSL_STATIC_LIB: ${OPENSSL_STATIC_LIB}")
else()
  if (_ssl_path)
    set (OPENSSL_ERR_MSG "Could not find OPENSSL. Looked in ${_ssl_path}.")
  else ()
    set (OPENSSL_ERR_MSG "Could not find OPENSSL in system search paths.")
  endif ()

  if (OPENSSL_FIND_REQUIRED)
    message (FATAL_ERROR "${OPENSSL_ERR_MSG}")
  else ()
    message (STATUS "${OPENSSL_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  OPENSSL_LIB_DIR
  OPENSSL_INCLUDE_DIR
  OPENSSL_STATIC_LIB
)
