setx path "%path%;C:\Program Files\OpenSCAD\"
cd %cd%
cd scad
for %%f in (*.scad) do openscad -o "..\STL\%%~nf.stl" "%%f" 