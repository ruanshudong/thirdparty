
# ZLIB_HOME environment variable is used to check for ZLIB headers and static library

# ZLIB_INCLUDE_DIR: directory containing headers
# ZLIB_LIB_DIR: directory containing lib
# ZLIB_STATIC_LIB: path to libzlib.a
# ZLIB_FOUND: whether ZLIB has been found

if( NOT "${ZLIB_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${ZLIB_HOME}" _zlib_path)
endif()

message (STATUS "ZLIB_HOME: ${ZLIB_HOME}")
set(ZLIB_LIB_NAME z)

find_path (ZLIB_INCLUDE_DIR zlib.h HINTS
  ${_zlib_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (ZLIB_LIBRARY NAMES z HINTS
  ${_zlib_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (ZLIB_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${ZLIB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_zlib_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (ZLIB_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${ZLIB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_zlib_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (ZLIB_INCLUDE_DIR AND ZLIB_LIBRARY)
  set (ZLIB_FOUND TRUE)
else ()
  set (ZLIB_FOUND FALSE)
endif ()

if (ZLIB_FOUND)
  message (STATUS "Found the ZLIB header path ZLIB_INCLUDE_DIR: ${ZLIB_INCLUDE_DIR}")
  message (STATUS "Found the ZLIB lib path ZLIB_LIB_DIR: ${ZLIB_LIB_DIR}")
  message (STATUS "Found the ZLIB static library ZLIB_STATIC_LIB: ${ZLIB_STATIC_LIB}")
else()
  if (_zlib_path)
    set (ZLIB_ERR_MSG "Could not find ZLIB. Looked in ${_zlib_path}.")
  else ()
    set (ZLIB_ERR_MSG "Could not find ZLIB in system search paths.")
  endif ()

  if (ZLIB_FIND_REQUIRED)
    message (FATAL_ERROR "${ZLIB_ERR_MSG}")
  else ()
    message (STATUS "${ZLIB_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  ZLIB_LIB_DIR
  ZLIB_INCLUDE_DIR
  ZLIB_STATIC_LIB
)
