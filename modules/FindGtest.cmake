
# GTEST_HOME environment variable is used to check for GTEST headers and static library

# GTEST_INCLUDE_DIR: directory containing headers
# GTEST_LIB_DIR: directory containing lib
# GTEST_STATIC_LIB: path to libgtest.a
# GTEST_FOUND: whether GTEST has been found

if( NOT "${GTEST_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${GTEST_HOME}" _gtest_path)
endif()

message (STATUS "GTEST_HOME: ${GTEST_HOME}")

set(GTEST_LIB_NAME gtest)

find_path (GTEST_INCLUDE_DIR gtest/gtest.h HINTS
  ${_gtest_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (GTEST_LIBRARY NAMES gtest HINTS
        ${_gtest_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (GTEST_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${GTEST_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_gtest_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (GTEST_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${GTEST_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_gtest_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (GTEST_INCLUDE_DIR AND GTEST_LIBRARY)
  set (GTEST_FOUND TRUE)
else ()
  set (GTEST_FOUND FALSE)
endif ()

if (GTEST_FOUND)
  message (STATUS "Found the GTEST header path GTEST_INCLUDE_DIR: ${GTEST_INCLUDE_DIR}")
  message (STATUS "Found the GTEST lib path GTEST_LIB_DIR: ${GTEST_LIB_DIR}")
  message (STATUS "Found the GTEST static library GTEST_STATIC_LIB: ${GTEST_STATIC_LIB}")
else()
  if (_gtest_path)
    set (GTEST_ERR_MSG "Could not find GTEST. Looked in ${_gtest_path}.")
  else ()
    set (GTEST_ERR_MSG "Could not find GTEST in system search paths.")
  endif ()

  if (GTEST_FIND_REQUIRED)
    message (FATAL_ERROR "${GTEST_ERR_MSG}")
  else ()
    message (STATUS "${GTEST_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  GTEST_LIB_DIR
  GTEST_INCLUDE_DIR
  GTEST_STATIC_LIB
)
