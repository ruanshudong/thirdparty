

set(LIB_GFLAGS "gflags")
if(MSVC)
ExternalProject_Add(ADD_${LIB_GFLAGS}
        URL ${THIRDPARTY_URL}/gflag-${GFLAGS_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -T${MSVC_TOOLSET_VERSION} -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_GFLAGS}-${GFLAGS_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GFLAGS}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 ${GFLAGS_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_GFLAGS}
        URL ${THIRDPARTY_URL}/gflag-${GFLAGS_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_GFLAGS}-${GFLAGS_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GFLAGS}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${GFLAGS_MD5}
        )
endif(MSVC)
        
install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_GFLAGS}-${GFLAGS_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\gflags")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\gflags-${GFLAGS_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/gflags && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/gflags-${GFLAGS_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/gflags-${GFLAGS_VERSION} ${CMAKE_INSTALL_PREFIX}/gflags)")
endif(MSVC)

