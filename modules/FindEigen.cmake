
# EIGEN_HOME environment variable is used to check for EIGEN headers and static library

# EIGEN_INCLUDE_DIR: directory containing headers
# EIGEN_FOUND: whether EIGEN has been found

if( NOT "${EIGEN_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${EIGEN_HOME}" _eigen_path)
endif()

message (STATUS "EIGEN_HOME: ${EIGEN_HOME}")

find_path (EIGEN_INCLUDE_DIR Eigen/Dense HINTS
  ${_eigen_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include/eigen3")

if (EIGEN_INCLUDE_DIR)
  set (EIGEN_FOUND TRUE)
else ()
  set (EIGEN_FOUND FALSE)
endif ()

if (EIGEN_FOUND)
  message (STATUS "Found the EIGEN header EIGEN_INCLUDE_DIR: ${EIGEN_INCLUDE_DIR}")
else()
  if (_eigen_path)
    set (EIGEN_ERR_MSG "Could not find EIGEN. Looked in ${_eigen_path}.")
  else ()
    set (EIGEN_ERR_MSG "Could not find EIGEN in system search paths.")
  endif ()

  if (EIGEN_FIND_REQUIRED)
    message (FATAL_ERROR "${EIGEN_ERR_MSG}")
  else ()
    message (STATUS "${EIGEN_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  EIGEN_INCLUDE_DIR
)
