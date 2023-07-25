## 背景

为了更好管理第三方依赖库,将所有依赖的第三方依赖集中到该项目下, 能够一站式完成编译安装, 并提供响应的cmake文件, 一方面引用和编译.

## 编译和安装

```
mkdir build
cd build
cmake ..
make 
make install
```

默认都安装在 `/usr/local/thirdparty` or `c:\thirdparty`目录下.

注意为了方便服务发布, 所有默认都尽量只编译静态库!

## 引用

为了方便引用, 提供了cmake文件, 当你的服务要引用第三方库时, 完成以下操作即可:

```
list(APPEND CMAKE_MODULE_PATH "/usr/local/thirdparty/modules/")

include(/usr/local/thirdparty/modules/include.cmake)
```

以上操作则会引入相关第三方类的cmake, 可以根据需要引入头文件和link库, 比如要引用mysql库:
```

include_directories(${MYSQL_INCLUDE_DIR})
link_directories(${MYSQL_LIB_DIR})
link_libraries(${MYSQL_STATIC_LIB})

```

说明:
- `MYSQL_INCLUDE_DIR`, `MYSQL_LIB_DIR`, `MYSQL_STATIC_LIB`都是由`/usr/local/taf/thirdparty/modules/`对应模块提供的, 具体可以参考下一节
- `MYSQL_STATIC_LIB`是静态库的绝对路径, 因此通常你不需要`link_directories(${MYSQL_LIB_DIR})` 
- 但是如果一个库编译后, 有多个库, 比如: openssl编译后有libss.a 和 libcrypto.a, 这时`${OPENSSL_STATIC_LIB}`指向是libssl.a的绝对路径, 此时你就需要
```
link_directories(${OPENSSL_LIB_DIR})
link_libraries(${OPENSSL_STATIC_LIB} crypto)
```

## 模块以及导出变量

- bison
>- BISON_BIN: path to bison
>- BISON_LIB_DIR: path to liby

- curl 
>- CURL_INCLUDE_DIR: directory containing headers
>- CURL_LIB_DIR: directory containing lib
>- CURL_STATIC_LIB: path to libcurl.a

- eigen
>- EIGEN_INCLUDE_DIR: directory containing headers

- flex
>- FLEX_BIN: path to flex
>- FLEX_INCLUDE_DIR: path to FlexLexer.h
>- FLEX_LIB_DIR: directory containing lib
>- FLEX_STATIC_LIB: path to libfl

- gflag
>- GFLAG_INCLUDE_DIR: directory containing headers
>- GFLAG_LIB_DIR: directory containing lib
>- GFLAG_STATIC_LIB: path to libgflags.a

- glog
>- GLOG_INCLUDE_DIR: directory containing headers
>- GLOG_LIB_DIR: directory containing lib
>- GLOG_STATIC_LIB: path to libglog.a

- gmssl
>- GMSSL_INCLUDE_DIR: directory containing headers
>- GMSSL_LIB_DIR: directory containing lib
>- GMSSL_STATIC_LIB: path to libssl.a

- gperf
>- GPERF_INCLUDE_DIR: directory containing headers
>- GPERF_LIB_DIR: directory containing lib
>- GPERF_STATIC_LIB: path to libprofiler.a

- gtest
>- GTEST_INCLUDE_DIR: directory containing headers
>- GTEST_LIB_DIR: directory containing lib
>- GTEST_STATIC_LIB: path to libgtest.a

- jsoncpp
>- JSONCPP_INCLUDE_DIR: directory containing headers
>- JSONCPP_LIB_DIR: directory containing lib
>- JSONCPP_STATIC_LIB: path to libjsoncpp.a

- lua
>- LUA_BIN_DIR: directory containing bin
>- LUA_LIB_DIR: directory containing lib
>- LUA_INCLUDE_DIR: directory containing headers
>- LUA_STATIC_LIB: path to liblua.a

- lz4
>- LZ4_INCLUDE_DIR: directory containing headers
>- LZ4_LIB_DIR: directory containing lib
>- LZ4_STATIC_LIB: path to lz4.a

- mysql
>- MYSQL_INCLUDE_DIR: directory containing headers
>- MYSQL_LIB_DIR: directory containing lib
>- MYSQL_STATIC_LIB: path to mysql.a

- openssl
>- OPENSSL_INCLUDE_DIR: directory containing headers
>- OPENSSL_LIB_DIR: directory containing lib
>- OPENSSL_STATIC_LIB: path to ssl.a

- protobuf
>- PROTOBUF_INCLUDE_DIR: directory containing headers
>- PROTOBUF_LIB_DIR: directory containing lib
>- PROTOBUF_STATIC_LIB: path to protobuf.a

- pybind11
>- PYBIND11_INCLUDE_DIR: directory containing headers

- rdkafka
>- RDKAFKA_INCLUDE_DIR: directory containing headers
>- RDKAFKA_LIB_DIR: directory containing lib
>- RDKAFKA_STATIC_LIB: path to rdkafka.a

- rocksdb
>- ROCKSDB_INCLUDE_DIR: directory containing headers
>- ROCKSDB_LIB_DIR: directory containing lib
>- ROCKSDB_STATIC_LIB: path to rocksdb.a

- snappy
>- SNAPPY_INCLUDE_DIR: directory containing headers
>- SNAPPY_LIB_DIR: directory containing lib
>- SNAPPY_STATIC_LIB: path to snappy.a

- sqlite3
>- SQLITE3_INCLUDE_DIR: directory containing headers
>- SQLITE3_LIB_DIR: directory containing lib
>- SQLITE3_STATIC_LIB: path to sqlite3.a

- talib
>- TALIB_INCLUDE_DIR: directory containing headers
>- TALIB_LIB_DIR: directory containing lib
>- TALIB_STATIC_LIB: path to libta_lib.a

- unixodbc
>- UNIXODBC_INCLUDE_DIR: directory containing headers
>- UNIXODBC_LIB_DIR: directory containing lib
>- UNIXODBC_STATIC_LIB: path to odbc.a

- zlib
>- ZLIB_INCLUDE_DIR: directory containing headers
>- ZLIB_LIB_DIR: directory containing lib
>- ZLIB_STATIC_LIB: path to libzlib.a

- zstd
>- ZSTD_INCLUDE_DIR: directory containing headers
>- ZSTD_LIB_DIR: directory containing lib
>- ZSTD_STATIC_LIB: path to libzstd.a

## 如何测试

mkdir build-test
cd build-test
cmake ../test

rm CMakeCache.txt
cmake ../test
