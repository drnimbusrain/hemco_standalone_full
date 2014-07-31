hemco_standalone_full
=====================

This is the makefile for the full HEMCO standalone model. Both the HEMCO code and the GEOS-Chem netCDF libraries become
automatically installed. To install, clone this file followed by make:

git clone https://github.com/christophkeller/hemco_standalone_full hemco_standalone
cd hemco_standalone
make

Upon successful installation, an HEMCO example simulation is performed. The resulting log file and ncdf emission field
are written into HEMCO/examples/example1/output/

Contact: ckeller@seas.harvard.edu
