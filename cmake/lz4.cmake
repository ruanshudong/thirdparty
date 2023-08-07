
set(LIB_LZ4 "lz4")
if(MSVC)
ExternalProject_Add(ADD_${LIB_LZ4}
        URL ${THIRDPARTY_URL}/lz4-v${LZ4_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} build/cmake  -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_LZ4}-${LZ4_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS} -DLZ4_POSITION_INDEPENDENT_LIB=ON -DLZ4_BUILD_CLI=OFF -DLZ4_BUILD_LEGACY_LZ4C=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_LZ4}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 ${LZ4_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_LZ4}
        URL ${THIRDPARTY_URL}/lz4-v${LZ4_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} build/cmake -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_LZ4}-${LZ4_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -DBUILD_STATIC_LIBS=${BUILD_STATIC_LIBS} -DLZ4_POSITION_INDEPENDENT_LIB=ON -DLZ4_BUILD_CLI=OFF -DLZ4_BUILD_LEGACY_LZ4C=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_LZ4}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${LZ4_MD5}
        )
endif(MSVC)

add_dependencies(thirdparty ADD_${LIB_LZ4})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_LZ4}-${LZ4_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\lz4")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\lz4-${LZ4_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/lz4 && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/lz4-${LZ4_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/lz4-${LZ4_VERSION} ${CMAKE_INSTALL_PREFIX}/lz4)")
endif(MSVC)



