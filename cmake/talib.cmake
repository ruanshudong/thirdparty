
set(LIB_TALIB "talib")

if(MSVC)
ExternalProject_Add(ADD_${LIB_TALIB}
        URL ${THIRDPARTY_URL}/ta-lib-${TALIB_VERSION}-src.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ./configure --prefix=${THIRDPARTY_PATH}/${LIB_TALIB}-${TALIB_VERSION} --enable-shared=no --enable-static=yes
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_TALIB}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND nmake
        URL_MD5 ${TALIB_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_TALIB}
        URL ${THIRDPARTY_URL}/ta-lib-${TALIB_VERSION}-src.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ./configure --prefix=${THIRDPARTY_PATH}/${LIB_TALIB}-${TALIB_VERSION} --enable-shared=no --enable-static=yes
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_TALIB}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${TALIB_MD5}
        )
endif(MSVC)

add_dependencies(thirdparty ADD_${LIB_TALIB})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_TALIB}-${TALIB_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_TALIB}-${TALIB_VERSION} ${CMAKE_INSTALL_PREFIX}/${LIB_TALIB})")
