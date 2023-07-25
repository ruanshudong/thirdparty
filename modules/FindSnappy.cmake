
# SNAPPY_HOME environment variable is used to check for SNAPPY headers and static library

# SNAPPY_INCLUDE_DIR: directory containing headers
# SNAPPY_LIB_DIR: directory containing lib
# SNAPPY_STATIC_LIB: path to snappy.a
# SNAPPY_FOUND: whether SNAPPY has been found

if( NOT "${SNAPPY_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${SNAPPY_HOME}" _snappy_path)
endif()

message (STATUS "SNAPPY_HOME: ${SNAPPY_HOME}")
set(SNAPPY_LIB_NAME snappy)

find_path (SNAPPY_INCLUDE_DIR snappy.h HINTS
  ${_snappy_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (SNAPPY_LIBRARY NAMES snappy HINTS
  ${_snappy_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (SNAPPY_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${SNAPPY_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_snappy_path}
  PATH_SUFFIXES "lib" "lib64")


find_path (SNAPPY_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${SNAPPY_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_snappy_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (SNAPPY_INCLUDE_DIR AND SNAPPY_LIBRARY)
  set (SNAPPY_FOUND TRUE)
else ()
  set (SNAPPY_FOUND FALSE)
endif ()

if (SNAPPY_FOUND)
  message (STATUS "Found the SNAPPY header path SNAPPY_INCLUDE_DIR: ${SNAPPY_INCLUDE_DIR}")
  message (STATUS "Found the SNAPPY lib path SNAPPY_LIB_DIR: ${SNAPPY_LIB_DIR}")
  message (STATUS "Found the SNAPPY static library SNAPPY_STATIC_LIB: ${SNAPPY_STATIC_LIB}")
else()
  if (_snappy_path)
    set (SNAPPY_ERR_MSG "Could not find SNAPPY. Looked in ${_snappy_path}.")
  else ()
    set (SNAPPY_ERR_MSG "Could not find SNAPPY in system search paths.")
  endif ()

  if (SNAPPY_FIND_REQUIRED)
    message (FATAL_ERROR "${SNAPPY_ERR_MSG}")
  else ()
    message (STATUS "${SNAPPY_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  SNAPPY_LIB_DIR
  SNAPPY_INCLUDE_DIR
  SNAPPY_STATIC_LIB
)
