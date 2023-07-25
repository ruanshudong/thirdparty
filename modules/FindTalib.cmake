
# TALIB_HOME environment variable is used to check for TALIB headers and static library

# TALIB_INCLUDE_DIR: directory containing headers
# TALIB_LIB_DIR: directory containing lib
# TALIB_STATIC_LIB: path to libta_lib.a
# TALIB_FOUND: whether TALIB has been found

if( NOT "${TALIB_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${TALIB_HOME}" _talib_path)
endif()

message (STATUS "TALIB_HOME: ${_talib_path}")

set(TALIB_LIB_NAME ta_lib)

find_path (TALIB_INCLUDE_DIR ta-lib/ta_func.h PATHS
  ${_talib_path}/include
  NO_DEFAULT_PATH)

find_path (TALIB_LIB_DIR ${TALIB_LIB_NAME} PATHS
        ${_talib_path}
        NO_DEFAULT_PATH)

find_library (TALIB_LIBRARY NAMES ta_lib HINTS
  ${_talib_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (TALIB_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${TALIB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_talib_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (TALIB_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${TALIB_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_talib_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (TALIB_INCLUDE_DIR AND TALIB_LIBRARY)
  set (TALIB_FOUND TRUE)
else ()
  set (TALIB_FOUND FALSE)
endif ()

if (TALIB_FOUND)
  message (STATUS "Found the TALIB header path TALIB_INCLUDE_DIR: ${TALIB_INCLUDE_DIR}")
  message (STATUS "Found the TALIB lib path TALIB_LIB_DIR: ${TALIB_LIB_DIR}")
  message (STATUS "Found the TALIB static library TALIB_STATIC_LIB: ${TALIB_STATIC_LIB}")
else()
  if (_talib_path)
    set (TALIB_ERR_MSG "Could not find TALIB. Looked in ${_talib_path}.")
  else ()
    set (TALIB_ERR_MSG "Could not find TALIB in system search paths.")
  endif ()

  if (TALIB_FIND_REQUIRED)
    message (FATAL_ERROR "${TALIB_ERR_MSG}")
  else ()
    message (STATUS "${TALIB_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  TALIB_INCLUDE_DIR
  TALIB_LIB_DIR
  TALIB_STATIC_LIB
)
