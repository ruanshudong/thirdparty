
set(LIB_ZLIB "zlib")

if(MSVC)
  set(ZLIB_CMAKE_ARGS ${ZLIB_CMAKE_ARGS} -DCMAKE_USER_MAKE_RULES_OVERRIDE=${PROJECT_SOURCE_DIR}/cmake/compiler_flags_overrides.cmake)
endif()

if(MSVC)
ExternalProject_Add(ADD_${LIB_ZLIB}
        URL ${THIRDPARTY_URL}/zlib-${ZLIB_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CMAKE_ARGS ${ZLIB_CMAKE_ARGS}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_CXX_FLAGS=${MT_MODE_FLAG} -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_ZLIB}-${ZLIB_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ZLIB}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 ${ZLIB_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_ZLIB}
        URL ${THIRDPARTY_URL}/zlib-${ZLIB_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CMAKE_ARGS ${ZLIB_CMAKE_ARGS}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_ZLIB}-${ZLIB_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ZLIB}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${ZLIB_MD5}
        )
endif(MSVC)
        
add_dependencies(thirdparty ADD_${LIB_ZLIB})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_ZLIB}-${ZLIB_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\zlib")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\zlib-${ZLIB_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/zlib && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/zlib-${ZLIB_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/zlib-${ZLIB_VERSION} ${CMAKE_INSTALL_PREFIX}/zlib)")
endif(MSVC)


