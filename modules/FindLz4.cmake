
# LZ4_HOME environment variable is used to check for LZ4 headers and static library

# LZ4_INCLUDE_DIR: directory containing headers
# LZ4_LIB_DIR: directory containing lib
# LZ4_STATIC_LIB: path to lz4.a
# LZ4_FOUND: whether LZ4 has been found

if( NOT "${LZ4_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${LZ4_HOME}" _lz4_path)
endif()

message (STATUS "LZ4_HOME: ${LZ4_HOME}")
set(LZ4_LIB_NAME lz4)

find_path (LZ4_INCLUDE_DIR lz4.h HINTS
  ${_lz4_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (LZ4_LIBRARY NAMES lz4 HINTS
  ${_lz4_path}
  PATH_SUFFIXES "lib" "lib64")

find_library (LZ4_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${LZ4_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_lz4_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (LZ4_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${LZ4_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_lz4_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (LZ4_INCLUDE_DIR AND LZ4_LIBRARY)
  set (LZ4_FOUND TRUE)
else ()
  set (LZ4_FOUND FALSE)
endif ()

if (LZ4_FOUND)
  message (STATUS "Found the LZ4 header path LZ4_INCLUDE_DIR: ${LZ4_INCLUDE_DIR}")
  message (STATUS "Found the LZ4 lib path LZ4_LIB_DIR: ${LZ4_LIB_DIR}")
  message (STATUS "Found the LZ4 static library LZ4_STATIC_LIB: ${LZ4_STATIC_LIB}")
else()
  if (_lz4_path)
    set (LZ4_ERR_MSG "Could not find LZ4. Looked in ${_lz4_path}.")
  else ()
    set (LZ4_ERR_MSG "Could not find LZ4 in system search paths.")
  endif ()

  if (LZ4_FIND_REQUIRED)
    message (FATAL_ERROR "${LZ4_ERR_MSG}")
  else ()
    message (STATUS "${LZ4_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  LZ4_LIB_DIR
  LZ4_INCLUDE_DIR
  LZ4_STATIC_LIB
)
