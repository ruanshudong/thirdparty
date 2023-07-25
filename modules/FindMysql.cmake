
# MYSQL_HOME environment variable is used to check for MYSQL headers and static library

# MYSQL_INCLUDE_DIR: directory containing headers
# MYSQL_LIB_DIR: directory containing lib
# MYSQL_STATIC_LIB: path to mysql.a
# MYSQL_FOUND: whether MYSQL has been found

if( NOT "${MYSQL_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${MYSQL_HOME}" _mysql_path)
endif()

message (STATUS "MYSQL_HOME: ${MYSQL_HOME}")

set(MYSQL_LIB_NAME mysqlclient)

find_path (MYSQL_INCLUDE_DIR mysql.h HINTS
  ${_mysql_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (MYSQL_LIBRARY NAMES mysqlclient HINTS
  ${_mysql_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (MYSQL_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${MYSQL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_mysql_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (MYSQL_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${MYSQL_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_mysql_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (MYSQL_INCLUDE_DIR AND MYSQL_LIBRARY)
  set (MYSQL_FOUND TRUE)
else ()
  set (MYSQL_FOUND FALSE)
endif ()

if (MYSQL_FOUND)
  message (STATUS "Found the MYSQL header path MYSQL_INCLUDE_DIR: ${MYSQL_INCLUDE_DIR}")
  message (STATUS "Found the MYSQL lib path MYSQL_LIB_DIR: ${MYSQL_LIB_DIR}")
  message (STATUS "Found the MYSQL static library MYSQL_STATIC_LIB: ${MYSQL_STATIC_LIB}")
else()
  if (_mysql_path)
    set (MYSQL_ERR_MSG "Could not find MYSQL. Looked in ${_mysql_path}.")
  else ()
    set (MYSQL_ERR_MSG "Could not find MYSQL in system search paths.")
  endif ()

  if (MYSQL_FIND_REQUIRED)
    message (FATAL_ERROR "${MYSQL_ERR_MSG}")
  else ()
    message (STATUS "${MYSQL_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  MYSQL_LIB_DIR
  MYSQL_INCLUDE_DIR
  MYSQL_STATIC_LIB
)
