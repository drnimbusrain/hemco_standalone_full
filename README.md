README.md -- Describes contents of hemco_standalone_full
01 Aug 2014
Christoph Keller         and the GEOS-Chem Support Team
ckeller@seas.harvard.edu and     geos-chem-support@as.harvard.edu


Description:
------------

The hemco_standalone_full/ repository contains the makefile that will 
automatically download and build the following codes:

(1) NcdfUtilities: 
(2) HEMCO (Harvard-NASA Emissions Component)


Installation:
-------------

Please see our HEMCO Installation Guide for complete installation instructions:

  http://wiki.geos-chem.org/HEMCO_installation_guide

HEMCO requires that your system have a netCDF library installation, which 
can be either the newer (netCDF-4) or older (netCDF-classic) versions.  

The build sequence involves the following steps:

(1)  Making sure you have a version of the netCDF library installed on your
     system.  See this section of the HEMCO installation guide for more 
     information:

      http://wiki.geos-chem.org/HEMCO_installation_guide#Installing_the_netCDF_libraries 


(2)  Setting the proper environment variables.  See this section of the 
     HEMCO installation guide for more information:

     http://wiki.geos-chem.org/HEMCO_installation_guide#Setting_environment_variables_for_HEMCO_installation


(3)  Installing HEMCO and the NcdfUtilities package.  See this section of the
     HEMCO installation for more information:

     http://wiki.geos-chem.org/HEMCO_installation_guide#Installing_HEMCO_and_the_NcdfUtilities_packages 


(3a) As described in the above link, the installation sequence involves 
     a couple of simple steps:

     git clone https://github.com/christophkeller/hemco_standalone_full
     cd hemco_standalone_full
     make >& log

Upon successful installation, an HEMCO example simulation is performed. 
The resulting log file and ncdf emission field are written into the 
directory: HEMCO/examples/example1/output/

