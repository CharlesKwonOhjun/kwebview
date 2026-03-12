@echo off
REM Build webview.dll for 32-bit and 64-bit - Charles KWON (KWON OhJun) charleskwonohjun@gmail.com
REM Run this from: D:\charles\kwebview\

setlocal

set VSDIR=C:\Program Files\Microsoft Visual Studio\2022\Community
set CMAKE="%VSDIR%\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
set NINJA="%VSDIR%\Common7\IDE\CommonExtensions\Microsoft\CMake\Ninja\ninja.exe"

REM ============================================================
REM  64-bit Build
REM ============================================================
echo.
echo ========================================
echo  Building 64-bit (x64)
echo ========================================
call "%VSDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64

%CMAKE% -G "Ninja" -B build\x64 -S . ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_MAKE_PROGRAM=%NINJA% ^
    -DWEBVIEW_BUILD_SHARED_LIBRARY=ON ^
    -DWEBVIEW_BUILD_STATIC_LIBRARY=OFF ^
    -DWEBVIEW_BUILD_EXAMPLES=OFF ^
    -DWEBVIEW_BUILD_TESTS=OFF ^
    -DWEBVIEW_BUILD_DOCS=OFF

%CMAKE% --build build\x64 --config Release

if exist build\x64\core\webview.dll (
    if not exist output\x64 mkdir output\x64
    copy /Y build\x64\core\webview.dll output\x64\webview.dll
    copy /Y build\x64\core\webview.lib output\x64\webview.lib
    echo [OK] 64-bit DLL: output\x64\webview.dll
) else (
    echo [ERROR] 64-bit build failed
)

REM ============================================================
REM  32-bit Build
REM ============================================================
echo.
echo ========================================
echo  Building 32-bit (x86)
echo ========================================
call "%VSDIR%\VC\Auxiliary\Build\vcvarsall.bat" x86

%CMAKE% -G "Ninja" -B build\x86 -S . ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_MAKE_PROGRAM=%NINJA% ^
    -DWEBVIEW_BUILD_SHARED_LIBRARY=ON ^
    -DWEBVIEW_BUILD_STATIC_LIBRARY=OFF ^
    -DWEBVIEW_BUILD_EXAMPLES=OFF ^
    -DWEBVIEW_BUILD_TESTS=OFF ^
    -DWEBVIEW_BUILD_DOCS=OFF

%CMAKE% --build build\x86 --config Release

if exist build\x86\core\webview.dll (
    if not exist output\x86 mkdir output\x86
    copy /Y build\x86\core\webview.dll output\x86\webview.dll
    copy /Y build\x86\core\webview.lib output\x86\webview.lib
    echo [OK] 32-bit DLL: output\x86\webview.dll
) else (
    echo [ERROR] 32-bit build failed
)

echo.
echo ========================================
echo  Build Complete
echo ========================================
if exist output\x64\webview.dll echo  x64: output\x64\webview.dll
if exist output\x86\webview.dll echo  x86: output\x86\webview.dll
echo ========================================

endlocal
pause
