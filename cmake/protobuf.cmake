
set(LIB_PROTOBUF "protobuf")

set(PROTOBUF_CMAKE_ARGS ${PROTOBUF_CMAKE_ARGS} -DCMAKE_POSITION_INDEPENDENT_CODE=ON)

if (MSVC)
set(PROTOBUF_STATIC_LIB_PREFIX lib)
list(APPEND PROTOBUF_CMAKE_ARGS -Dprotobuf_MSVC_STATIC_RUNTIME=ON
                                -Dprotobuf_DEBUG_POSTFIX=)
else ()
set(PROTOBUF_STATIC_LIB_PREFIX ${CMAKE_STATIC_LIBRARY_PREFIX})
endif ()

if(MSVC)
set(PROTOBUF_CMAKE_ARGS ${PROTOBUF_CMAKE_ARGS} -DCMAKE_USER_MAKE_RULES_OVERRIDE=${PROJECT_SOURCE_DIR}/cmake/compiler_flags_overrides.cmake)
endif()

if(MSVC)
ExternalProject_Add(ADD_${LIB_PROTOBUF}
        URL ${THIRDPARTY_URL}/protobuf-v${PROTOBUF_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CMAKE_ARGS ${CMAKE_ARGS}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} cmake -A x64 -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_PROTOBUF}-${PROTOBUF_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -Dprotobuf_BUILD_TESTS=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_PROTOBUF}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 ${PROTOBUF_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_PROTOBUF}
        URL ${THIRDPARTY_URL}/protobuf-v${PROTOBUF_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CMAKE_ARGS ${CMAKE_ARGS}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} cmake -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_PROTOBUF}-${PROTOBUF_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -Dprotobuf_BUILD_TESTS=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_PROTOBUF}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${PROTOBUF_MD5}
        )
endif(MSVC)

add_dependencies(thirdparty ADD_${LIB_PROTOBUF})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_PROTOBUF}-${PROTOBUF_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_PROTOBUF}-${PROTOBUF_VERSION} ${CMAKE_INSTALL_PREFIX}/${LIB_PROTOBUF})")
