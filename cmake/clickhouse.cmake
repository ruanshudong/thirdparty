
if (UNIX)
    set(LIB_CLICKHOUSE "clickhouse")

    ExternalProject_Add(ADD_${LIB_CLICKHOUSE}
            URL ${THIRDPARTY_URL}/clickhouse-cpp.tgz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ${CMAKE_COMMAND} ${THIRDPARTY_PATH}/${LIB_CLICKHOUSE}-lib -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_CLICKHOUSE}-version -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
            SOURCE_DIR ${THIRDPARTY_PATH}/clickhouse-lib
            BUILD_IN_SOURCE 0
            BUILD_COMMAND make
            URL_MD5 ${CLICKHOUSE_MD5}
            )

    add_dependencies(thirdparty ADD_${LIB_CLICKHOUSE})

endif (UNIX)

install(DIRECTORY ${THIRDPARTY_PATH}/clickhouse-version USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/clickhouse-version  ${CMAKE_INSTALL_PREFIX}/clickhouse)")
