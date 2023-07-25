
# LUA_HOME environment variable is used to check for LUA headers and static library

# LUA_BIN_DIR: directory containing bin
# LUA_LIB_DIR: directory containing lib
# LUA_INCLUDE_DIR: directory containing headers
# LUA_STATIC_LIB: path to liblua.a
# LUA_FOUND: whether LUA has been found

if( NOT "${LUA_HOME}" STREQUAL "")
    file (TO_CMAKE_PATH "${LUA_HOME}" _lua_path)
endif()

message (STATUS "LUA_HOME: ${LUA_HOME}")
set(LUA_LIB_NAME lua)

find_path (LUA_BIN_DIR lua HINTS
        ${_lua_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "bin")

find_path (LUA_INCLUDE_DIR lua.h HINTS
  ${_lua_path}
  NO_DEFAULT_PATH
  PATH_SUFFIXES "include")

find_library (LUA_LIBRARY NAMES lua HINTS
        ${_lua_path}
        PATH_SUFFIXES "lib" "lib64")

find_library (LUA_STATIC_LIB NAMES ${CMAKE_STATIC_LIBRARY_PREFIX}${LUA_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} HINTS
  ${_lua_path}
  PATH_SUFFIXES "lib" "lib64")

find_path (LUA_LIB_DIR ${CMAKE_STATIC_LIBRARY_PREFIX}${LUA_LIB_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX} PATHS
        ${_lua_path}
        NO_DEFAULT_PATH
        PATH_SUFFIXES "lib" "lib64")

if (LUA_INCLUDE_DIR AND LUA_LIBRARY)
  set (LUA_FOUND TRUE)
else ()
  set (LUA_FOUND FALSE)
endif ()

if (LUA_FOUND)
  message (STATUS "Found the LUA bin LUA_BIN_DIR: ${LUA_BIN_DIR}")
  message (STATUS "Found the LUA header path LUA_INCLUDE_DIR: ${LUA_INCLUDE_DIR}")
  message (STATUS "Found the LUA lib path LUA_LIB_DIR: ${LUA_LIB_DIR}")
  message (STATUS "Found the LUA static library LUA_STATIC_LIB: ${LUA_STATIC_LIB}")
else()
  if (_lua_path)
    set (LUA_ERR_MSG "Could not find LUA. Looked in ${_lua_path}.")
  else ()
    set (LUA_ERR_MSG "Could not find LUA in system search paths.")
  endif ()

  if (LUA_FIND_REQUIRED)
    message (FATAL_ERROR "${LUA_ERR_MSG}")
  else ()
    message (STATUS "${LUA_ERR_MSG}")
  endif ()
endif()

mark_as_advanced (
  LUA_BIN_DIR
  LUA_INCLUDE_DIR
  LUA_LIB_DIR
  LUA_STATIC_LIB
)
