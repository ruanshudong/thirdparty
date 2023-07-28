

set(LIB_ROCKSDB "rocksdb")

if(MSVC)

set(ENV{SNAPPY_INCLUDE} "${SNAPPY_DIR}/include")
set(ENV{SNAPPY_LIB_DEBUG} "${SNAPPY_DIR}/lib/snappy.lib")
set(ENV{SNAPPY_LIB_RELEASE} "${SNAPPY_DIR}/lib/snappy.lib")

#set(ENV{LZ4_INCLUDE} "${LZ4_DIR}/include")
#set(ENV{LZ4_LIB_DEBUG} "${LZ4_DIR}/lib/lz4.lib")
#set(ENV{LZ4_LIB_RELEASE} "${LZ4_DIR}/lib/lz4.lib")

#set(ENV{ZLIB_INCLUDE} "${ZLIB_DIR}/include")
#set(ENV{ZLIB_LIB_DEBUG} "${ZLIB_DIR}/lib/zlibstatic.lib")
#set(ENV{ZLIB_LIB_RELEASE} "${ZLIB_DIR}/lib/zlibstatic.lib")

#set(ENV{ZSTD_INCLUDE} "${ZSTD_DIR}/include")
#set(ENV{ZSTD_LIB_DEBUG} "${ZSTD_DIR}/lib/zstd_static.lib")
#set(ENV{ZSTD_LIB_RELEASE} "${ZSTD_DIR}/lib/zstd_static.lib")

#set(ENV{GFLAGS_INCLUDE} "${GFLAGS_DIR}/include")
#set(ENV{GFLAGS_LIB_DEBUG} "${GFLAGS_DIR}/lib/gflags_static.lib")
#set(ENV{GFLAGS_LIB_RELEASE} "${GFLAGS_DIR}/lib/gflags_static.lib")

message(ENV{SNAPPY_INCLUDE})
#需要修改rocksdb的CMakeLists.txt, 去掉-Wall
ExternalProject_Add(ADD_${LIB_ROCKSDB}
		URL ${THIRDPARTY_URL}/rocksdb-${ROCKSDB_VERSION}.tar.gz
		DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
		PREFIX ${CMAKE_BINARY_DIR}
		INSTALL_DIR ${CMAKE_SOURCE_DIR}
		CONFIGURE_COMMAND ${CMAKE_COMMAND} . -T${MSVC_TOOLSET_VERSION} -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/rocksdb-${ROCKSDB_VERSION}  -DFAIL_ON_WARNINGS=OFF -DROCKSDB_INSTALL_ON_WINDOWS=ON -DPORTABLE=ON -DWITH_BENCHMARK_TOOLS=OFF -DWITH_TESTS=OFF -DWITH_TOOLS:BOOL=OFF -DWITH_SNAPPY=ON -DWITH_LZ4=OFF -DWITH_ZLIB=OFF  -DWITH_ZSTD=OFF -DROCKSDB_BUILD_SHARED=OFF -DUSE_RTTI=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON
		SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ROCKSDB}-lib
		BUILD_IN_SOURCE 1
		BUILD_COMMAND ${CMAKE_COMMAND} --build . --config release --target rocksdb -- /maxcpucount:4
		# URL_MD5 9bd64f1b7b74342ba4c045e9a6dd2bd2
		URL_MD5 ${ROCKSDB_MD5}
		)
else(MSVC)

set(_SNAPPY_DIR ${SNAPPY_DIR}/lib/cmake/Snappy)
set(_GFLAGS_DIR ${GFLAGS_DIR}/lib/cmake/gflags)

message(${_SNAPPY_DIR})
message(${_GFLAGS_DIR})
#CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/rocksdb-${ROCKSDB_VERSION} -DCMAKE_CXX_FLAGS=-Wno-error -DPORTABLE=ON -DSnappy_DIR=${_SNAPPY_DIR} -DWITH_BENCHMARK_TOOLS=OFF -DWITH_TESTS=OFF -DWITH_TOOLS:BOOL=OFF -DWITH_SNAPPY=ON -DWITH_LZ4=ON -DWITH_ZLIB=ON  -DWITH_ZSTD=ON -DWITH_GFLAGS=ON -DROCKSDB_BUILD_SHARED=OFF -Dgflags_DIR=${_GFLAG_DIR} -DUSE_RTTI=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON -Dlz4_INCLUDE_DIRS=${LZ4_DIR}/include -Dlz4_LIBRARIES=${LZ4_DIR}/lib/liblz4.a -DZLIB_INCLUDE_DIR=${ZLIB_DIR}/include -DZLIB_LIBRARY_RELEASE=${ZLIB_DIR}/lib/libz.a

ExternalProject_Add(ADD_${LIB_ROCKSDB}
		URL ${THIRDPARTY_URL}/rocksdb-${ROCKSDB_VERSION}.tar.gz
		DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download
		PREFIX ${CMAKE_BINARY_DIR}
		INSTALL_DIR ${CMAKE_SOURCE_DIR}
		CONFIGURE_COMMAND ${CMAKE_COMMAND} . -DCMAKE_BUILD_TYPE=Release -DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH} -DCMAKE_INSTALL_PREFIX=${THIRDPARTY_PATH}/rocksdb-${ROCKSDB_VERSION} -DCMAKE_CXX_FLAGS=-Wno-error -DPORTABLE=ON -DSnappy_DIR=${_SNAPPY_DIR} -DWITH_BENCHMARK_TOOLS=OFF -DWITH_TESTS=OFF -DWITH_TOOLS:BOOL=OFF -DWITH_SNAPPY=ON -DWITH_LZ4=OFF -DWITH_ZLIB=OFF  -DWITH_ZSTD=OFF -DWITH_GFLAGS=OFF -DROCKSDB_BUILD_SHARED=OFF -DUSE_RTTI=ON -DCMAKE_POSITION_INDEPENDENT_CODE=ON
		SOURCE_DIR ${THIRDPARTY_PATH}/${LIB_ROCKSDB}-lib
		BUILD_IN_SOURCE 1
		BUILD_COMMAND make rocksdb -j4
		# URL_MD5 9bd64f1b7b74342ba4c045e9a6dd2bd2
		URL_MD5 ${ROCKSDB_MD5}
		)
endif(MSVC)
		
add_dependencies(ADD_${LIB_ROCKSDB} ADD_${LIB_GFLAGS} ADD_${LIB_SNAPPY} ADD_${LIB_LZ4} ADD_${LIB_ZLIB} ADD_${LIB_ZSTD})

add_dependencies(thirdparty ADD_${LIB_ROCKSDB})

install(DIRECTORY ${THIRDPARTY_PATH}/rocksdb-${ROCKSDB_VERSION} USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX})
INSTALL(CODE "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_INSTALL_PREFIX}/rocksdb-${ROCKSDB_VERSION} ${CMAKE_INSTALL_PREFIX}/rocksdb)")
