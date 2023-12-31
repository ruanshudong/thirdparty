set(LIB_PYBIND11 "pybind11")
if(MSVC)
ExternalProject_Add(ADD_${LIB_PYBIND11}
        URL ${THIRDPARTY_URL}/pybind11-${PYBIND11_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_PYBIND11}-${PYBIND11_VERSION} -DPYBIND11_TEST=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_PYBIND11}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release -- /maxcpucount:4
        URL_MD5 ${PYBIND11_MD5}
        )
else(MSVC)
ExternalProject_Add(ADD_${LIB_PYBIND11}
        URL ${THIRDPARTY_URL}/pybind11-${PYBIND11_VERSION}.tar.gz
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
        PREFIX ${CMAKE_BINARY_DIR}
        INSTALL_DIR ${CMAKE_SOURCE_DIR}
        CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/${LIB_PYBIND11}-${PYBIND11_VERSION} -DPYBIND11_TEST=OFF
        SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_PYBIND11}-lib
        BUILD_IN_SOURCE 1
        BUILD_COMMAND make
        URL_MD5 ${PYBIND11_MD5}
        )
endif(MSVC)
        
add_dependencies(thirdparty ADD_${LIB_PYBIND11})

install(DIRECTORY ${THIRDPARTY_PATH}/${LIB_PYBIND11}-${PYBIND11_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\pybind11")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\pybind11-${PYBIND11_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/pybind11 && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/pybind11-${PYBIND11_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/pybind11-${PYBIND11_VERSION} ${CMAKE_INSTALL_PREFIX}/pybind11)")
endif(MSVC)

