
cd(Current_Saving_Folder);

if ~exist('d_min_eff_real')
   print('error to calculate height. No dmin vector');
else

    load H_raw.mat;
   
    
    Height_recovered_raw=Height+d_min_eff_real;
    
    min_height=min(Height_recovered_raw(:));
    
    Height_recovered=Height_recovered_raw-min_height;
    
    %%%% Assign name to file
    Mydata=Height_recovered;

    file_name='Height_recovered';
    Number_files=Number_files+1;
    File_name_list{Number_files}=file_name;

    cd(ParentDir);
    Process_files_images;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% SAVE DATA
    % cd(Current_Saving_Folder);

    Data_Height_rec = sprintf( 'Mydata_height_rec');
    save(Data_Height_rec, 'Height_recovered');


end