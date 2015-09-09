clear all; clc; close all 
tic

originaldir=pwd;
%format shortEng

asylum_A1_units=1;  %% graphite zero and calcite 1
asylum_A2_units=0;
calculate_dmin_on=1;
lamda_eff=2.2;
rotate_image_deg=0;   %% 1 for 90 0 for 0 2 for 180 rotates images

calculate_height_correction=1;

%%% the parameters below control chauvenete 
general_outliers=1;
moving_outliers_detector=0;
grouped_data_Fts_MODEL_2=1024*8;   %%% grouping 
iterate_more_than_once_outliers=0;
chauven=1;
exclude_number_distribution=0.99995;
exclude_number_distribution_local=0.9995;
exclude_number_distribution_single=0.9998;

folder_processed='ProcessedData';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARAMETERS of cantilever 
eV=6.24e18;
n_E=6; %% This is the number, approximately of cycles of mode 2 by mode 1, used in Calculate E2
Tip_Radius=10e-9;

Sensitivity_mode2=3.473;
Number_of_pixels_AFM_scan=512;
Save_images_pixels=0;

AmpVol_1=53e-9;   %%% careful since in some plots the amplitude is divided by 
AmpVol_2=AmpVol_1/Sensitivity_mode2;
%%% A01 and A02 need to be in V
A01_V=0.135;  %%0.70 most
A02_V=0.048; 

A01=0.135*AmpVol_1;  %%0.70 most
A02=0.016*AmpVol_2; 

k_1=1.6;
Q_1=91.5;
F0_1=k_1*A01/Q_1;

k_2=55.7;
Q_2=297;
F0_2=k_2*A02/Q_2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RANGE of contrast here
Get_range_contrast=1;

%%%%%%% Get_range_contrast=1 %%%%%%%%%%%%%%%%%%%%%%%%
    Selected_fraction_range=0.5;   %%%% DEFAULT 0.5 
    %%%FOR THE RAW RANGE! for get_range_contrast_1
    %% above and below mean, range of contrast relative to total. Shown is times two
    %%%, i.e. Selected_fraction_range*2= shown range. If 0.5 it shows it all 
    
    Position_selection=2;   %%% if 2 it is unselected, and the data is centered at mean 
    %If can go from 0 to 1.   %%% Then with Selected_fraction_range!=0.5
                              %%% the data is positioned in the mean of data. 
                              
                              %%% example with Position_selection=0 and 
                              %%%              Selected_fraction_range=0.2
                              %%% only 20% of the begining of the range
                              %%% will be shown. with 1, 20 of the end. 
    Shades_Of_Gray=256;       % default 256.
    


                              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Smoothen pixels times 8 pixels
RGB_Scale_Images_smoothen=0;  % IMAGE_Resolution_TIMES=16; XXX=0.95;   

Gray_Pixels=1; 
Gray_Smoothen_Pixels=0;       IMAGE_Resolution_TIMES=16; XXX=0.95; 
var_color=copper;  %% choose jet, coo, hot or whatever scale!
Copper_Pixels=0; 
Copper_Smoothen_Pixels=0;       
% Grey_Pixels=1;
% Grey_SmoothenImagePixels=1;     %%% IMAGE_Resolution_TIMES=16; XXX=0.95;   %% this is grey scale
                                    %% this is copper or ay var_color
% If smoothenImage you control the augmentation of subpixels with
% AlSO: The number XXX=0.975 for 32, 0.95 for 16, 0.9 for 8, etc. 
%% Next Save indivdual data from each file: THIS IS COMPULSORY AT THIS
%% Version
save_RGB=1;
save_RGB_sub=1;
save_gray=1;
save_gray_sub=1;
save_copper=1;
save_copper_sub=1;
               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% To calculate
%% Calculate analytical stuff = 1 otherwise 0
E_Transfer_Virial_1_do=1;
E_Transfer_Virial_2_do=1;
E_AverageForce_do=1;
Fts_derivative_do=1;
Hamaker_do=1;
d_min=1;
Kinetic_AND_Transfer_mode2_do=1; %% Eqs 9-11 here http://scitation.aip.org/content/aip/journal/apl/104/14/10.1063/1.4870998
Edis_do=1; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% Other details
File_name_list={};  %% will have ranges in Calculate_files
Number_of_pixels_total=255;  %%%  255, selected at GRAY SCALE, it will go to 256 transformed! 
display_images='on';    %% on or off
dither_RGB2Ind_conversion='nodither';   % you can select dither or nodither for RGB2ind
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Choose Folder with Images 
fPath = uigetdir('.', 'Select directory containing the files');
if fPath==0, error('no folder selected'), end
fNames = dir(fullfile(fPath,'*.txt') );
fNames = strcat(fPath, filesep, {fNames.name});

c_fig=1;
counter_files=1;
ParentDir=pwd;
N_of_files=length(fNames);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Save files in a convenient format 
save_files;



%%% call main file to process data
cd(ParentDir);
Process_files_Physical_1;

All_vectors=[E_mode_1_eV, V_mode_1_eV, E_mode_1_eV, ...
    V_mode_2_eV, E_dis, Kinetic_Energy_2_eV, E_mode_2_Eq_9, E_2_transfer_eV, Fts_der, ...
    d_min_eff_real, H_A_1, H_A_2, Kinetic_Energy_2_eV, Height, Height_raw, Height_recovered, Height_rec_diff];

save all_data
% 
% save ('All_vectors_VECT', 'All_vectors')