%% This file processes images for Energy transfer, Virial and
%% Average force, i.e. -kz0

Number_files=1;
cd(Current_Saving_Folder);


counter_file_name_list=1;

if E_Transfer_Virial_1_do==1

    if ~exist('P1.txt')||~exist('A1.txt')
           display('myApp:argChk: Cannot calculate Energy transfer mode 1 on Process_files_Physical_1');
    else
       cd(ParentDir);
       Calculate_E_V_1;
    end   
      
end


if E_Transfer_Virial_2_do==1

    if ~exist('P2.txt')||~exist('A2.txt')
           display('myApp:argChk: Cannot calculate Energy transfer mode 2 on Process_files_Physical_1');
    else
       cd(ParentDir);
       Calculate_E_V_2;
    end
    
    
    
end


if E_AverageForce_do==1

    if ~exist('Def.txt')
           display('myApp:argChk: Cannot calculate average force on Process_files_Physical_1');
    else
       cd(ParentDir);
       Calculate_def;  %% Not done yet!
    end
    
    
end



if Fts_derivative_do==1
    
    if ~exist('P2.txt')||~exist('A2.txt')
           display('myApp:argChk: Cannot calculate Fts derivative 2 on Process_files_Physical_1');
    else
   
       cd(ParentDir);
       Calculate_der_Fts;
    end
    
    
end



if Kinetic_AND_Transfer_mode2_do==1  %this is only to print images! Data found in Calculate_E_V file 
    
    if ~exist('P2.txt')||~exist('A2.txt')
           display('myApp:argChk: Cannot calculate Kinetic energy, etc. on Process_files_Physical_1');
    else
       cd(ParentDir);
       %%% this is equations 9-11 in:
       %%% http://scitation.aip.org/content/aip/journal/apl/104/14/10.1063/1.4870998
       Calculate_Kinetic_Energy_Energy_Transfer;
    end
    
    
end



if Edis_do==1  %this is only to print images! Data found in Calculate_E_V file 
    
    if ~exist('P2.txt')||~exist('A2.txt')||~exist('P1.txt')||~exist('A1.txt')
           display('myApp:argChk: Cannot calculate Edis. on Process_files_Physical_1');
    else
       cd(ParentDir);
       %%% this is equations Edis
       Calculate_Edis;
    end
    
    
end

if calculate_dmin_on==1
    
     if ~exist('P2.txt')||~exist('A2.txt')||~exist('P1.txt')||~exist('A1.txt')
           display('myApp:argChk: Cannot calculate Edis. on Process_files_Physical_1');
     else
     cd(ParentDir);
     Calculate_d_min;
     end

end


if calculate_height_correction==1
    
     if ~exist('H.txt')
           display('myApp:argChk: Cannot calculate Edis. on Process_files_Physical_1');
     else
     cd(ParentDir);
     Calculate_height;
     end

end

%%%%% DO AMPLITUDES AND PHASES

if exist('P1.txt', 'file')

     %load P_1_raw.mat;   
     Mydata=Phase_1;
     file_name='Phase_1';
     cd(ParentDir);
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;
     
else
    display('myApp:argChk: Cannot find P1.txt Process_files_Physical_1');
end

if exist('P2.txt','file')
    
     %load P_1_raw.mat;   
     Mydata=Phase_2;
     file_name='Phase_2';
     cd(ParentDir);
%      cd(Current_Saving_Folder);
    %%% First calculate with contrast of image as given
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;
     
else
    display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
end


if exist('A1.txt', 'file')
    
     %load P_1_raw.mat;  

     Mydata=Amplitude_1;
     file_name='Amplitude_1';
     cd(ParentDir);
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;
     
else
    display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
end
    

if exist('A2.txt', 'file')
    
     %load P_1_raw.mat;   
     Mydata=Amplitude_2;
     file_name='Amplitude_2';
     cd(ParentDir);
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;

else
    display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
end

if exist('H.txt', 'file')
    
     %load P_1_raw.mat;  
        
     Mydata=Height;
     Height_min=min(Height(:));
     Height_again=Height-Height_min;
     Height=Height_again;
     Height_raw=Mydata;
     Mydata=Height;
     file_name='Height';
     cd(ParentDir);
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;
     
     


else
    display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
end



if calculate_height_correction==1
    
    %load P_1_raw.mat;   
    
     Height_rec_diff=Height-Height_recovered;
     Mydata=Height_rec_diff;
     
     
     file_name='Height_recovered_difference';
     cd(ParentDir);
     Process_files_images;
     Number_files=Number_files+1;
     File_name_list{Number_files}=file_name;
     
     
% %      Height_rec_diff_norm=Height_rec_diff./Height_recovered;
% %      Mydata=Height_rec_diff_norm;
% %      
% %      
% %      file_name='Height_recovered_difference_norm';
% %      cd(ParentDir);
% %      Process_files_images;
% %      Number_files=Number_files+1;
% %      File_name_list{Number_files}=file_name;
     

else
    display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
end


    
    
% % if calculate_dmin_on==1
% %     
% %      %load P_1_raw.mat;   
% %      Mydata=Amplitude_2;
% %      file_name='Amplitude_2';
% %      cd(ParentDir);
% %      Process_files_images;
% %      Number_files=Number_files+1;
% %      File_name_list{Number_files}=file_name;
% % 
% % else
% %     display('myApp:argChk: Cannot find P2.txt Process_files_Physical_1');
% % end


Labels_images=File_name_list;

save('Labels_images', 'Labels_images');  %%% The first is the name of the file_second is the list!

    
    
    
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
