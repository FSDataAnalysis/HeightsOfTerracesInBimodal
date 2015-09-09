
%%% called from Process_files_images! %% it enters here if
%%% Selected_fraction_range!=0.5

foo_vectorX=fraction(:);
mean_fraction_is=mean(foo_vectorX);


if Position_selection== 2  %%%% Center at mean of data 


    new_subtract=mean_fraction_is-Selected_fraction_range;

    old_fraction_Phi2=fraction;% save  old

    Full_selected_range=2*Selected_fraction_range;
    fraction=(fraction-new_subtract); 

    dumb_find_minus=find(fraction<=0);
    dumb_find_plus=find(fraction>=Full_selected_range);

    fraction(dumb_find_minus)=0;
    fraction(dumb_find_plus)=0;


%     fraction=fraction/Full_selected_range;
%%/Full_selected_range;

    fraction(dumb_find_plus)=1;



elseif Position_selection==0   %% center at begining of data, i.e. lower values 

    mean_fraction_is=Selected_fraction_range;
    new_subtract=0;

    old_fraction_Phi2=fraction;% save  old

    Full_selected_range=2*Selected_fraction_range;

    dumb_find_plus=find(fraction>=Full_selected_range);

    fraction(dumb_find_plus)=0;

%     fraction=fraction/Full_selected_range;

    fraction(dumb_find_plus)=1;


elseif Position_selection==1   %% center at end of data, i.e. higher values 

    %         
    mean_fraction_is=1-Selected_fraction_range;
    new_subtract=(1-(2*Selected_fraction_range));

    old_fraction_Phi2=fraction;% save  old

    Full_selected_range=2*Selected_fraction_range;
    fraction=(fraction-new_subtract); 

    dumb_find_minus=find(fraction<=0);
    dumb_find_plus=find(fraction>=Full_selected_range);

    fraction(dumb_find_minus)=0;
    fraction(dumb_find_plus)=0;


%     fraction=fraction/Full_selected_range;

    fraction(dumb_find_plus)=1;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else   %% center at other than 0, 1 or the center of data 


    new_subtract=Position_selection-Selected_fraction_range;
    new_subtract_foo=Position_selection+Selected_fraction_range;

    if (Position_selection>0&&Position_selection<1)&&(new_subtract>0)&&(new_subtract<1)
         if Number_files==1   
            display('Not all data plotted: via Selected_fraction_range and/or Position_selection');
         end
    else
        error('Badly selected range Selected_fraction_range and/or Position_selection');
    end


    old_fraction_Phi2=fraction;% save  old

    Full_selected_range=2*Selected_fraction_range;
    fraction=(fraction-new_subtract); 

    dumb_find_minus=find(fraction<=0);
    dumb_find_plus=find(fraction>=Full_selected_range);

    fraction(dumb_find_minus)=0;
    fraction(dumb_find_plus)=0;


    fraction=fraction/Full_selected_range;

    fraction(dumb_find_plus)=1;

end
   


% mean_fraction_is_number=mean_fraction_is*mydata_Phi2_range+phase_min;

% cd(Current_Saving_Folder); 
% save(foo_name_range, 'Selected_fraction_range','mydata_Phi2_range', 'phase_min', 'phase_max', 'mean_fraction_is', '-append');  % 
% cd(ParentDir); 
%     
        