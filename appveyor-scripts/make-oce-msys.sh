#!/bin/sh
set -e
cd `dirname "$0"`/..
echo "$Arch"
if [ "$Arch" = "Win32" ]; then
  echo 'C:\MinGW\ /MinGW' > /etc/fstab
elif [ "$Arch" = "i686" ]; then
  f=i686-4.9.3-release-win32-sjlj-rt_v4-rev0.7z
  if ! [ -e $f ]; then
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.3/threads-win32/sjlj/$f
  fi
  7z x $f > /dev/null
  mv mingw32 /MinGW
else
  f=x86_64-5.1.0-release-win32-seh-rt_v4-rev0.7z
  if ! [ -e $f ]; then
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/5.1.0/threads-win32/seh/$f
  fi
  7z x $f > /dev/null
  mv mingw64 /MinGW
fi
g++ -v
# make oce
cd /c/projects/oce
mkdir cmake-build
cd cmake-build
cmake -DOCE_VISUALISATION:BOOL=ON \
      -DOCE_DATAEXCHANGE:BOOL=OFF -DOCE_OCAF:BOOL=OFF \
      -DOCE_WITH_GL2PS:BOOL=OFF \
      -DOCE_WITH_FREEIMAGE:BOOL=ON \
      -DOCE_TESTING:BOOL=ON \
      -DOCE_COPY_HEADERS_BUILD:BOOL=ON \
      -DOCE_INSTALL_PREFIX=C:\\oce-0.17.1-dev \
      -G'MSYS Makefiles' ..
mingw32-make -j4
mingw32-make install > /dev/null
#
# Finally run tests
#
export PATH=$PATH:/c/MinGW/bin:/c/oce-0.17.1-dev/$Arch/bin:/c/MinGW/bin:
mingw32-make test
