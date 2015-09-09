%% This file processes images for Energy transfer 1 or 2

cd(Current_Saving_Folder);

load A_2_raw.mat;
Amplitude_2_nm=Mydata;

load P_2_raw.mat;
myphase_2=Mydata;
myphase_2_rad=pi/180*myphase_2;
%%%% Amplitude_1 RawData_A1
%%%% Phase_1     RawData_P1

E_mode_2=[];
E_mode_2_eV=n_E*pi*k_2*A02/Q_2*Amplitude_2_nm.*(sin(myphase_2_rad)-Amplitude_2_nm/A02)*eV;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO IMAGES

Mydata=E_mode_2_eV;
file_name='E2';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;

cd(ParentDir);
%%% First calculate with contrast of image as given
Process_files_images;
%%% Now calculate with Noise UNDONE FOR ENERGIES!!! ALSO FOR VIRIALS!
% Process_files_images;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Virial 1
V_mode_2=[];
V_mode_2_eV=-1/2*k_2*A02/Q_2*Amplitude_2_nm.*cos(myphase_2_rad)*eV;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO IMAGES

Mydata=V_mode_2_eV;
file_name='V2';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;

cd(ParentDir);
Process_files_images;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Kinetic Energy and Energy Transfer, etc. 

Kinetic_Energy_2_eV=[];
E_2_transfer_eV=[];

%%%% Eqs. 10 and 11 here
%%%% http://scitation.aip.org/content/aip/journal/apl/104/14/10.1063/1.4870998
Kinetic_Energy_2_eV=1/2*k_2*(Amplitude_2_nm.*Amplitude_2_nm)*eV;  
E_2_transfer_eV= Q_2/2/pi/n_E*E_mode_2_eV;

%%% Eq. 9, i.e. It has to be positive!!

E_mode_2_Eq_9=[];

E_mode_2_Eq_9=Kinetic_Energy_2_eV+E_2_transfer_eV;

if min(min(E_mode_2_Eq_9)) < 0
    display('There was some inconsistency in Eq. 9'); 
    display('http://scitation.aip.org/content/aip/journal/apl/104/14/10.1063/1.4870998');
    display('Santos, S. Applied Physics Letters 104, 143109-143113 (2014).');
    Inconsistancy_in_Eq9=1;
else
    display('There was no inconsistency in Eq. 9'); 
    Inconsistancy_in_Eq9=0;
end
    
Eq_9='MydataIn_eq9_to_eq11';
save(Eq_9, 'Inconsistancy_in_Eq9', 'E_mode_2_Eq_9','Kinetic_Energy_2_eV', 'E_2_transfer_eV','E_mode_2_eV');
    
    
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SAVE DATA

% cd(Current_Saving_Folder);
Data_E_V_2 = sprintf( 'Mydata_E_V_2_eV');
save(Data_E_V_2, 'E_mode_2_eV', 'V_mode_2_eV');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
