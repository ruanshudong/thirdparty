
# GMSSL_HOME environment variable is used to check for GMSSL headers and static library

# GMSSL_INCLUDE_DIR: directory containing headers
# GMSSL_LIB_DIR: directory containing lib
# GMSSL_STATIC_LIB: path to libssl.a
# GMSSL_FOUND: whether GMSSL has been found

if( NOT "${GMSSL_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${GMSSL_HOME}" _gmssl_path)
endif()

message (STATUS "GMSSL_HOME: ${GMSSL_HOME}")
set(GMSSL_LIB_NAME ssl)

find_path (GMSSL_INCLUDE_DIR openssl/ssl.h HINTS
  ${_gmssl_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (GMSSL_LIBRARY NAMES ssl HINTS
        ${_gmssl_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (GMSSL_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${GMSSL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_gmssl_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (GMSSL_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${GMSSL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_gmssl_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (GMSSL_INCLUDE_DIR AND GMSSL_LIBRARY)
  set (GMSSL_FOUND TRUE)
else ()
  set (GMSSL_FOUND FALSE)
endif ()

if (GMSSL_FOUND)
  message (STATUS "Found the GMSSL header path GMSSL_INCLUDE_DIR: ${GMSSL_INCLUDE_DIR}")
  message (STATUS "Found the GMSSL lib path GMSSL_LIB_DIR: ${GMSSL_LIB_DIR}")
  message (STATUS "Found the GMSSL static library GMSSL_STATIC_LIB: ${GMSSL_STATIC_LIB}")
else()
  if (_gmssl_path)
    set (GMSSL_ERR_MSG "Could not find GMSSL. Looked in ${_gmssl_path}.")
  else ()
    set (GMSSL_ERR_MSG "Could not find GMSSL in system search paths.")
  endif ()

  if (GMSSL_FIND_REQUIRED)
    message (FATAL_ERROR "${GMSSL_ERR_MSG}")
  else ()
    message (STATUS "${GMSSL_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  GMSSL_LIB_DIR
  GMSSL_INCLUDE_DIR
  GMSSL_STATIC_LIB
)
