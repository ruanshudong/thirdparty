
# CURL_HOME environment variable is used to check for CURL headers and static library

# CURL_INCLUDE_DIR: directory containing headers
# CURL_LIB_DIR: directory containing lib
# CURL_STATIC_LIB: path to libcurl.a
# CURL_FOUND: whether CURL has been found

if( NOT "${CURL_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${CURL_HOME}" _curl_path)
endif()

message (STATUS "CURL_HOME: ${CURL_HOME}")

set(CURL_LIB_NAME curl)

find_path (CURL_INCLUDE_DIR curl/curl.h HINTS
  ${_curl_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (CURL_LIBRARY NAMES curl HINTS
        ${_curl_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (CURL_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${CURL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_curl_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (CURL_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${CURL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_curl_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (CURL_INCLUDE_DIR AND CURL_LIBRARY)
  set (CURL_FOUND TRUE)
else ()
  set (CURL_FOUND FALSE)
endif ()

if (CURL_FOUND)
  message (STATUS "Found the CURL header path CURL_INCLUDE_DIR: ${CURL_INCLUDE_DIR}")
  message (STATUS "Found the CURL lib path CURL_LIB_DIR: ${CURL_LIB_DIR}")
  message (STATUS "Found the CURL static library CURL_STATIC_LIB: ${CURL_STATIC_LIB}")
else()
  if (_curl_path)
    set (CURL_ERR_MSG "Could not find CURL. Looked in ${_curl_path}.")
  else ()
    set (CURL_ERR_MSG "Could not find CURL in system search paths.")
  endif ()

  if (CURL_FIND_REQUIRED)
    message (FATAL_ERROR "${CURL_ERR_MSG}")
  else ()
    message (STATUS "${CURL_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  CURL_INCLUDE_DIR
  CURL_LIB_DIR
  CURL_STATIC_LIB
)
