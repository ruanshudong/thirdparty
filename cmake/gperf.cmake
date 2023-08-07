
if (UNIX)
    set(LIB_GPERF "profiler")
    set(LIB_TCMALLOC_PROFILER "tcmalloc_and_profiler")
    set(LIB_TCMALLOC_MINIMAL "tcmalloc_and_minimal")

    ExternalProject_Add(ADD_${LIB_GPERF}
            URL ${THIRDPARTY_URL}/gperftools-${GPERF_VERSION}.tar.gz
            DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
            PREFIX ${CMAKE_BINARY_DIR}
            INSTALL_DIR ${CMAKE_SOURCE_DIR}
            CONFIGURE_COMMAND ./configure --prefix=${THIRDPARTY_PATH}/gperf-${GPERF_VERSION} --disable-shared --disable-debugalloc
            SOURCE_DIR ${THIRDPARTY_PATH}/gperf-lib
            BUILD_IN_SOURCE 1
            BUILD_COMMAND make
            URL_MD5 ${GPERF_MD5}
            )

    add_dependencies(thirdparty ADD_${LIB_GPERF})

install(DIRECTORY ${THIRDPARTY_PATH}/gperf-${GPERF_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/gperf-${GPERF_VERSION} ${CMAKE_INSTALL_PREFIX}/gperf)")

endif (UNIX)
