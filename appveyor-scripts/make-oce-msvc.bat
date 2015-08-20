cd C:\projects\oce
mkdir cmake-build
cd cmake-build
cmake -DOCE_VISUALISATION:BOOL=ON -DOCE_DATAEXCHANGE:BOOL=ON -DOCE_OCAF:BOOL=ON ^
      -DOCE_WITH_GL2PS:BOOL=OFF ^
      -DOCE_WITH_FREEIMAGE:BOOL=ON ^
      -DOCE_TESTING:BOOL=OFF ^
      -DFREETYPE_INCLUDE_DIR_freetype2=C:\oce-win-bundle\include\freetype ^
      -DFREETYPE_INCLUDE_DIR_ft2build=C:\oce-win-bundle\include\freetype ^
      -DFREETYPE_LIBRARY=C:\oce-win-bundle\%ARCH%\lib\freetype.lib ^
      -DFREEIMAGE_INCLUDE_DIR=C:\oce-win-bundle\include\FreeImage ^
      -DFREEIMAGE_LIBRARY=C:\oce-win-bundle\%ARCH%\lib\FreeImage.lib ^
      -DFREEIMAGEPLUS_LIBRARY=C:\oce-win-bundle\%ARCH%\lib\FreeImagePlus.lib ^
      -DOCE_INSTALL_PREFIX=C:\oce-0.17.1-dev ^
      -G "%generator%" ..
msbuild /m:4 /verbosity:quiet /p:Configuration=%configuration% oce.sln
msbuild /m:4 /verbosity:quiet /p:Configuration=%configuration% INSTALL.vcxproj
