call "%VS140COMNTOOLS%\..\..\VC\bin\amd64\vcvars64.bat"

which cmake
set PATH=D:\Anaconda3\Scripts;%PATH%
echo %PATH%

echo "---------------------make sdk begin-------------------------"
set build_dir="build"

cmake -E remove_directory dist
cmake -E make_directory dist

cmake -E remove_directory build
cmake -E make_directory build

cmake -E chdir build cmake .. -A x64 -Tv140 -DMSVC_TOOLSET_VERSION=140 -DMT_MODE=on -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=dist
cmake -E chdir build cmake --build . --config release --target ALL_BUILD -- /maxcpucount:4
echo "-----------------------make sdk end-------------------------"
