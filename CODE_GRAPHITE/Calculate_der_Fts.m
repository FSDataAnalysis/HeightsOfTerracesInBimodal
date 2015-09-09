%% This file processes images for Energy transfer 1 or 2

cd(Current_Saving_Folder);

load A_2_raw.mat;
Amplitude_2_nm=Mydata;

load P_2_raw.mat;
myphase_2=Mydata;
myphase_2_rad=pi/180*myphase_2;
%%%% Amplitude_1 RawData_A1
%%%% Phase_1     RawData_P1

Fts_der=[];
Fts_der=-(F0_2./Amplitude_2_nm).*(cos(myphase_2_rad));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO IMAGES


%%%% Assign name to file

Mydata=Fts_der;
file_name='Fts_der';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;


cd(ParentDir);
%%% First calculate with contrast of image as given
Process_files_images;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SAVE DATA

% cd(Current_Saving_Folder);
Data_Fts_der = sprintf( 'Mydata_Fts_der');
%%% Fts_der has the data matrix for Fts, der_Fts_selected range is selected
%%% and mydata_Phi2_range is the range of the image
save(Data_Fts_der, 'Fts_der', 'mydata_Phi2_range');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
