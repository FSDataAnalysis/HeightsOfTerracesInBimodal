---
title: "Markdown"
author: "Power laws in the nanoscale et al."
date: "Sunday, August 23, 2015"
output: html_document
---

<!--( Detailed usage of the R and Matlab scripts employed to produce
the data for the paper:

Reconstruction of height of sub-nm steps with bimodal atomic force microscopy 

Chia-Yun Lai, Sergio Santos, Matteo Chiesa

Laboratory for Energy and NanoScience (LENS), Institute Center for Future Energy (iFES), Masdar Institute of Science and Technology, Abu Dhabi, UAE
	
	Abstract	
Obtaining topographic images of surfaces presenting terraces with heights in the nm and sub-nm range has become routine since the advent of atomic force microscopy (AFM). There remain however several open questions regarding the validity of direct topographic measurements. Here we turn to recent advances in AFM to correct the  height of nanometric terraces by exploiting the four observables of bimodal AFM operated in the non-invasive attractive regime. We first derive expressions based on the van der Waals theory and  then image model terraces in air in standard bimodal AFM while simultaneously correcting and decoupling the sources of loss/gain of height. 
Keywords: terraces, height, afm, bimodal

)--> 


# DATA sets and contents for:

*Reconstruction of height of sub-nm steps with bimodal atomic force microscopy *

by 

Chia-Yun Lai,Sergio Santos, Matteo Chiesa


Laboratory for Energy and NanoScience (LENS), Institute Center for Future Energy (iFES), Masdar Institute of Science and Technology, Abu Dhabi, UAE


## Details for acccessing raw data 

### Raw data

The raw data to produce the force profiles was processed with a matlab code (*available upon request* contacting [here](http://www.lens-online.net/)  Dr M Chiesa).  The raw data and code can be found upon request (link above for password and username) in https://github.com/HeightsOfTerracesInBimodal

*IMPORTANT NOTE*

All the raw data can also be found in a dropbox account with the same name 
and password as this account. 




### CODES (matlab)

The code employed for the bimodal images is found in the fodlers:

1. CODE_Calcite

2. CODE_GRAPHITE

Inside these folders there is a main matlab script file called *Bimodal_Theory_20150908.m*

In this file the parameters employed to run the codes can be found. 

The steps are:

1) Go into the folders termed DATA_images and *unzip the raw data* for the bimodal images. 

2) Run the file *Bimodal_Theory_20150908.m*

The figures will be produced and stored into a subfolder in the *DATA_images* subfolder. The names are obvious for each file. 

All the output data is stored in a mat file *all_data.mat*


The variables will be loaded by loading the *all_data.mat* file.

## Variable names

The variable (output names) are self explanatory and they can be loaded by:

E_mode_1_eV
V_mode_1_eV
E_mode_1_eV
E_mode_2_eV
V_mode_2_eV
E_dis
Kinetic_Energy_2_eV
E_mode_2_Eq_9
E_2_transfer_eV
Fts_der
d_min_eff_real
H_A_1
H_A_2
Kinetic_Energy_2_eV
Height
Height_raw
Height_recovered
Height_rec_diff
    



## NOTE on statistics 


