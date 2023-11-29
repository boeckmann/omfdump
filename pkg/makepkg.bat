rem SvarDOS package build script
md devel
md devel\omfdump
copy ..\omfdump.exe devel\omfdump
copy ..\LICENSE devel\omfdump
copy ..\README.txt devel\omfdump
del omfdump.svp
zip -9rDX omfdump.svp appinfo devel

