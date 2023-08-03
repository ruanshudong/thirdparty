
# PYBIND11_HOME environment variable is used to check for PYBIND11 headers and static library

# PYBIND11_INCLUDE_DIR: directory containing headers
# PYBIND11_FOUND: whether PYBIND11 has been found

if( NOT "${PYBIND11_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${PYBIND11_HOME}" _pybind11_path)
endif()

message (STATUS "PYBIND11_HOME: ${PYBIND11_HOME}")

find_path (PYBIND11_INCLUDE_DIR pybind11/pybind11.h HINTS
  ${_pybind11_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

if (PYBIND11_INCLUDE_DIR)
  set (PYBIND11_FOUND TRUE)
else ()
  set (PYBIND11_FOUND FALSE)
endif ()

if (PYBIND11_FOUND)
  message (STATUS "Found the PYBIND11 header path PYBIND11_INCLUDE_DIR: ${PYBIND11_INCLUDE_DIR}")
else()
  if (_pybind11_path)
    set (PYBIND11_ERR_MSG "Could not find PYBIND11. Looked in ${_pybind11_path}.")
  else ()
    set (PYBIND11_ERR_MSG "Could not find PYBIND11 in system search paths.")
  endif ()

  if (PYBIND11_FIND_REQUIRED)
    message (FATAL_ERROR "${PYBIND11_ERR_MSG}")
  else ()
    message (STATUS "${PYBIND11_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  PYBIND11_INCLUDE_DIR
)
