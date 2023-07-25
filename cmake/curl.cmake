
set(LIB_CURL "curl")

message(${OPENSSL_ROOT_DIR})
if(MSVC)
ExternalProject_Add(ADD_${LIB_CURL}
        URL ${THIRDPARTY_URL}/curl-${CURL_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_CURL}-${CURL_VERSION} -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_CURL}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release 
        URL_MD5 ${CURL_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_CURL}
        URL ${THIRDPARTY_URL}/curl-${CURL_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_CURL}-${CURL_VERSION} -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_CURL}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${CURL_MD5}
        )
endif(MSVC)
        
add_dependencies(ADD_${LIB_CURL} ADD_${LIB_OPENSSL})

add_dependencies(thirdparty ADD_${LIB_CURL})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_CURL}-${CURL_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_CURL}-${CURL_VERSION} ${CMAKE_INSTALL_PREFIX}/curl)")

