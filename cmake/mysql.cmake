
if (WIN32)
    set(LIB_MYSQL "libmysql")

    ExternalProject_Add(ADD_${LIB_MYSQL}
            URL ${THIRDPARTY_URL}/mysql-connector-c-${MYSQL_VERSION}-src.fixed.zip
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ${CMAKE_COMMAND} . -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/mysql-${MYSQL_VERSION} -DBUILD_CONFIG=mysql_release
            SOURCE_DIR ${THIRDPARTY_PATH}/mysql-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release
            INSTALL_COMMAND ${CMAKE_COMMAND} --build . --config release --target install
            URL_MD5 ${MYSQL_MD5}
            )

else ()
    set(LIB_MYSQL "mysqlclient")

    ExternalProject_Add(ADD_${LIB_MYSQL}
            URL ${THIRDPARTY_URL}/mysql-connector-c-${MYSQL_VERSION}-src.fixed.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/mysql-${MYSQL_VERSION} -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DDISABLE_SHARED=1
            SOURCE_DIR ${THIRDPARTY_PATH}/mysql-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make mysqlclient
            URL_MD5 ${MYSQL_MD5}
            )

endif ()

add_dependencies(thirdparty ADD_${LIB_MYSQL})

install(DIRECTORY ${THIRDPARTY_PATH}/mysql-${MYSQL_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/mysql-${MYSQL_VERSION} ${CMAKE_INSTALL_PREFIX}/mysql)")