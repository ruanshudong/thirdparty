
# SQLITE3_HOME environment variable is used to check for SQLITE3 headers and static library
# SQLITE3_LIB_DIR: directory containing lib

# SQLITE3_INCLUDE_DIR: directory containing headers
# SQLITE3_LIB_DIR: directory containing lib
# SQLITE3_STATIC_LIB: path to sqlite3.a
# SQLITE3_FOUND: whether SQLITE3 has been found

if( NOT "${SQLITE3_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${SQLITE3_HOME}" _sqlite3_path)
endif()

message (STATUS "SQLITE3_HOME: ${SQLITE3_HOME}")
set(SQLITE3_LIB_NAME sqlite3)

find_path (SQLITE3_INCLUDE_DIR sqlite3.h HINTS
  ${_sqlite3_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (SQLITE3_LIBRARY NAMES sqlite3 HINTS
  ${_sqlite3_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (SQLITE3_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${SQLITE3_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_sqlite3_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (SQLITE3_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${SQLITE3_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_sqlite3_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (SQLITE3_INCLUDE_DIR AND SQLITE3_LIBRARY)
  set (SQLITE3_FOUND TRUE)
else ()
  set (SQLITE3_FOUND FALSE)
endif ()

if (SQLITE3_FOUND)
  message (STATUS "Found the SQLITE3 header path SQLITE3_INCLUDE_DIR: ${SQLITE3_INCLUDE_DIR}")
  message (STATUS "Found the SQLITE3 lib path SQLITE3_LIB_DIR: ${SQLITE3_LIB_DIR}")
  message (STATUS "Found the SQLITE3 static library SQLITE3_STATIC_LIB: ${SQLITE3_STATIC_LIB}")
else()
  if (_sqlite3_path)
    set (SQLITE3_ERR_MSG "Could not find SQLITE3. Looked in ${_sqlite3_path}.")
  else ()
    set (SQLITE3_ERR_MSG "Could not find SQLITE3 in system search paths.")
  endif ()

  if (SQLITE3_FIND_REQUIRED)
    message (FATAL_ERROR "${SQLITE3_ERR_MSG}")
  else ()
    message (STATUS "${SQLITE3_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  SQLITE3_LIB_DIR
  SQLITE3_INCLUDE_DIR
  SQLITE3_STATIC_LIB
)
