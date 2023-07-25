
# FLEX_HOME environment variable is used to check for FLEX headers and static library

# FLEX_BIN: path to flex
# FLEX_INCLUDE_DIR: path to FlexLexer.h
# FLEX_LIB_DIR: pdirectory containing lib
# FLEX_STATIC_LIB: path to libfl
# FLEX_FOUND: whether flex has been found

message (STATUS "FLEX_HOME: ${FLEX_HOME}")

if( NOT "${FLEX_HOME}" STREQUAL "")
  file (TO_CMAKE_PATH "${FLEX_HOME}" _flex_path)
endif()

set(FLEX_LIB_NAME fl)

find_path (FLEX_BIN flex HINTS
  ${_flex_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "bin")

find_path (FLEX_INCLUDE_DIR FlexLexer.h PATHS
        ${_flex_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "include")

find_library (FLEX_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${FLEX_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
        ${_flex_path}
        PATH_SUFFIXES "lib" "lib64")

find_path (FLEX_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${FLEX_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_flex_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (FLEX_INCLUDE_DIR)
  set (FLEX_FOUND TRUE)
else ()
  set (FLEX_FOUND FALSE)
endif ()

if (FLEX_FOUND)
  set(FLEX_BIN ${FLEX_BIN}/flex)
  message (STATUS "Found the FLEX bin FLEX_BIN: ${FLEX_BIN}")
  message (STATUS "Found the FLEX header path FLEX_INCLUDE_DIR: ${FLEX_INCLUDE_DIR}")
  message (STATUS "Found the FLEX lib path FLEX_LIB_DIR: ${FLEX_LIB_DIR}")
  message (STATUS "Found the FLEX static library FLEX_STATIC_LIB: ${FLEX_STATIC_LIB}")
else()
  if (_flex_path)
    set (FLEX_ERR_MSG "Could not find FLEX. Looked in ${_flex_path}.")
  else ()
    set (FLEX_ERR_MSG "Could not find FLEX in system search paths.")
  endif ()

  if (FLEX_FIND_REQUIRED)
    message (FATAL_ERROR "${FLEX_ERR_MSG}")
  else ()
    message (STATUS "${FLEX_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
    FLEX_BIN
    FLEX_INCLUDE_DIR
    FLEX_LIB_DIR
    FLEX_STATIC_LIB
)
