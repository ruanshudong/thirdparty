
# GPERF_HOME environment variable is used to check for GPERF headers and static library

# GPERF_INCLUDE_DIR: directory containing headers
# GPERF_LIB_DIR: directory containing lib
# GPERF_STATIC_LIB: path to libprofiler.a
# GPERF_FOUND: whether GPERF has been found

if( NOT "${GPERF_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${GPERF_HOME}" _gperf_path)
endif()

message (STATUS "GPERF_HOME: ${GPERF_HOME}")
set(GPERF_LIB_NAME profiler)

find_path (GPERF_INCLUDE_DIR gperftools/profiler.h HINTS
  ${_gperf_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (GPERF_LIBRARY NAMES ${GPERF_LIB_NAME} HINTS
        ${_gperf_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (GPERF_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${GPERF_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_gperf_path}
  PATH_SUFFIXES "lib" "lib64")


find_path (GPERF_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${GPERF_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_gperf_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (GPERF_INCLUDE_DIR AND GPERF_LIBRARY)
  set (GPERF_FOUND TRUE)
else ()
  set (GPERF_FOUND FALSE)
endif ()

if (GPERF_FOUND)
  message (STATUS "Found the GPERF header path GPERF_INCLUDE_DIR: ${GPERF_INCLUDE_DIR}")
  message (STATUS "Found the GPERF lib path GPERF_LIB_DIR: ${GPERF_LIB_DIR}")
  message (STATUS "Found the GPERF static library GPERF_LIBRARY: ${GPERF_STATIC_LIB}")
else()
  if (_gperf_path)
    set (GPERF_ERR_MSG "Could not find GPERF. Looked in ${_gperf_path}.")
  else ()
    set (GPERF_ERR_MSG "Could not find GPERF in system search paths.")
  endif ()

  if (GPERF_FIND_REQUIRED)
    message (FATAL_ERROR "${GPERF_ERR_MSG}")
  else ()
    message (STATUS "${GPERF_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  GPERF_LIB_DIR
  GPERF_INCLUDE_DIR
  GPERF_STATIC_LIB
  GPERF_LIBRARY
)
