

ExternalProject_Add(ADD_FLEX
        URL ${THIRDPARTY_URL}/flex-${FLEX_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND aclocal && automake && ./configure --prefix=${THIRDPARTY_PATH}/flex-${FLEX_VERSION} --enable-shared=no --enable-static=yes
        SOURCE_DIR ${THIRDPARTY_PATH}/flex-lib
        BUILD_IN_SOURCE 1
        LOG_BUILD 0
        LOG_CONFIGURE 0
        BUILD_COMMAND make -j4
        INSTALL_COMMAND make install
        URL_MD5 ${FLEX_MD5}
        )

include_directories(${CMAKE_BINARY_DIR}/src/flex/include)

add_dependencies(thirdparty ADD_FLEX)

install(DIRECTORY ${THIRDPARTY_PATH}/flex-${FLEX_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/flex-${FLEX_VERSION} ${CMAKE_INSTALL_PREFIX}/flex)")
