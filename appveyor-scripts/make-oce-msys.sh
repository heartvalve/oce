http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/5.1.0/threads-win32/seh/x86_64-5.1.0-release-win32-seh-rt_v4-rev0.7z/download
#!/bin/sh
set -e
cd `dirname "$0"`/..
if [ "$Arch" = "Win32" ]; then
  echo 'C:\MinGW\ /MinGW' > /etc/fstab
elif [ "$Arch" = "i686" ]; then
  f=i686-4.9.2-release-win32-sjlj-rt_v3-rev1.7z
  if ! [ -e $f ]; then
    curl -LsSO http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-win32/sjlj/$f
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
#
# Build oce dependencies
#
cd /c/projects/oce-win-bundle
mkdir cmake-build
cd cmake-build
cmake -DBUNDLE_BUILD_FREEIMAGE:BOOL=OFF \
      -DBUNDLE_BUILD_FREETYPE:BOOL=ON \
      -DBUNDLE_BUILD_GL2PS:BOOL=OFF \
      -DBUNDLE_SHARED_LIBRARIES:BOOL=ON \
      -DOCE_WIN_BUNDLE_INSTALL_DIR=c:\\oce-win-bundle \
      -G'MSYS Makefiles' ..
mingw32-make -j4
mingw32-make install
#
# Then make oce
#
cd /c/projects/oce
mkdir cmake-build
cd cmake-build
cmake -DOCE_VISUALISATION:BOOL=OFF \
      -DOCE_DATAEXCHANGE:BOOL=OFF -DOCE_OCAF:BOOL=OFF \
      -DOCE_WITH_GL2PS:BOOL=OFF \
      -DOCE_WITH_FREEIMAGE:BOOL=OFF \
      -DOCE_TESTING:BOOL=OFF \
      -DOCE_COPY_HEADERS_BUILD:BOOL=ON \
      -DFREETYPE_INCLUDE_DIR_freetype2=C:\\oce-win-bundle\\include\\freetype \
      -DFREETYPE_INCLUDE_DIR_ft2build=C:\\oce-win-bundle\\include\\freetype \
      -DFREETYPE_LIBRARY=c:\\oce-win-bundle\\$Arch\\lib\\freetype.lib \
      -DFREEIMAGE_INCLUDE_DIR=C:\\oce-win-bundle\include\\FreeImage \
      -DFREEIMAGE_LIBRARY=C:\\oce-win-bundle\\$Arch\\lib\\FreeImage.lib \
      -DFREEIMAGEPLUS_LIBRARY=C:\\oce-win-bundle\\$Arch\\lib\\FreeImagePlus.lib \
      -DOCE_INSTALL_PREFIX=C:\\oce-0.17.1-dev \
      -G'MSYS Makefiles' ..
mingw32-make -j4
mingw32-make install > /dev/null
