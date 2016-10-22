
D:
set OPENSSL_VERSION=1.0.2j
set SEVENZIP="C:\Program Files\7-Zip\7z.exe"
set VS2015="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\vcvars32.bat"
set VS2015_AMD64="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat"


REM Remove openssl source directories
IF NOT EXIST "D:\openssl-src-win32" GOTO NO_WIN32_SOURCE
DEL "D:\openssl-src-win32" /Q /F /S
RMDIR /S /Q "D:\openssl-src-win32"
:NO_WIN32_SOURCE

IF NOT EXIST "D:\openssl-src-win64" GOTO NO_WIN64_SOURCE
DEL "D:\openssl-src-win64" /Q /F /S
RMDIR /S /Q "D:\openssl-src-win64"
:NO_WIN64_SOURCE

IF NOT EXIST "D:\openssl-%OPENSSL_VERSION%" GOTO NO_OPENSSL_SOURCE
DEL "D:\openssl-%OPENSSL_VERSION%" /Q /F /S
RMDIR /S /Q "D:\openssl-%OPENSSL_VERSION%"
:NO_OPENSSL_SOURCE

del openssl-%OPENSSL_VERSION%.tar
%SEVENZIP% e openssl-%OPENSSL_VERSION%.tar.gz
%SEVENZIP% x openssl-%OPENSSL_VERSION%.tar
ren openssl-%OPENSSL_VERSION% openssl-src-win32-VS2015
%SEVENZIP% x openssl-%OPENSSL_VERSION%.tar
ren openssl-%OPENSSL_VERSION% openssl-src-win64-VS2015

CALL %VS2015%

cd \openssl-src-win32-VS2015
perl Configure VC-WIN32 --prefix=D:\openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2015
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2015
REM nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN32 --prefix=D:\openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2015
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\ntdll.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2015
REM nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure VC-WIN32 --prefix=D:\openssl-%OPENSSL_VERSION%-32bit-release-static-VS2015
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2015
REM nmake -f ms\ntdll.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN32 --prefix=D:\openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2015
call ms\do_ms.bat
call ms\do_nasm.bat
nmake -f ms\nt.mak
REM cd \
REM python patch_ntdll_mak.py
REM cd \openssl-src-win32-VS2015
REM nmake -f ms\ntdll.mak
nmake -f ms\nt.mak install

CALL %VS2015_AMD64%

cd \openssl-src-win64-VS2015
perl Configure VC-WIN64A --prefix=D:\openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2015
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

perl Configure debug-VC-WIN64A --prefix=D:\openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2015
call ms\do_win64a.bat
nmake -f ms\ntdll.mak
nmake -f ms\ntdll.mak install

cd \openssl-src-win64-VS2015
perl Configure VC-WIN64A --prefix=D:\openssl-%OPENSSL_VERSION%-64bit-release-static-VS2015
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

perl Configure debug-VC-WIN64A --prefix=D:\openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2015
call ms\do_win64a.bat
nmake -f ms\nt.mak
nmake -f ms\nt.mak install

cd \
python copy_openssl_pys.py

%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2015.7z openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2015.7z openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2015.7z openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2015.7z openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2015.7z openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-32bit-release-static-VS2015.7z openssl-%OPENSSL_VERSION%-32bit-release-static-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2015.7z openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2015\*
%SEVENZIP% a -r openssl-%OPENSSL_VERSION%-64bit-release-static-VS2015.7z openssl-%OPENSSL_VERSION%-64bit-release-static-VS2015\*

DEL openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-32bit-release-static-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2015 /Q /F /S
DEL openssl-%OPENSSL_VERSION%-64bit-release-static-VS2015 /Q /F /S

RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-DLL-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-DLL-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-DLL-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-DLL-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-debug-static-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-32bit-release-static-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-debug-static-VS2015
RMDIR /S /Q openssl-%OPENSSL_VERSION%-64bit-release-static-VS2015

