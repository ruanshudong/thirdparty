
set(LIB_GTEST "gtest")

if (WIN32)

  # if (CMAKE_BUILD_TYPE STREQUAL "Debug")
  #   set(LIB_GTEST "${LIB_GTEST}d")
  # endif()

  ExternalProject_Add(ADD_${LIB_GTEST}
          URL ${THIRDPARTY_URL}/release-${GTEST_VERSION}.zip
          DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
          PREFIX ${CMAKE_BINARY_DIR}
          INSTALL_DIR ${CMAKE_SOURCE_DIR}
          CONFIGURE_COMMAND ${CMAKE_COMMAND} .  -DCMAKE_CXX_CFLAGS=${MT_MODE_FLAG} -T${MSVC_TOOLSET_VERSION} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/gtest-${GTEST_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -Dgtest_hide_internal_symbols=ON -Dgtest_force_shared_crt=ON -Dgtest_force_shared_crt=on
          SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GTEST}-lib
          BUILD_IN_SOURCE 1
          BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release -- /maxcpucount:4
          URL_MD5 ${GTEST_MD5}
          )
else()

  if(APPLE)
    set(GTEST_CMAKE_CXX_FLAGS " -DGTEST_USE_OWN_TR1_TUPLE=1 -Wno-unused-value -Wno-ignored-attributes -Wno-deprecated-copy")
  else()
    set(GTEST_CMAKE_CXX_FLAGS "")
  endif()

  ExternalProject_Add(ADD_${LIB_GTEST}
          URL ${THIRDPARTY_URL}/release-${GTEST_VERSION}.fixed.tar.gz
          DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
          PREFIX ${CMAKE_BINARY_DIR}
          INSTALL_DIR ${CMAKE_SOURCE_DIR}
          CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_CXX_FLAGS=${GTEST_CMAKE_CXX_FLAGS} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/gtest-${GTEST_VERSION} -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} -DBUILD_GMOCK=OFF -Dgtest_hide_internal_symbols=ON -Dgtest_force_shared_crt=ON
          SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GTEST}-lib
          BUILD_IN_SOURCE 1
          BUILD_COMMAND make
          URL_MD5 ${GTEST_MD5} 
          )
endif()

add_dependencies(thirdparty ADD_${LIB_GTEST})

install(DIRECTORY ${THIRDPARTY_PATH}/gtest-${GTEST_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})

if(MSVC)
set(LINK_DST "${CMAKE_INSTALL_PREFIX}\\\\gtest")
set(LINK_SRC "${CMAKE_INSTALL_PREFIX}\\\\gtest-${GTEST_VERSION}")
INSTALL(CODE "EXECUTE_PROCESS(COMMAND cmd.exe /c mklink /J ${LINK_DST} ${LINK_SRC})")
file(APPEND ${LINK_FILE} "cmd /c mklink /J ${LINK_DST} ${LINK_SRC}\n")
# INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_INSTALL_PREFIX}/gtest && ${CMAKE_COMMAND} -E copy_directory ${CMAKE_INSTALL_PREFIX}/gtest-${GTEST_VERSION} )")
else(MSVC)
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/gtest-${GTEST_VERSION} ${CMAKE_INSTALL_PREFIX}/gtest)")
endif(MSVC)

