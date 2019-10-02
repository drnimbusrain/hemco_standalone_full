#------------------------------------------------------------------------------
#                  Harvard-NASA Emissions Component (HEMCO)                   !
#------------------------------------------------------------------------------
#BOP
#
# !MODULE: Makefile (in the top-level directory)
#
# !DESCRIPTION: Downloads and installs the following packages:
#
# \begin{enumerate}
# \item NcdfUtilities: Utility routines for netCDF I/O
# \item HEMCO: The Harvard-NASA Emissions Component (HEMCO), which relies
#       on having NcdfUtilities built first.
# \end{enumerate}
#\\
#\\
# !REMARKS:
# To build the programs, call "make" with the following syntax:
#                                                                             .
#   make -jN TARGET REQUIRED-FLAGS [ OPTIONAL-FLAGS ]
#                                                                             .
# To display a complete list of options, type "make help".
#                                                                             .
# !REVISION HISTORY: 
#  14 Jul 2014 - R. Yantosca - Initial version
#  17 Jul 2014 - R. Yantosca - Added calls to help screens
#  18 Jul 2014 - R. Yantosca - Print out HDF5 library paths
#  31 Jul 2014 - R. Yantosca - Now download NcdfUtilities from GitHub
#EOP
#------------------------------------------------------------------------------
#BOC

# Define variables
SHELL     :=/bin/bash
ROOT      :=$(CURDIR)

# Variables for the NcdfUtilities package
NCU_DIR   :=NcdfUtil
NCU_ROOT  :=$(ROOT)/$(NCU_DIR)
NCU_REPO  :="https://github.com/geoschem/ncdfutil"
NCU_CLONE :="git clone $(NCU_REPO) $(NCU_ROOT)"
NCU_BIN   :=$(NCU_ROOT)/bin
NCU_DOC   :=$(NCU_ROOT)/doc
NCU_HELP  :=$(NCU_ROOT)/help
NCU_MOD   :=$(NCU_ROOT)/mod
NCU_LIB   :=$(NCU_ROOT)/lib

# Variables for the HEMCO package
HCO_DIR   :=HEMCO
HCO_ROOT  :=$(ROOT)/$(HCO_DIR)
HCO_REPO  :="https://github.com/noaa-oar-arl/hemco_standalone"
HCO_CLONE :="git clone $(HCO_REPO) $(HCO_ROOT)"
SRC_REPO  :="https://github.com/noaa-oar-arl/hemco"
SRC_CLONE :="git clone $(SRC_REPO) $(HCO_ROOT)/src"
HCO_BIN   :=$(HCO_ROOT)/bin
HCO_DOC   :=$(HCO_ROOT)/doc
HCO_HELP  :=$(HCO_ROOT)/help
HCO_MOD   :=$(HCO_ROOT)/mod
HCO_LIB   :=$(HCO_ROOT)/lib

###############################################################################
###                                                                         ###
###  Makefile targets: type "make help" for a complete list!                ###
###                                                                         ###
###############################################################################

.PHONY: all_ncu        all_hemco        all
.PHONY: check_ncu      check_hemco      check  
.PHONY: clean_ncu      clean_hemco      
.PHONY: clone_ncu      clone_hemco
.PHONY: doc_ncu        doc_hemco        doc
.PHONY: help_ncu       help_hemco       help
.PHONY: realclean_ncu  realclean_hemco  realclean  distclean
.PHONY: remove_ncu     remove_hemco     remove
.PHONY: display_vars   debug            help

#-------------------------------------------
# Targets for building NcdfUtil + HEMCO
#-------------------------------------------

all:
	@$(MAKE) all_ncu
	@$(MAKE) all_hemco
	@$(MAKE) display_vars

check:
	@$(MAKE) check_ncu
	@$(MAKE) check_hemco

doc:
	@$(MAKE) doc_ncu
	@$(MAKE) doc_hemco

distclean: realclean

realclean: 
	@$(MAKE) realclean_ncu
	@$(MAKE) realclean_hemco

remove:
	@$(MAKE) remove_ncu
	@$(MAKE) remove_hemco

#----------------------------------------------
# Targets for installing only NcdfUtil
#----------------------------------------------

all_ncu:
	@$(MAKE) clone_ncu
	@$(MAKE) install_ncu

