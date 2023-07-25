
if (WIN32)
    set(LIB_GMSSL "libgmssl")
    set(LIB_GMSSL_PREFIX ${THIRDPARTY_PATH}/gmssl)
    if (CMAKE_CL_64)
        set(arch VC-WIN64A)
    else()
        set(arch VC-WIN32)
    endif()

    ExternalProject_Add(ADD_${LIB_GMSSL}
            URL ${THIRDPARTY_URL}/gmssl-${GMSSL_VERSION}.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND perl ${THIRDPARTY_PATH}/gmssl-lib/Configure --prefix=${LIB_GMSSL_PREFIX}-${GMSSL_VERSION} ${arch} no-asm no-shared -DGMSSL_NO_TURBO no-afalgeng
            SOURCE_DIR ${THIRDPARTY_PATH}/gmssl-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND nmake
            LOG_CONFIGURE 0
            LOG_BUILD 0
            INSTALL_COMMAND nmake install_sw
            URL_MD5 ${GMSSL_MD5}
            )

elseif (APPLE)
    set(LIB_GMSSL "gmssl")
    set(flags "-fvisibility=hidden -fvisibility-inlines-hidden")

    # apple最新M系列芯片arm64架构, 需单独处理
    if (CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
        set(PKG_URL ${THIRDPARTY_URL}/gmssl-${GMSSL_VERSION}-mac-arm64.tar.gz)
        set(CFG_CMD perl ${THIRDPARTY_PATH}/gmssl-lib/Configure --prefix=${THIRDPARTY_PATH}/gmssl-${GMSSL_VERSION} darwin64-arm64-cc no-shared no-asm ${flags})
    else()
        set(PKG_URL ${THIRDPARTY_URL}/gmssl-${GMSSL_VERSION}-mac.tar.gz)
        set(CFG_CMD ./config --prefix=${THIRDPARTY_PATH}/gmssl-${GMSSL_VERSION} no-shared ${flags})
    endif()
    ExternalProject_Add(ADD_${LIB_GMSSL}
            URL ${PKG_URL}
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ${CFG_CMD}
            SOURCE_DIR ${THIRDPARTY_PATH}/gmssl-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make -j4
            LOG_CONFIGURE 0
            LOG_BUILD 0
            INSTALL_COMMAND make install_sw
            URL_MD5 ${GMSSL_MD5}
            )
else()
    set(LIB_GMSSL "gmssl")
    set(flags "-fvisibility=hidden -fvisibility-inlines-hidden")

    ExternalProject_Add(ADD_${LIB_GMSSL}
            URL ${THIRDPARTY_URL}/gmssl-${GMSSL_VERSION}.fixed.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ./config --prefix=${THIRDPARTY_PATH}/gmssl-${GMSSL_VERSION} no-shared ${flags}  -DGMSSL_NO_TURBO no-afalgeng
            SOURCE_DIR ${THIRDPARTY_PATH}/gmssl-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make -j4
            LOG_CONFIGURE 0
            LOG_BUILD 0
            INSTALL_COMMAND make install_sw
            URL_MD5 ${GMSSL_MD5}
            )
endif ()

install(DIRECTORY ${THIRDPARTY_PATH}/gmssl-${GMSSL_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/gmssl-${GMSSL_VERSION} ${CMAKE_INSTALL_PREFIX}/gmssl)")
