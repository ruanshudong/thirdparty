
# GLOG_HOME environment variable is used to check for GLOG headers and static library

# GLOG_INCLUDE_DIR: directory containing headers
# GLOG_LIB_DIR: directory containing lib
# GLOG_STATIC_LIB: path to libglog.a
# GLOG_FOUND: whether GLOG has been found

if( NOT "${GLOG_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${GLOG_HOME}" _glog_path)
endif()

message (STATUS "GLOG_HOME: ${GLOG_HOME}")
set(GLOG_LIB_NAME glog)

find_path (GLOG_INCLUDE_DIR glog/logging.h HINTS
  ${_glog_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (GLOG_LIBRARY NAMES glog HINTS
        ${_glog_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (GLOG_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${GLOG_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_glog_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (GLOG_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${GLOG_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_glog_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (GLOG_INCLUDE_DIR AND GLOG_LIBRARY)
  set (GLOG_FOUND TRUE)
else ()
  set (GLOG_FOUND FALSE)
endif ()

if (GLOG_FOUND)
  message (STATUS "Found the GLOG header path GLOG_INCLUDE_DIR: ${GLOG_INCLUDE_DIR}")
  message (STATUS "Found the GLOG lib path GLOG_LIB_DIR: ${GLOG_LIB_DIR}")
  message (STATUS "Found the GLOG static library GLOG_STATIC_LIB: ${GLOG_STATIC_LIB}")
else()
  if (_glog_path)
    set (GLOG_ERR_MSG "Could not find GLOG. Looked in ${_glog_path}.")
  else ()
    set (GLOG_ERR_MSG "Could not find GLOG in system search paths.")
  endif ()

  if (GLOG_FIND_REQUIRED)
    message (FATAL_ERROR "${GLOG_ERR_MSG}")
  else ()
    message (STATUS "${GLOG_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  GLOG_INCLUDE_DIR
  GLOG_LIB_DIR
  GLOG_STATIC_LIB
)
