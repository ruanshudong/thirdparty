
set(LIB_GLOG "glog")
if(MSVC)
ExternalProject_Add(ADD_${LIB_GLOG}
        URL ${THIRDPARTY_URL}/glog-v${GLOG_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_GLOG}-${GLOG_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}  -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS} -DBUILD_TESTING=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GLOG}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --config release -- /maxcpucount:4
        URL_MD5 ${GLOG_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_GLOG}
        URL ${THIRDPARTY_URL}/glog-v${GLOG_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_GLOG}-${GLOG_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}  -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS} -DBUILD_TESTING=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GLOG}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${GLOG_MD5}
        )
endif(MSVC)

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_GLOG}-${GLOG_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\glog")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\glog-${GLOG_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/glog && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/glog-${GLOG_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/glog-${GLOG_VERSION} ${CMAKE_INSTALL_PREFIX}/glog)")
endif(MSVC)




