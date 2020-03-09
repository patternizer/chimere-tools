![image](https://github.com/patternizer/chimere-tools/T22.jpg)
![image](https://github.com/patternizer/chimere-tools/HCHO_20130428.jpg)
![image](https://github.com/patternizer/chimere-tools/SO2.jpg)

# chimere-tools

Development version of MATLAB code written while working on ESA Ozone_CCI and EUMETSAT AC SAF tasks at LAP-AUTh
to read in the output files of spin-up runs of the chemical transport model CHIMERE 
https://www.lmd.polytechnique.fr/chimere/ and then process and generate profile plots and a 3D projection of 
atmospheric layer scalars.

## Contents

* `chimere-tools.py` - main script to be run with Python 3.6+
* `chimere.nc` - CHIMERE output file in netCDF4 format
* `ndisp_variables.txt` - metadata file for the output file chimere.nc
* `set_contour_z_level.m` - calculates the vertical pressure levels used by netcdf_reader.m
* `netcdf_reader.m` - reads 3D scalar species concentration data from chimere.nc and generates atmospheric layer contours whose vertical separation is determined by set_contour_z_level.m
* `netcdf_reader2.m` - reads in WRF field (wrfout_filename.nc) and CHIMERE meteorology field (meteo_filename.nc) and overlays Cartesian on Lambertian projection
* `distinguishable_colors.m` - helper function to set colour map range
* `PzWRF.m` - function to convert n pressure levels into altitudes in metres
* `plotter.m` - routine that reads in and plots vertical profiles and corresponding WRF levels in km 

The first step is to clone latest chimere-tools code and step into the check out directory: 

    $ git clone https://github.com/patternizer/chimere-tools.git
    $ cd chimere-tools
    
### Using MATLAB

The codes should run with a netCDF4 compatible version of Octave or directly at the MATLAB command line: 

    >> netcdf_reader2
	
For chemical species names please refer to the long_names of Variables listed in ndisp_variables.txt.
        
## License

The code is distributed under terms and conditions of the [MIT license](https://opensource.org/licenses/MIT).

## Contact information

* [Michael Taylor](https://patternizer.github.io)


