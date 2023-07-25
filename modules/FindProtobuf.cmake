
# PROTOBUF_HOME environment variable is used to check for PROTOBUF headers and static library

# PROTOBUF_INCLUDE_DIR: directory containing headers
# PROTOBUF_LIB_DIR: directory containing lib
# PROTOBUF_STATIC_LIB: path to protobuf.a
# PROTOBUF_FOUND: whether PROTOBUF has been found

if( NOT "${PROTOBUF_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${PROTOBUF_HOME}" _protobuf_path)
endif()

message (STATUS "PROTOBUF_HOME: ${PROTOBUF_HOME}")
set(PROTOBUF_LIB_NAME protobuf)

find_path (PROTOBUF_INCLUDE_DIR google/protobuf/message.h HINTS
  ${_protobuf_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (PROTOBUF_LIBRARY NAMES protobuf HINTS
  ${_protobuf_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (PROTOBUF_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${PROTOBUF_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_protobuf_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (PROTOBUF_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${PROTOBUF_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_protobuf_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (PROTOBUF_INCLUDE_DIR AND PROTOBUF_LIBRARY)
  set (PROTOBUF_FOUND TRUE)
else ()
  set (PROTOBUF_FOUND FALSE)
endif ()

if (PROTOBUF_FOUND)
  message (STATUS "Found the PROTOBUF header path PROTOBUF_INCLUDE_DIR: ${PROTOBUF_INCLUDE_DIR}")
  message (STATUS "Found the PROTOBUF lib path PROTOBUF_LIB_DIR: ${PROTOBUF_LIB_DIR}")
  message (STATUS "Found the PROTOBUF static library PROTOBUF_STATIC_LIB: ${PROTOBUF_STATIC_LIB}")
else()
  if (_protobuf_path)
    set (PROTOBUF_ERR_MSG "Could not find PROTOBUF. Looked in ${_protobuf_path}.")
  else ()
    set (PROTOBUF_ERR_MSG "Could not find PROTOBUF in system search paths.")
  endif ()

  if (PROTOBUF_FIND_REQUIRED)
    message (FATAL_ERROR "${PROTOBUF_ERR_MSG}")
  else ()
    message (STATUS "${PROTOBUF_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  PROTOBUF_LIB_DIR
  PROTOBUF_INCLUDE_DIR
  PROTOBUF_STATIC_LIB
)
