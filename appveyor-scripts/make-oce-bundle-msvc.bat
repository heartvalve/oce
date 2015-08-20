cd C:\projects\oce-win-bundle
mkdir cmake-build
cd cmake-build
cmake -DBUNDLE_BUILD_FREEIMAGE:BOOL=ON ^
      -DBUNDLE_BUILD_FREETYPE:BOOL=ON ^
      -DBUNDLE_BUILD_GL2PS:BOOL=OFF ^
      -DBUNDLE_SHARED_LIBRARIES:BOOL=ON ^
      -DOCE_WIN_BUNDLE_INSTALL_DIR=C:\oce-win-bundle ^
      -G "%generator%" ..
msbuild /m:4 /verbosity:quiet /clp:ErrorsOnly /p:Configuration=Release oce-win-bundle.sln
msbuild /m:4 /verbosity:quiet /clp:ErrorsOnly /p:Configuration=Release INSTALL.vcxproj
