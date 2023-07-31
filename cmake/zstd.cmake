
set(LIB_ZSTD "zstd")

if(MSVC)
ExternalProject_Add(ADD_${LIB_ZSTD}
        URL ${THIRDPARTY_URL}/zstd-${ZSTD_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${THIRDPARTY_PATH}/${LIB_ZSTD}-lib/build/cmake -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_ZSTD}-${ZSTD_VERSION} -DZSTD_BUILD_SHARED=${BUILD_SHARED_LIBS} -DZSTD_BUILD_STATIC=${BUILD_STATIC_LIBS} -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ZSTD}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 ${ZSTD_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_ZSTD}
        URL ${THIRDPARTY_URL}/zstd-${ZSTD_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${THIRDPARTY_PATH}/${LIB_ZSTD}-lib/build/cmake -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_ZSTD}-${ZSTD_VERSION} -DZSTD_BUILD_SHARED=${BUILD_SHARED_LIBS} -DZSTD_BUILD_STATIC=${BUILD_STATIC_LIBS} -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ZSTD}-lib
        BUILD_IN_SOURCE 0
        BUILD_COMMAND make
        URL_MD5 ${ZSTD_MD5}
        )
endif(MSVC)
        
add_dependencies(thirdparty ADD_${LIB_ZSTD})

# list(APPEND CMAKE_MODULE_PATH "${THIRDPARTY_PATH}/${LIB_ZSTD}-${ZSTD_VERSION}/lib/cmake")

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_ZSTD}-${ZSTD_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_ZSTD}-${ZSTD_VERSION} ${CMAKE_INSTALL_PREFIX}/${LIB_ZSTD})")
