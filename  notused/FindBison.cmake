
# BISON_HOME environment variable is used to check for LZ4 headers and static library

# BISON_BIN: path to bison
# BISON_LIB_DIR: path to liby
# BISON_FOUND: whether bison has been found

message (STATUS "BISON_HOME: ${BISON_HOME}")

if( NOT "${BISON_HOME}" STREQUAL "")
  file (TO_CMAKE_PATH "${BISON_HOME}" _bison_path)
endif()

set(BISON_LIB_NAME y)

find_path (BISON_BIN bison HINTS
  ${_bison_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "bin")

find_library (BISON_LIBRARY NAMES liby HINTS
  ${_bison_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (BISON_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${BISON_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_bison_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (BISON_BIN)
  set (BISON_FOUND TRUE)
else ()
  set (BISON_FOUND FALSE)
endif ()

if (BISON_FOUND)
  set(BISON_BIN ${BISON_BIN}/bison)
  message (STATUS "Found the bison BISON_BIN: ${BISON_BIN}")
  message (STATUS "Found the bison lib path BISON_LIB_DIR: ${BISON_LIB_DIR}")
else()
  if (_bison_path)
    set (BISON_ERR_MSG "Could not find bison. Looked in ${_bison_path}.")
  else ()
    set (BISON_ERR_MSG "Could not find bison in system search paths.")
  endif ()

  if (BISON_FIND_REQUIRED)
    message (FATAL_ERROR "${BISON_ERR_MSG}")
  else ()
    message (STATUS "${BISON_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
   BISON_BIN
   BISON_LIB_DIR
)
