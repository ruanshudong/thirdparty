
# CLICKHOUSE_HOME environment variable is used to check for CLICKHOUSE headers and static library

# CLICKHOUSE_INCLUDE_DIR: directory containing headers
# CLICKHOUSE_LIB_DIR: directory containing lib
# CLICKHOUSE_STATIC_LIB: path to libzstd.a
# CLICKHOUSE_FOUND: whether CLICKHOUSE has been found

if( NOT "${CLICKHOUSE_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${CLICKHOUSE_HOME}" _clickhouse_path)
endif()

message (STATUS "CLICKHOUSE_HOME: ${CLICKHOUSE_HOME}")
set(CLICKHOUSE_LIB_NAME clickhouse-cpp-lib)

find_path (CLICKHOUSE_INCLUDE_DIR client.h HINTS
  ${_clickhouse_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include/clickhouse")

find_library (CLICKHOUSE_LIBRARY NAMES clickhouse-cpp-lib HINTS
  ${_clickhouse_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (CLICKHOUSE_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${CLICKHOUSE_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_clickhouse_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (CLICKHOUSE_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${CLICKHOUSE_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_clickhouse_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (CLICKHOUSE_INCLUDE_DIR AND CLICKHOUSE_LIBRARY)
  set (CLICKHOUSE_FOUND TRUE)
else ()
  set (CLICKHOUSE_FOUND FALSE)
endif ()

if (CLICKHOUSE_FOUND)
  message (STATUS "Found the CLICKHOUSE header path CLICKHOUSE_INCLUDE_DIR: ${CLICKHOUSE_INCLUDE_DIR}")
  message (STATUS "Found the CLICKHOUSE lib path CLICKHOUSE_LIB_DIR: ${CLICKHOUSE_LIB_DIR}")
  message (STATUS "Found the CLICKHOUSE static library CLICKHOUSE_STATIC_LIB: ${CLICKHOUSE_STATIC_LIB}")
else()
  if (_clickhouse_path)
    set (CLICKHOUSE_ERR_MSG "Could not find CLICKHOUSE. Looked in ${_clickhouse_path}.")
  else ()
    set (CLICKHOUSE_ERR_MSG "Could not find CLICKHOUSE in system search paths.")
  endif ()

  if (CLICKHOUSE_FIND_REQUIRED)
    message (FATAL_ERROR "${CLICKHOUSE_ERR_MSG}")
  else ()
    message (STATUS "${CLICKHOUSE_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  CLICKHOUSE_LIB_DIR
  CLICKHOUSE_INCLUDE_DIR
  CLICKHOUSE_STATIC_LIB
)
