
if (WIN32)
    set(LIB_OPENSSL "libssl")
    set(LIB_CRYPTO "libcrypto")

    ExternalProject_Add(ADD_${LIB_OPENSSL}
            URL ${THIRDPARTY_URL}/openssl-${OPENSSL_VERSION}.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND perl Configure --prefix=${THIRDPARTY_PATH}/openssl-${OPENSSL_VERSION} --openssldir=ssl VC-WIN64A no-asm
            SOURCE_DIR ${THIRDPARTY_PATH}/openssl-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND nmake
            INSTALL_COMMAND nmake install_sw
            URL_MD5 ${OPENSSL_MD5}
            )
else ()
    set(LIB_OPENSSL "ssl")
    set(LIB_CRYPTO "crypto")

    ExternalProject_Add(ADD_${LIB_OPENSSL}
            URL ${THIRDPARTY_URL}/openssl-${OPENSSL_VERSION}.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ./config --prefix=${THIRDPARTY_PATH}/openssl-${OPENSSL_VERSION} --openssldir=ssl no-shared
            SOURCE_DIR ${THIRDPARTY_PATH}/openssl-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make
            INSTALL_COMMAND make install_sw
            URL_MD5 ${OPENSSL_MD5}
            )

endif ()

add_dependencies(thirdparty ADD_${LIB_OPENSSL})

install(DIRECTORY ${THIRDPARTY_PATH}/openssl-${OPENSSL_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\openssl")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\openssl-${OPENSSL_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/openssl && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/openssl-${OPENSSL_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/openssl-${OPENSSL_VERSION} ${CMAKE_INSTALL_PREFIX}/openssl)")
endif(MSVC)


