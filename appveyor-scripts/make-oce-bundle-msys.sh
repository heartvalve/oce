#!/bin/sh
echo 'C:\MinGW\ /MinGW' > /etc/fstab
ls
cd /c/projects/oce-win-bundle
mkdir cmake-build
cd cmake-build
cmake -DBUNDLE_BUILD_FREEIMAGE:BOOL=ON \
      -DBUNDLE_BUILD_FREETYPE:BOOL=ON \
      -DBUNDLE_BUILD_GL2PS:BOOL=OFF \
      -DBUNDLE_SHARED_LIBRARIES:BOOL=ON \
      -DOCE_WIN_BUNDLE_INSTALL_DIR=c:\\oce-win-bundle -G'MSYS Makefiles' ..
make
make install
