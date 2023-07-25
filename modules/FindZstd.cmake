
# ZSTD_HOME environment variable is used to check for ZSTD headers and static library

# ZSTD_INCLUDE_DIR: directory containing headers
# ZSTD_LIB_DIR: directory containing lib
# ZSTD_STATIC_LIB: path to libzstd.a
# ZSTD_FOUND: whether ZSTD has been found

if( NOT "${ZSTD_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${ZSTD_HOME}" _zstd_path)
endif()

message (STATUS "ZSTD_HOME: ${ZSTD_HOME}")
set(ZSTD_LIB_NAME zstd)

find_path (ZSTD_INCLUDE_DIR zstd.h HINTS
  ${_zstd_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (ZSTD_LIBRARY NAMES zstd HINTS
  ${_zstd_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (ZSTD_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${ZSTD_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_zstd_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (ZSTD_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${ZSTD_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_zstd_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (ZSTD_INCLUDE_DIR AND ZSTD_LIBRARY)
  set (ZSTD_FOUND TRUE)
else ()
  set (ZSTD_FOUND FALSE)
endif ()

if (ZSTD_FOUND)
  message (STATUS "Found the ZSTD header path ZSTD_INCLUDE_DIR: ${ZSTD_INCLUDE_DIR}")
  message (STATUS "Found the ZSTD lib path ZSTD_LIB_DIR: ${ZSTD_LIB_DIR}")
  message (STATUS "Found the ZSTD static library ZSTD_STATIC_LIB: ${ZSTD_STATIC_LIB}")
else()
  if (_zstd_path)
    set (ZSTD_ERR_MSG "Could not find ZSTD. Looked in ${_zstd_path}.")
  else ()
    set (ZSTD_ERR_MSG "Could not find ZSTD in system search paths.")
  endif ()

  if (ZSTD_FIND_REQUIRED)
    message (FATAL_ERROR "${ZSTD_ERR_MSG}")
  else ()
    message (STATUS "${ZSTD_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  ZSTD_LIB_DIR
  ZSTD_INCLUDE_DIR
  ZSTD_STATIC_LIB
)
