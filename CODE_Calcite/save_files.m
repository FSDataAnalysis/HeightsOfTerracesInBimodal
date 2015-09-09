

for i=1:N_of_files
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Selection of txt file names, original and selected folder, etc. 
    Mydata=load(fNames{i});  %% Gets the name of the txt files in folder recursively 
    %%% Separate file names from paths 
    [pathstr, name, ext]=fileparts(fNames{i});
    file_name=name;
    
    FoldersTree=strread(pathstr,'%s','delimiter','\\');
    length_tree=length(FoldersTree);
    
    TextFolder=char(FoldersTree(length_tree));
    
    
    %%% Go to the folder where the txt files are
    %%% Stuff will be saved there
    cd(pathstr)
    
    if ~exist([ file_name,'.txt'])
        error('myApp:argChk','Current txt file doesnt not exist');
    end
    
    pixels_image=length(Mydata);
    
       
    eval([ 'Mydata', file_name, '=  Mydata;']);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% SAVE RAW

    
    %%% Save variables of raw amplitudes and phases
    
    if strcmp(file_name, 'P1')
        
        foo = sprintf( 'P_1_raw');
        Phase_1=[];     
        Phase_1=Mydata;
        save(foo, 'Phase_1', 'Mydata');
        
      
    elseif  strcmp(file_name, 'P2')
        
        foo = sprintf( 'P_2_raw');
        Phase_2=[];
        
%         if chauven==1
%             mydata_in=Mydata;
%             cd(ParentDir);
%             Chauvenete;
%             cd(pathstr);
%             Mydata=mydata_out;
%         end
        
        Phase_2=Mydata;
        save(foo, 'Phase_2', 'Mydata');
       
        
    elseif  strcmp(file_name, 'A1')
        
        if asylum_A1_units==1 
            Mydata=Mydata*Sensitivity_mode2;
        end
        
%        if chauven==1
%             mydata_in=Mydata;
%             cd(ParentDir);
%             Chauvenete;
%             cd(pathstr);
%             Mydata=mydata_out;
%         end
        
        foo = sprintf( 'A_1_raw');
        Amplitude_1=[];
        Amplitude_1=Mydata;
        save(foo, 'Amplitude_1', 'Mydata');
        
     elseif  strcmp(file_name, 'A2')
        
        if asylum_A2_units==1 
            Mydata=Mydata/Sensitivity_mode2;
        end
        
        foo = sprintf( 'A_2_raw');
         
        Amplitude_2=[];
        
%         if chauven==1
%             mydata_in=Mydata;
%             cd(ParentDir);
%             Chauvenete;
%             cd(pathstr);
%             Mydata=mydata_out;
%         end
        Amplitude_2=Mydata;
        save(foo, 'Amplitude_2', 'Mydata');
     
     elseif  strcmp(file_name, 'H')

        
        foo = sprintf( 'H_raw');
        Height=[];
        Height=Mydata;
        save(foo, 'Height', 'Mydata');
 
    else
    end
        
  
    counter_files=counter_files+1; 
    
end



if chauven==1
    
    Mydata_matrix=[];
    Mydata_matrix(1,:,:)=Phase_1;
    Mydata_matrix(2,:,:)=Amplitude_1;
    Mydata_matrix(3,:,:)=Phase_2;
    Mydata_matrix(4,:,:)=Amplitude_2;
    Mydata_matrix(5,:,:)=Height;
      
      
    cd(ParentDir);
    Chauvenete;

    Phase_1=Mydata_matrix(1,:,:);
    Amplitude_1=Mydata_matrix(2,:,:);
    Phase_2=Mydata_matrix(3,:,:);
    Amplitude_2=Mydata_matrix(4,:,:);
    Height=Mydata_matrix(5,:,:);
    

    foo = sprintf( 'P_1_raw');
    Mydata=Phase_1;
    save(foo, 'Phase_1', 'Mydata');  
    foo = sprintf( 'A_1_raw');
    Mydata=Amplitude_1;
    save(foo, 'Amplitude_1', 'Mydata');  
    foo = sprintf( 'P_2_raw');
    Mydata=Phase_2;
    save(foo, 'Phase_2', 'Mydata');  
    foo = sprintf( 'A_2_raw');
    Mydata=Amplitude_2;
    save(foo, 'Amplitude_2', 'Mydata');  
    foo = sprintf( 'H_raw');
    Mydata=Height;
    save(foo, 'Height', 'Mydata');  
    
    cd(pathstr);  
end

if Get_range_contrast==1
    
    if exist(folder_processed, 'dir')
        rmdir(folder_processed, 's');   %%% Noise HAS NOT been processed or taken into account!
    end
    mkdir(folder_processed);   %%% Noise HAS NOT been processed or taken into account!

        
   
    Current_Saving_Folder=char(sprintf('%s',TextFolder, '\ProcessedData'));  % Get_range_contrast=1 gets here
        
    cd(fPath)
    %%% Currentling in text files doler (original)
    %%%% Add all MAT files and text files to each folder:
    
    
    f2Names_txt = dir(fullfile(fPath,'*.txt') );
    f2Names_txt = strcat(fPath, filesep, {f2Names_txt.name});
    %%%% File names of txt files in f2Names
    f2Names_mat = dir(fullfile(fPath,'*.mat') );
    f2Names_mat = strcat(fPath, filesep, {f2Names_mat.name});
    
    N_of_files_mat=length(f2Names_mat);
    
    for ccc=1:N_of_files
        
        %%% First move txt files to folders 
        [pathstr2, name2, ext2]=fileparts(f2Names_txt{ccc});
        file_name2=name2;

        file_name2=char(sprintf( '%s', file_name2, '.txt'));
        [status1, message1] = copyfile(file_name2, folder_processed);  
        
    end
    
    for ccc=1:N_of_files_mat
     
         %%% Then move mat files to folders 
        [pathstr3, name3, ext3]=fileparts(f2Names_mat{ccc});
        file_name3=name3;

        file_name3=char(sprintf( '%s', file_name3, '.mat'));
        [status2, message2] = copyfile(file_name3, folder_processed);
        delete(file_name3);
        
    end
    
else
    
    error('myApp:argChk', 'Wrong  input arguments for Get_range_contrast in file Bimodal Theory');

end