
# ROCKSDB_HOME environment variable is used to check for ROCKSDB headers and static library

# ROCKSDB_INCLUDE_DIR: directory containing headers
# ROCKSDB_LIB_DIR: directory containing lib
# ROCKSDB_STATIC_LIB: path to rocksdb.a
# ROCKSDB_FOUND: whether ROCKSDB has been found

if( NOT "${ROCKSDB_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${ROCKSDB_HOME}" _rocksdb_path)
endif()

message (STATUS "ROCKSDB_HOME: ${ROCKSDB_HOME}")
set(ROCKSDB_LIB_NAME rocksdb)

find_path (ROCKSDB_INCLUDE_DIR rocksdb/db.h HINTS
  ${_rocksdb_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (ROCKSDB_LIBRARY NAMES rocksdb HINTS
  ${_rocksdb_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (ROCKSDB_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${ROCKSDB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_rocksdb_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (ROCKSDB_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${ROCKSDB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_rocksdb_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (ROCKSDB_INCLUDE_DIR AND ROCKSDB_LIBRARY)
  set (ROCKSDB_FOUND TRUE)
else ()
  set (ROCKSDB_FOUND FALSE)
endif ()

if (ROCKSDB_FOUND)
  message (STATUS "Found the ROCKSDB header path ROCKSDB_INCLUDE_DIR: ${ROCKSDB_INCLUDE_DIR}")
  message (STATUS "Found the ROCKSDB lib path ROCKSDB_LIB_DIR: ${ROCKSDB_LIB_DIR}")
  message (STATUS "Found the ROCKSDB static library ROCKSDB_STATIC_LIB: ${ROCKSDB_STATIC_LIB}")
else()
  if (_rocksdb_path)
    set (ROCKSDB_ERR_MSG "Could not find ROCKSDB. Looked in ${_rocksdb_path}.")
  else ()
    set (ROCKSDB_ERR_MSG "Could not find ROCKSDB in system search paths.")
  endif ()

  if (ROCKSDB_FIND_REQUIRED)
    message (FATAL_ERROR "${ROCKSDB_ERR_MSG}")
  else ()
    message (STATUS "${ROCKSDB_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  ROCKSDB_LIB_DIR
  ROCKSDB_INCLUDE_DIR
  ROCKSDB_STATIC_LIB
  ROCKSDB_LIBRARY
)
