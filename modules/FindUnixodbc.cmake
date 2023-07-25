
# UNIXODBC_HOME environment variable is used to check for UNIXODBC headers and static library

# UNIXODBC_INCLUDE_DIR: directory containing headers
# UNIXODBC_LIB_DIR: directory containing lib
# UNIXODBC_STATIC_LIB: path to odbc.a
# UNIXODBC_FOUND: whether UNIXODBC has been found

if( NOT "${UNIXODBC_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${UNIXODBC_HOME}" _unixodbc_path)
endif()

message (STATUS "UNIXODBC_HOME: ${UNIXODBC_HOME}")
set(UNIXODBC_LIB_NAME odbc)

find_path (UNIXODBC_INCLUDE_DIR unixodbc.h PATHS
  ${_unixodbc_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (UNIXODBC_LIBRARY NAMES ${UNIXODBC_LIB_NAME} HINTS
  ${_unixodbc_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (UNIXODBC_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${UNIXODBC_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_unixodbc_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (UNIXODBC_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${UNIXODBC_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_unixodbc_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (UNIXODBC_INCLUDE_DIR AND UNIXODBC_LIBRARY)
  set (UNIXODBC_FOUND TRUE)
else ()
  set (UNIXODBC_FOUND FALSE)
endif ()

if (UNIXODBC_FOUND)
  message (STATUS "Found the UNIXODBC header path UNIXODBC_INCLUDE_DIR: ${UNIXODBC_INCLUDE_DIR}")
  message (STATUS "Found the UNIXODBC lib path UNIXODBC_LIB_DIR: ${UNIXODBC_LIB_DIR}")
  message (STATUS "Found the UNIXODBC static library UNIXODBC_STATIC_LIB: ${UNIXODBC_STATIC_LIB}")
else()
  if (_unixodbc_path)
    set (UNIXODBC_ERR_MSG "Could not find UNIXODBC. Looked in ${_unixodbc_path}.")
  else ()
    set (UNIXODBC_ERR_MSG "Could not find UNIXODBC in system search paths.")
  endif ()

  if (UNIXODBC_FIND_REQUIRED)
    message (FATAL_ERROR "${UNIXODBC_ERR_MSG}")
  else ()
    message (STATUS "${UNIXODBC_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  UNIXODBC_LIB_DIR
  UNIXODBC_INCLUDE_DIR
  UNIXODBC_STATIC_LIB
)
