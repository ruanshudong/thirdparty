
set(LIB_EIGEN "eigen")

if(MSVC)
ExternalProject_Add(ADD_${LIB_EIGEN}
        URL ${THIRDPARTY_URL}/eigen-${EIGEN_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${THIRDPARTY_PATH}/${LIB_EIGEN}-lib -T${MSVC_TOOLSET_VERSION} -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_EIGEN}-${EIGEN_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_EIGEN}-lib
        BUILD_IN_SOURCE 0
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target ALL_BUILD -- /maxcpucount:4
        URL_MD5 0a59748dad9bde63cc15bb29e48afe8d
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_EIGEN}
        URL ${THIRDPARTY_URL}/eigen-${EIGEN_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} ${THIRDPARTY_PATH}/${LIB_EIGEN}-lib -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_EIGEN}-${EIGEN_VERSION}
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_EIGEN}-lib
        BUILD_IN_SOURCE 0
        BUILD_COMMAND make
        URL_MD5 0a59748dad9bde63cc15bb29e48afe8d
        )
endif(MSVC)

set(EIGEN_DIR "${THIRDPARTY_PATH}/${LIB_EIGEN}")
set(EIGEN_DIR_INC "${THIRDPARTY_PATH}/${LIB_EIGEN}/include/eigen3")
include_directories(${EIGEN_DIR_INC})

add_dependencies(thirdparty ADD_${LIB_EIGEN})
install(DIRECTORY ${THIRDPARTY_PATH}/eigen-${EIGEN_VERSION} DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\eigen")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\eigen-${EIGEN_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")

# INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd /c mklink /J ${CMAKE_INSTALL_PREFIX}/eigen ${CMAKE_INSTALL_PREFIX}/eigen-${EIGEN_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/eigen-${EIGEN_VERSION} ${CMAKE_INSTALL_PREFIX}/eigen)")
endif(MSVC)

