
if (UNIX)
    set(THIRDPARTY_HOME "/usr/local/thirdparty")
else ()
    set(THIRDPARTY_HOME "C:/thirdparty")
endif ()

#mysql 可选
option(WITH_MYSQL "build with MYSQL" ON)
if (WITH_MYSQL)
    set(MYSQL_HOME ${THIRDPARTY_HOME}/mysql)
    find_package(Mysql)
endif ()

option(WITH_JSONCPP "build with json" ON)
if (WITH_JSONCPP)
    set(JSONCPP_HOME ${THIRDPARTY_HOME}/jsoncpp)
    find_package(Jsoncpp)
endif ()

option(WITH_EIGEN "build with Eigen" ON)
if (WITH_EIGEN)
    set(EIGEN_HOME ${THIRDPARTY_HOME}/eigen)
    find_package(Eigen)
endif ()

option(WITH_TALIB "build with TA-lib" ON)
if (WITH_TALIB)
    set(TALIB_HOME ${THIRDPARTY_HOME}/talib)
    find_package(Talib)
endif ()

#option(WITH_FLEX "build with Flex" ON)
#if (WITH_FLEX)
#    set(FLEX_HOME ${THIRDPARTY_HOME}/flex)
#    find_package(Flex)
#endif ()
#
#option(WITH_BISON "build with Bison" ON)
#if (WITH_BISON)
#    set(BISON_HOME ${THIRDPARTY_HOME}/bison)
#    find_package(Bison)
#endif ()
#
option(WITH_CURL "build with curl" ON)
if (WITH_CURL)
    set(CURL_HOME ${THIRDPARTY_HOME}/curl)
    find_package(Curl)
endif ()

option(WITH_GTEST "build with gtest" ON)
if (WITH_GTEST)
    set(GTEST_HOME ${THIRDPARTY_HOME}/gtest)
    find_package(Gtest)
endif ()

option(WITH_GFLAG "build with gflag" ON)
if (WITH_GFLAG)
    set(GFLAG_HOME ${THIRDPARTY_HOME}/gflag)
    find_package(Gflag)
endif ()

option(WITH_GLOG "build with glog" ON)
if (WITH_GLOG)
    set(GLOG_HOME ${THIRDPARTY_HOME}/glog)
    find_package(Glog)
endif ()

option(WITH_GMSSL "build with gmssl" ON)
if (WITH_GMSSL)
    set(GMSSL_HOME ${THIRDPARTY_HOME}/gmssl)
    find_package(Gmssl)
endif ()

option(WITH_GPERF "build with gperf" ON)
if (WITH_GPERF)
    set(GPERF_HOME ${THIRDPARTY_HOME}/gperf)
    find_package(Gperf)
endif ()

option(WITH_LUA "build with lua" ON)
if (WITH_LUA)
    set(LUA_HOME ${THIRDPARTY_HOME}/lua)
    find_package(Lua)
endif ()

option(WITH_LZ4 "build with lz4" ON)
if (WITH_LZ4)
    set(LZ4_HOME ${THIRDPARTY_HOME}/lz4)
    find_package(Lz4)
endif ()

option(WITH_OPENSSL "build with openssl" ON)
if (WITH_OPENSSL)
    set(OPENSSL_HOME ${THIRDPARTY_HOME}/openssl)
    find_package(Openssl)
endif ()

option(WITH_PROTOBUF "build with protobuf" ON)
if (WITH_PROTOBUF)
    set(PROTOBUF_HOME ${THIRDPARTY_HOME}/protobuf)
    find_package(Protobuf)
endif ()

option(WITH_PYBIND11 "build with pybind11" ON)
if (WITH_PYBIND11)
    set(PYBIND11_HOME ${THIRDPARTY_HOME}/pybind11)
    find_package(Pybind11)
endif ()

option(WITH_RDKAFKA "build with rdkafka" ON)
if (WITH_RDKAFKA)
    set(RDKAFKA_HOME ${THIRDPARTY_HOME}/rdkafka)
    find_package(Rdkafka)
endif ()

option(WITH_ROCKSDB "build with rocksdb" ON)
if (WITH_ROCKSDB)
    set(ROCKSDB_HOME ${THIRDPARTY_HOME}/rocksdb)
    find_package(Rocksdb)
endif ()

option(WITH_SNAPPY "build with snappy" ON)
if (WITH_SNAPPY)
    set(SNAPPY_HOME ${THIRDPARTY_HOME}/snappy)
    find_package(Snappy)
endif ()

option(WITH_SQLITE3 "build with sqlite3" ON)
if (WITH_SQLITE3)
    set(SQLITE3_HOME ${THIRDPARTY_HOME}/sqlite3)
    find_package(Sqlite3)
endif ()

#option(WITH_UNIXODBC "build with unixodbc" ON)
#if (WITH_UNIXODBC)
#    set(UNIXODBC_HOME ${THIRDPARTY_HOME}/unixodbc)
#    find_package(Unixodbc)
#endif ()
#

option(WITH_ZLIB "build with zlib" ON)
if (WITH_ZLIB)
    set(ZLIB_HOME ${THIRDPARTY_HOME}/zlib)
    find_package(Zlib)
endif ()

option(WITH_ZSTD "build with zstd" ON)
if (WITH_ZSTD)
    set(ZSTD_HOME ${THIRDPARTY_HOME}/zstd)
    find_package(Zlib)
endif ()

option(WITH_CLICKHOUSE "build with clickhouse" ON)
if (WITH_CLICKHOUSE)
    set(CLICKHOUSE_HOME ${THIRDPARTY_HOME}/clickhouse)
    find_package(Clickhouse)
endif ()
