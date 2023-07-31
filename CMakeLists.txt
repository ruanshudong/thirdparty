cmake_minimum_required(VERSION 3.15)

project(thirdparty_ci)
if(POLICY CMP0135)
cmake_policy(SET CMP0135 NEW)  # 设置CMP0135策略为新行为
endif()

if(WIN32)
    option(MT_MODE "default compiled as MD" off)
    if(MT_MODE)
        set(CMAKE_USER_MAKE_RULES_OVERRIDE "${CMAKE_SOURCE_DIR}/modules/ChangToMT.cmake")
    endif(MT_MODE)
endif(WIN32)

IF (UNIX)
    set(CMAKE_INSTALL_PREFIX "/usr/local/thirdparty" CACHE STRING "set install path" )
ELSE()
    set(CMAKE_INSTALL_PREFIX "c:/thirdparty/" CACHE STRING "set install path" )
ENDIF()

set(MSVC_TOOLSET_VERSION "v140")

option(BUILD_SHARED_LIBS "build shared libs" OFF)
option(BUILD_STATIC_LIBS "build static libs" ON)

INCLUDE(ExternalProject)

add_custom_target(thirdparty)

set(THIRDPARTY_URL "http://tars-thirdpart-1300910346.cos.ap-guangzhou.myqcloud.com/src")
set(THIRDPARTY_PATH "${CMAKE_BINARY_DIR}/src")

set(DEPENDS_LIST)

if(UNIX)
#    list(APPEND DEPENDS_LIST bison)
#    set(BISON_VERSION "3.8")
#    set(BISON_MD5 "77ea8b3b8260e22f9619e926f1927679")

#    list(APPEND DEPENDS_LIST flex)
#    set(FLEX_VERSION "2.6.4")
#    set(FLEX_MD5 "2882e3179748cc9f9c23ec593d6adc8d")

#    list(APPEND DEPENDS_LIST unixodbc)
#    set(UNIXODBC_VERSION "2.3.11")
#    set(UNIXODBC_MD5 "0ff1fdbcb4c3c7dc2357f3fd6ba09169")
#
    list(APPEND DEPENDS_LIST gperf)
    set(GPERF_VERSION "2.7")
    set(GPERF_MD5 "c6a852a817e9160c79bdb2d3101b4601")

    list(APPEND DEPENDS_LIST lua)
    set(LUA_VERSION "5.3.6")
    set(LUA_MD5 "83f23dbd5230140a3770d5f54076948d")

    list(APPEND DEPENDS_LIST clickhouse)
    set(CLICKHOUSE_MD5 "2f13d3c7ef95ceaca2f1858df8db5337")

endif(UNIX)

list(APPEND DEPENDS_LIST talib)
set(TALIB_VERSION "master")
set(TALIB_MD5 "1e39459d336b48e0792c963ec7bf70b4")

list(APPEND DEPENDS_LIST eigen)
set(EIGEN_VERSION "3.3.9")
set(EIGEN_MD5 "0a59748dad9bde63cc15bb29e48afe8d")

list(APPEND DEPENDS_LIST jsoncpp)
set(JSONCPP_VERSION "1.8.0")
set(JSONCPP_MD5 "6d6cbd82b5fe4a9cbae4ffef01f9e9fc")
#set(JSONCPP_VERSION "1.9.5")

# set(JSONCPP_MD5 "d6c8c609f2162eff373db62b90a051c7")

list(APPEND DEPENDS_LIST gtest)
set(GTEST_VERSION "1.10.0")
if (WIN32)
set(GTEST_MD5 "82358affdd7ab94854c8ee73a180fc53")
else(WIN32)
set(GTEST_MD5 "6f26d634fa9cac718263c2df20df21a4")
endif(WIN32)

list(APPEND DEPENDS_LIST glog)
set(GLOG_VERSION "0.5.0")
set(GLOG_MD5 "2368e3e0a95cce8b5b35a133271b480f")

list(APPEND DEPENDS_LIST gflags)
set(GFLAGS_VERSION "2.2.2")
set(GFLAGS_DIR ${THIRDPARTY_PATH}/gflags-${GFLAGS_VERSION})
set(GFLAGS_MD5 "1a865b93bacfa963201af3f75b7bd64c")

list(APPEND DEPENDS_LIST protobuf)
set(PROTOBUF_VERSION "3.5.1")
set(PROTOBUF_MD5 "710f1a75983092c9b45ecef207236104")

list(APPEND DEPENDS_LIST pybind11)
set(PYBIND11_VERSION "2.10.4")
set(PYBIND11_MD5 "812eda11d2a114fc0e841faf9626d2c9")