check_ncu:
	@$(MAKE) -C $(NCU_ROOT) check

clean_ncu:
	@$(MAKE) -C $(NCU_ROOT) clean
	rm -f $(NCU_ROOT)/$(NCU_DIR).install

clone_ncu:
	if [[ -f $(NCU_ROOT)/$(NCU_DIR).clone ]] ; then                       \
	   echo '##################################################';         \
	   echo '### NcdfUtil has been previously downloaded!   ###';         \
	   echo '##################################################';         \
	else                                                                  \
	   bash -c $(NCU_CLONE)                                             &&\
	   cd $(NCU_ROOT)                                                   &&\
	   touch $(NCU_DIR).clone                                           &&\
	   echo '##################################################';         \
	   echo '### NcdfUtil has been downloaded successfully! ###';         \
	   echo '##################################################';         \
	fi      

doc_ncu:
	@$(MAKE) -C $(NCU_DOC) all

distclean_ncu: realclean_ncu

install_ncu:
	if [[ -f $(NCU_ROOT)/$(NCU_DIR).install ]] ; then                     \
	   echo '##################################################';         \
	   echo '### NcdfUtil has been previously installed!    ###';         \
	   echo '##################################################';         \
	else                                                                  \
	   cd $(NCU_ROOT)                                                   &&\
	   $(MAKE) lib                                                      &&\
	   $(MAKE) check                                                    &&\
	   touch $(NCU_DIR).install                                         &&\
	   echo '##################################################';         \
	   echo '### NcdfUtil has been installed successfully!  ###';         \
	   echo '##################################################';         \
	fi      

realclean_ncu:
	@$(MAKE) -C $(NCU_ROOT) clean
	rm -f $(NCU_ROOT)/$(NCU_DIR).install

remove_ncu:
	rm -rf $(NCU_ROOT)

#-------------------------------------------
#  Targets for installing only HEMCO
#-------------------------------------------

all_hemco:
	@$(MAKE) clone_hemco
	@$(MAKE) install_hemco 

clone_hemco:
	if [[ -f $(HCO_ROOT)/$(HCO_DIR).clone ]] ; then                       \
	   echo '##################################################';         \
	   echo '### HEMCO has been previously downloaded!      ###';         \
	   echo '##################################################';         \
	else                                                                  \
	   bash -c $(HCO_CLONE)                                             &&\
	   bash -c $(SRC_CLONE)                                             &&\
	   cd $(HCO_ROOT)                                                   &&\
	   touch $(NCU_DIR).clone                                           &&\
	   echo '##################################################';         \
	   echo '### HEMCO has been downloaded successfully!    ###';         \
	   echo '##################################################';         \
	fi      

clean_hemco:
	@$(MAKE) -C $(HCO_ROOT) clean

check_hemco:
	@$(MAKE) -C $(HCO_ROOT) check \
           NCU_BIN=$(NCU_BIN) NCU_LIB=$(NCU_LIB) NCU_MOD=$(NCU_MOD)
debug_hemco:
	@$(MAKE) -C $(HCO_ROOT) debug \
           NCU_BIN=$(NCU_BIN) NCU_LIB=$(NCU_LIB) NCU_MOD=$(NCU_MOD)

distclean_hemco: realclean_hemco

doc_hemco:
	@$(MAKE) -C $(HCO_DOC) all

install_hemco:
	if [[ -f $(HCO_ROOT)/$(HCO_DIR).install ]] ; then                     \
	   echo '##################################################';         \
           echo '### HEMCO has been previously installed!       ###';         \
	   echo '##################################################';         \
	else                                                                  \
	   cd $(HCO_ROOT)                                                   &&\
	   $(MAKE) lib                                                        \
	       NCU_BIN=$(NCU_BIN) NCU_LIB=$(NCU_LIB) NCU_MOD=$(NCU_MOD)     &&\
	   $(MAKE) check                                                      \
               NCU_BIN=$(NCU_BIN) NCU_LIB=$(NCU_LIB) NCU_MOD=$(NCU_MOD)     &&\
	   touch $(HCO_DIR).install                                         &&\
	   echo '##################################################';         \
           echo '### HEMCO has been installed successfully!     ###';         \
	   echo '##################################################';         \
	fi      	

realclean_hemco:
	@$(MAKE) -C $(HCO_ROOT) realclean
	rm -f $(HCO_ROOT)/$(HCO_DIR).install

