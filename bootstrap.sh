#!/bin/bash
source ~/.bash_profile

echo "-----------------------begin make tsb----------------------"

cmake -E remove_directory build_debug
cmake -E make_directory build_debug

#安装 debug 版本
# cmake -E chdir build_debug cmake .. -DCMAKE_BUILD_TYPE=Debug 
# cmake -E chdir build_debug cmake --build . --config debug --target install -- -j 8

#删除目录
cmake -E remove_directory build_release
cmake -E make_directory build_release

#安装 默认 release 版本
cmake -E chdir build_release cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/thirdparty_ci
cmake -E chdir build_release cmake --build . --config release --target tar -- -j 8
cmake -E chdir build_release cmake --build . --config release --target install -- -j 8

echo "-----------------------make sdk success----------------------"

