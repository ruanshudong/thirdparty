set(LIB_RDKAFKA "rdkafka")
if(MSVC)
ExternalProject_Add(ADD_${LIB_RDKAFKA}
        URL ${THIRDPARTY_URL}/librdkafka-${RDKAFKA_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -T${MSVC_TOOLSET_VERSION}  -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_RDKAFKA}-${RDKAFKA_VERSION} -DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH} -DRDKAFKA_BUILD_STATIC=${BUILD_STATIC_LIBS} -DWITH_ZLIB=OFF -DWITH_ZSTD=OFF -DWITH_LZ4_EXT=OFF -DENABLE_LZ4_EXT=OFF -DWITH_CURL=OFF -DWITH_SASL=OFF -DRDKAFKA_BUILD_TESTS=OFF -DRDKAFKA_BUILD_EXAMPLES=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_RDKAFKA}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target rdkafka -- /maxcpucount:4
        URL_MD5 ${RDKAFKA_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_RDKAFKA}
        URL ${THIRDPARTY_URL}/librdkafka-${RDKAFKA_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
		CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_RDKAFKA}-${RDKAFKA_VERSION} -DRDKAFKA_BUILD_STATIC=${BUILD_STATIC_LIBS} -DWITH_ZLIB=OFF -DWITH_ZSTD=OFF -DWITH_LZ4_EXT=OFF -DENABLE_LZ4_EXT=OFF -DWITH_CURL=OFF -DWITH_SASL=OFF -DRDKAFKA_BUILD_TESTS=OFF -DRDKAFKA_BUILD_EXAMPLES=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_RDKAFKA}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make rdkafka
        URL_MD5 ${RDKAFKA_MD5}
        )
endif(MSVC)
        
#add_dependencies(ADD_${LIB_RDKAFKA} ADD_${LIB_ZSTD} ADD_${LIB_ZLIB})
add_dependencies(thirdparty ADD_${LIB_RDKAFKA})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_RDKAFKA}-${RDKAFKA_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/curl && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/${LIB_CURL}-${CURL_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_CURL}-${CURL_VERSION} ${CMAKE_INSTALL_PREFIX}/curl)")
endif(MSVC)

INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_RDKAFKA}-${RDKAFKA_VERSION} ${CMAKE_INSTALL_PREFIX}/${LIB_RDKAFKA})")
