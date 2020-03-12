![image](https://github.com/patternizer/chimere-tools/blob/master/WRF_CHIMERE_Temperature_20090312.jpg)
![image](https://github.com/patternizer/chimere-tools/blob/master/WRF_CHIMERE_Precipitation_20090312.jpg)
![image](https://github.com/patternizer/chimere-tools/blob/master/HCHO_20130428.jpg)
![image](https://github.com/patternizer/chimere-tools/blob/master/plot_PM25_2d.jpg)
![image](https://github.com/patternizer/chimere-tools/blob/master/plot_PM25_3d_video.mp4)

# chimere-tools

Development version of MATLAB code written while working on ESA Ozone_CCI and EUMETSAT AC SAF tasks at LAP-AUTh
to read in the output files of spin-up runs of the chemical transport model CHIMERE 
https://www.lmd.polytechnique.fr/chimere/ and then process and generate profile plots and a 3D projection of 
atmospheric layer scalars.

## Contents

* `ndisp_variables.txt` - metadata file for the CHIMERE output file (chimere.nc)
* `plot_2d_3d_chemical_distributions.m` - reads 3D scalar species concentration data from chimere.nc and generates filled contours as a function of pressure level
* `plot_HCHO_vertical_profiles.m` - reads in CHIMERE HCHO vertical profile data and co-located GOME2 and OMI profile data and plot per timestamp
* `plot_CHIMERE_on_WRF_fields.m` - reads in WRF fields (wrfout_filename.nc) and CHIMERE fields (meteo_filename.nc) and overlays Cartesian on Lambertian projection
* `distinguishable_colors.m` - helper function to set colour map range
* `PzWRF.m` - function to convert n pressure levels into altitudes in metres

The first step is to clone latest chimere-tools code and step into the check out directory: 

    $ git clone https://github.com/patternizer/chimere-tools.git
    $ cd chimere-tools
    
### Using MATLAB

The codes should run with a netCDF4 compatible version of Octave or directly at the MATLAB command line: 

    >> plot_2d_3d_chemical_distributions

and so on. For chemical species names please refer to the long_names of Variables listed in ndisp_variables.txt.
        
## License

The code is distributed under terms and conditions of the [MIT license](https://opensource.org/licenses/MIT).

## Contact information

* [Michael Taylor](https://patternizer.github.io)


