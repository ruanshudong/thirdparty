set(LIB_LUA "lua")

if(APPLE)
    ExternalProject_Add(ADD_${LIB_LUA}
    URL ${THIRDPARTY_URL}/lua-${LUA_VERSION}.tar.gz
    DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
    PREFIX ${CMAKE_BINARY_DIR}
    INSTALL_DIR ${CMAKE_SOURCE_DIR}
    SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_LUA}-lib
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ls
    BUILD_COMMAND make all PLAT=macosx INSTALL_TOP=${THIRDPARTY_PATH}/${LIB_LUA}-${LUA_VERSION}
    INSTALL_COMMAND make install PLAT=macosx INSTALL_TOP=${THIRDPARTY_PATH}/${LIB_LUA}-${LUA_VERSION}
    URL_MD5 ${LUA_MD5}
    )

elseif(UNIX)
    ExternalProject_Add(ADD_${LIB_LUA}
        URL ${THIRDPARTY_URL}/lua-${LUA_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_LUA}-lib
        BUILD_IN_SOURCE 1
        CONFIGURE_COMMAND ls
        BUILD_COMMAND make all PLAT=linux INSTALL_TOP=${THIRDPARTY_PATH}/${LIB_LUA}-${LUA_VERSION}
        INSTALL_COMMAND make install PLAT=linux INSTALL_TOP=${THIRDPARTY_PATH}/${LIB_LUA}-${LUA_VERSION}
        URL_MD5 ${LUA_MD5}
            )
endif()

add_dependencies(thirdparty ADD_${LIB_LUA})

if(NOT MSVC)
install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_LUA}-${LUA_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/${LIB_LUA}-${LUA_VERSION} ${CMAKE_INSTALL_PREFIX}/${LIB_LUA})")
endif()