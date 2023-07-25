
# GFLAG_HOME environment variable is used to check for GFLAG headers and static library

# GFLAG_INCLUDE_DIR: directory containing headers
# GFLAG_LIB_DIR: directory containing lib
# GFLAG_STATIC_LIB: path to libgflags.a
# GFLAG_FOUND: whether GFLAG has been found

if( NOT "${GFLAG_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${GFLAG_HOME}" _gflag_path)
endif()

message (STATUS "GFLAG_HOME: ${GFLAG_HOME}")

set(GFLAG_LIB_NAME gflags)

find_path (GFLAG_INCLUDE_DIR gflags/gflags.h HINTS
  ${_gflag_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (GFLAG_LIBRARY NAMES gflags HINTS
        ${_gflag_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (GFLAG_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${GFLAG_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_gflag_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (GFLAG_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${GFLAG_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_gflag_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (GFLAG_INCLUDE_DIR AND GFLAG_LIBRARY)
  set (GFLAG_FOUND TRUE)
else ()
  set (GFLAG_FOUND FALSE)
endif ()

if (GFLAG_FOUND)
  message (STATUS "Found the GFLAG header path GFLAG_LIB_DIR: ${GFLAG_INCLUDE_DIR}")
  message (STATUS "Found the GFLAG lib path GFLAG_INCLUDE_DIR: ${GFLAG_LIB_DIR}")
  message (STATUS "Found the GFLAG library GFLAG_STATIC_LIB: ${GFLAG_LIBRARY}")
  message (STATUS "Found the GFLAG static library GFLAG_LIBRARY: ${GFLAG_STATIC_LIB}")
else()
  if (_gflag_path)
    set (GFLAG_ERR_MSG "Could not find GFLAG. Looked in ${_gflag_path}.")
  else ()
    set (GFLAG_ERR_MSG "Could not find GFLAG in system search paths.")
  endif ()

  if (GFLAG_FIND_REQUIRED)
    message (FATAL_ERROR "${GFLAG_ERR_MSG}")
  else ()
    message (STATUS "${GFLAG_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  GFLAG_LIB_DIR
  GFLAG_INCLUDE_DIR
  GFLAG_STATIC_LIB
  GFLAG_LIBRARY
)
