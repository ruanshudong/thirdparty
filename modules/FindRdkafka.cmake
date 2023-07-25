
# RDKAFKA_HOME environment variable is used to check for RDKAFKA headers and static library

# RDKAFKA_INCLUDE_DIR: directory containing headers
# RDKAFKA_LIB_DIR: directory containing lib
# RDKAFKA_STATIC_LIB: path to rdkafka.a
# RDKAFKA_FOUND: whether RDKAFKA has been found

if( NOT "${RDKAFKA_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${RDKAFKA_HOME}" _rdkafka_path)
endif()

message (STATUS "RDKAFKA_HOME: ${RDKAFKA_HOME}")
set(RDKAFKA_LIB_NAME rdkafka)

find_path (RDKAFKA_INCLUDE_DIR rdkafka.h HINTS
  ${_rdkafka_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include/librdkafka")

find_library (RDKAFKA_LIBRARY NAMES rdkafka HINTS
  ${_rdkafka_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (RDKAFKA_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${RDKAFKA_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_rdkafka_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (RDKAFKA_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${RDKAFKA_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_rdkafka_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (RDKAFKA_INCLUDE_DIR AND RDKAFKA_LIBRARY)
  set (RDKAFKA_FOUND TRUE)
else ()
  set (RDKAFKA_FOUND FALSE)
endif ()

if (RDKAFKA_FOUND)
  message (STATUS "Found the RDKAFKA header path RDKAFKA_INCLUDE_DIR: ${RDKAFKA_INCLUDE_DIR}")
  message (STATUS "Found the RDKAFKA lib path RDKAFKA_LIB_DIR: ${RDKAFKA_LIB_DIR}")
  message (STATUS "Found the RDKAFKA static library RDKAFKA_STATIC_LIB: ${RDKAFKA_STATIC_LIB}")
else()
  if (_rdkafka_path)
    set (RDKAFKA_ERR_MSG "Could not find RDKAFKA. Looked in ${_rdkafka_path}.")
  else ()
    set (RDKAFKA_ERR_MSG "Could not find RDKAFKA in system search paths.")
  endif ()

  if (RDKAFKA_FIND_REQUIRED)
    message (FATAL_ERROR "${RDKAFKA_ERR_MSG}")
  else ()
    message (STATUS "${RDKAFKA_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  RDKAFKA_LIB_DIR
  RDKAFKA_INCLUDE_DIR
  RDKAFKA_STATIC_LIB
)
