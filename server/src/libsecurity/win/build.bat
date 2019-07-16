set "command=%1"
if "%command%" == "clean" (
    echo "clean all build..."
    rm -rf CMakeFiles
    rm -rf Makefile
    rm -rf CMakeCache.txt
    rm -rf cmake_install.cmake
    rm -rf libsecurity.a
    ) else ( cmake -G "Visual Studio 16 2019" -A Win32 ../src )

