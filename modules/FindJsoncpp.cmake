
# JSONCPP_HOME environment variable is used to check for JSONCPP headers and static library

# JSONCPP_INCLUDE_DIR: directory containing headers
# JSONCPP_LIB_DIR: directory containing lib
# JSONCPP_STATIC_LIB: path to libjsoncpp.a
# JSONCPP_FOUND: whether JSONCPP has been found

if( NOT "${JSONCPP_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${JSONCPP_HOME}" _jsoncpp_path)
endif()

message (STATUS "JSONCPP_HOME: ${JSONCPP_HOME}")

set(JSONCPP_LIB_NAME jsoncpp)

find_path (JSONCPP_INCLUDE_DIR json/json.h PATHS
        ${_jsoncpp_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "include")

find_library (JSONCPP_LIBRARY NAMES jsoncpp HINTS
        ${_jsoncpp_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (JSONCPP_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${JSONCPP_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_jsoncpp_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (JSONCPP_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${JSONCPP_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_jsoncpp_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (JSONCPP_INCLUDE_DIR AND JSONCPP_LIBRARY)
  set (JSONCPP_FOUND TRUE)
else ()
  set (JSONCPP_FOUND FALSE)
endif ()

if (JSONCPP_FOUND)
  message (STATUS "Found the JSONCPP header path JSONCPP_INCLUDE_DIR: ${JSONCPP_INCLUDE_DIR}")
  message (STATUS "Found the JSONCPP lib path JSONCPP_LIB_DIR: ${JSONCPP_LIB_DIR}")
  message (STATUS "Found the JSONCPP static library JSONCPP_STATIC_LIB: ${JSONCPP_STATIC_LIB}")
else()
  if (_jsoncpp_path)
    set (JSONCPP_ERR_MSG "Could not find JSONCPP. Looked in ${_jsoncpp_path}.")
  else ()
    set (JSONCPP_ERR_MSG "Could not find JSONCPP in system search paths.")
  endif ()

  if (JSONCPP_FIND_REQUIRED)
    message (FATAL_ERROR "${JSONCPP_ERR_MSG}")
  else ()
    message (STATUS "${JSONCPP_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  JSONCPP_INCLUDE_DIR
  JSONCPP_LIB_DIR
  JSONCPP_STATIC_LIB
)