list(APPEND DEPENDS_LIST sqlite3)
set(SQLITE3_VERSION "3390300")
set(SQLITE3_MD5 "4dcc16363a2328c0c91a5a6b847fb9ff")

list(APPEND DEPENDS_LIST mysql)
set(MYSQL_VERSION "6.1.11")
if(WIN32)
	set(MYSQL_MD5 "bad636fe9bcc9bb62e3f5b784495a9b5")
else(WIN32)
	set(MYSQL_MD5 "3578d736b9d493eae076a67e3ed473eb")
endif(WIN32)

list(APPEND DEPENDS_LIST snappy)
set(SNAPPY_VERSION "1.1.8")
set(SNAPPY_DIR ${THIRDPARTY_PATH}/snappy-${SNAPPY_VERSION})
set(SNAPPY_MD5 "70e48cba7fecf289153d009791c9977f")

list(APPEND DEPENDS_LIST zlib)
set(ZLIB_VERSION "1.2.11")
set(ZLIB_DIR ${THIRDPARTY_PATH}/zlib-${ZLIB_VERSION})
set(ZLIB_MD5 "1c9f62f0778697a09d36121ead88e08e")


list(APPEND DEPENDS_LIST lz4)
set(LZ4_VERSION "1.9.3")
set(LZ4_DIR ${THIRDPARTY_PATH}/lz4-${LZ4_VERSION})
set(LZ4_MD5 "3a1ab1684e14fc1afc66228ce61b2db3")

list(APPEND DEPENDS_LIST zstd)
set(ZSTD_VERSION "1.5.2")
set(ZSTD_DIR ${THIRDPARTY_PATH}/zstd-${ZSTD_VERSION})
set(ZSTD_MD5 "6dc24b78e32e7c99f80c9441e40ff8bc")

set(CMAKE_MODULE_PATH "${THIRDPARTY_PATH}/zstd-${ZSTD_VERSION}/lib/cmake:${THIRDPARTY_PATH}/zlib-${ZLIB_VERSION}/lib/cmake")

message(${CMAKE_MODULE_PATH})
list(APPEND DEPENDS_LIST rocksdb)
set(ROCKSDB_VERSION "6.29.5")
#set(ROCKSDB_VERSION "6.15.5")
set(ROCKSDB_MD5 "be498cd7125f2a38059609469adf147f")
#set(ROCKSDB_MD5 "9bd64f1b7b74342ba4c045e9a6dd2bd2")

list(APPEND DEPENDS_LIST openssl)
set(OPENSSL_VERSION "1.1.1l")
set(OPENSSL_ROOT_DIR ${THIRDPARTY_PATH}/openssl-${OPENSSL_VERSION})
set(OPENSSL_MD5 "ac0d4387f3ba0ad741b0580dd45f6ff3")

list(APPEND DEPENDS_LIST gmssl)
set(GMSSL_VERSION "2.5.4")
if(WIN32)
set(GMSSL_MD5 "b3269b63fe88f50288077ec1f9ef2c98")
elseif(APPLE)
    if (CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
    set(GMSSL_MD5 "8fbaefd9cbbf19d063c8bf366db6d382")
    else()
    set(GMSSL_MD5 "71952a2d060e6e6defb1fbd1da04a468")
    endif()
else(WIN32)
set(GMSSL_MD5 "aa977233762646572f95509a8303b1a3")
endif(WIN32)

list(APPEND DEPENDS_LIST rdkafka)
set(RDKAFKA_VERSION "2.1.1")
set(RDKAFKA_MD5 "29a68127b849fff07892e89b08a341c9")

list(APPEND DEPENDS_LIST curl)
set(CURL_VERSION "7.75.0")
set(CURL_MD5 "2071994cfc5079d03439915f2751c8bc")

############################################################################################
set(CLEAR_INCLUDE "clear-install.cmake")
FILE(WRITE ${CLEAR_INCLUDE} "")
foreach (MODULE ${DEPENDS_LIST})
    FILE(APPEND ${CLEAR_INCLUDE} "EXECUTE_PROCESS(COMMAND ${CMAKE_COMMAND} -E rm -rf ${CMAKE_INSTALL_PREFIX}/${MODULE})\n")
endforeach ()

install(SCRIPT ${CLEAR_INCLUDE})

foreach (MODULE ${DEPENDS_LIST})
    include(cmake/${MODULE}.cmake)
endforeach ()

install(DIRECTORY modules DESTINATION ${CMAKE_INSTALL_PREFIX})

add_custom_target(build ALL DEPENDS thirdparty)

