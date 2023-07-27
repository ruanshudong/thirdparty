

ExternalProject_Add(ADD_BISON
        URL ${THIRDPARTY_URL}/bison-${BISON_VERSION}.tar.xz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND aclocal && automake && ./configure --prefix=${THIRDPARTY_PATH}/bison-${BISON_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/bison-lib
        BUILD_IN_SOURCE 1
        LOG_BUILD 1
        LOG_CONFIGURE 0
        BUILD_COMMAND ${CMAKE_COMMAND}
	#        INSTALL_COMMAND ${CMAKE_COMMAND} install
        URL_MD5 ${BISON_MD5}
        )
add_dependencies(thirdparty ADD_BISON)

install(DIRECTORY ${THIRDPARTY_PATH}/bison-${BISON_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/bison-${BISON_VERSION} ${CMAKE_INSTALL_PREFIX}/bison)")
