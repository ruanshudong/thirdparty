
set(LIB_GTEST "gtest")

if (WIN32)

  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(LIB_GTEST "${LIB_GTEST}d")
  endif()

  ExternalProject_Add(ADD_${LIB_GTEST}
          URL ${THIRDPARTY_URL}/release-${GTEST_VERSION}.zip
          DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
          PREFIX ${CMAKE_BINARY_DIR}
          INSTALL_DIR ${CMAKE_SOURCE_DIR}
          CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/gtest -DBUILD_SHARED_LIBS=OFF -Dgtest_hide_internal_symbols=ON -Dgtest_force_shared_crt=ON -A x64 -Dgtest_force_shared_crt=on
          SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GTEST}-lib
          BUILD_IN_SOURCE 1
          BUILD_COMMAND ${CMAKE_COMMAND} --build . --config ${CMAKE_BUILD_TYPE} -- /maxcpucount:4
          URL_MD5 82358affdd7ab94854c8ee73a180fc53
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
          CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_CXX_FLAGS=${GTEST_CMAKE_CXX_FLAGS} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/gtest-${GTEST_VERSION} -DBUILD_SHARED_LIBS=OFF -DBUILD_GMOCK=OFF -Dgtest_hide_internal_symbols=ON -Dgtest_force_shared_crt=ON
          SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_GTEST}-lib
          BUILD_IN_SOURCE 1
          BUILD_COMMAND make
          URL_MD5 6f26d634fa9cac718263c2df20df21a4
          )
endif()

add_dependencies(thirdparty ADD_${LIB_GTEST})

install(DIRECTORY ${THIRDPARTY_PATH}/gtest-${GTEST_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/gtest-${GTEST_VERSION} ${CMAKE_INSTALL_PREFIX}/gtest)")