remove_hemco:
	rm -rf $(HCO_ROOT)

#-------------------------------------------
#  Targets for debug & help screens
#-------------------------------------------

display_vars:
	@echo "###########################################################"
	@echo "###       Environment Variable Settings for HEMCO       ###"
	@echo "###########################################################"
	@echo ""
	@echo "If your login environment uses csh or tcsh:"
	@echo "-------------------------------------------"
	@echo "setenv BIN_NETCDF $(BIN_NETCDF)"
	@echo "setenv INC_NETCDF $(INC_NETCDF)"
	@echo "setenv LIB_NETCDF $(LIB_NETCDF)"
	@echo "setenv BIN_HDF5   $(BIN_HDF5)"
	@echo "setenv INC_HDF5   $(INC_HDF5)"
	@echo "setenv LIB_HDF5   $(LIB_HDF5)"
	@echo "setenv NCU_BIN    $(NCU_BIN)"
	@echo "setenv NCU_LIB    $(NCU_LIB)"
	@echo "setenv NCU_MOD    $(NCU_MOD)"
	@echo "setenv HCO_BIN    $(HCO_BIN)"
	@echo "setenv HCO_LIB    $(HCO_LIB)"
	@echo "setenv HCO_MOD    $(HCO_MOD)"
	@echo ""
	@echo "If your login environment uses bash:"
	@echo "-------------------------------------------"
	@echo "export BIN_NETCDF=$(BIN_NETCDF)"
	@echo "export INC_NETCDF=$(INC_NETCDF)"
	@echo "export LIB_NETCDF=$(LIB_NETCDF)"
	@echo "export BIN_HDF5=$(BIN_HDF5)"
	@echo "export INC_HDF5=$(INC_HDF5)"
	@echo "export LIB_HDF5=$(LIB_HDF5)"
	@echo "export NCU_BIN=$(NCU_BIN)"
	@echo "export NCU_LIB=$(NCU_LIB)"
	@echo "export NCU_MOD=$(NCU_MOD)"
	@echo "export HCO_BIN=$(HCO_BIN)"
	@echo "export HCO_LIB=$(HCO_LIB)"
	@echo "export HCO_MOD=$(HCO_MOD)"

debug:
	@echo "%%% Makefile variable settings %%%"
	@echo "SHELL      : $(SHELL)"
	@echo "ROOT       : $(ROOT)"
	@echo "%%% For the NcdfUtilities %%%"
	@echo "NCU_ROOT   : $(NCU_ROOT)"
	@echo "NCU_REPO   : $(NCU_REPO)"
	@echo "NCU_CLONE  : $(NCU_CLONE)"
	@echo "NCU_BIN    : $(NCU_BIN)"
	@echo "NCU_DOC    : $(NCU_DOC)"
	@echo "NCU_HELP   : $(NCU_HELP)"
	@echo "NCU_MOD    : $(NCU_MOD)"
	@echo "NCU_LIB    : $(NCU_LIB)"
	@echo "%%% For HEMCO emissions component %%%"
	@echo "HCO_ROOT   : $(HCO_ROOT)"
	@echo "HCO_REPO   : $(HCO_REPO)"
	@echo "HCO_CLONE  : $(HCO_CLONE)"
	@echo "HCO_BIN    : $(HCO_BIN)"
	@echo "HCO_DOC    : $(HCO_DOC)"
	@echo "HCO_HELP   : $(HCO_HELP)"
	@echo "HCO_MOD    : $(HCO_MOD)"
	@echo "HCO_LIB    : $(HCO_LIB)"
	@echo "%%% For netCDF library paths %%%"
	@echo "BIN_NETCDF : $(BIN_NETCDF)"
	@echo "INC_NETCDF : $(INC_NETCDF)"
	@echo "LIB_NETCDF : $(LIB_NETCDF)"
	@echo "BIN_HDF5   : $(BIN_HDF5)"
	@echo "INC_HDF5   : $(INC_HDF5)"
	@echo "LIB_HDF5   : $(LIB_HDF5)"

help:
	@$(MAKE) help_ncu
	@$(MAKE) help_hemco

help_ncu:
	$(MAKE) -C $(NCU_ROOT) help

help_hemco:
	$(MAKE) -C $(HCO_ROOT) help
#EOC



