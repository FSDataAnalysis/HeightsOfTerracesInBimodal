%%%% FIT HAMAKER from force S Santos 2015 April 20

%%% R in nm, force in nN, Hamaker in Hepto Joules (1e-18), distance in nm



%%%%% INTERFACE
%%%%% INTERFACE
clear all; clc;
 
 
[FileName_Stats,PathName_Stats,FilterIndex_Stats] = uigetfile('*.mat','MultiSelect', 'off');
 
if strcmp(class(FileName_Stats), 'double')
        display('No file selected. Select Mat file');
        error('msgString');
end
 
%%% load MAT FILE with forces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
path_stats_file=strcat(PathName_Stats, FileName_Stats);
load (path_stats_file);
 
%%% Loads force, with d=at d=0, Amplitude (col 3 of unpacked_Force_CLEAN).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%% Main interface STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
prompt= {   'Tip Radius (in nm):', ...  
            'plot results (0/1):', ...
            'if plot rasults, how many? (10-0 for all):', ...
            'Use cut off for distance ?(0/1):', ...
            'Cut off distance: (in nm):', ...
            'Use cut off minmum force?(0/1):', ...
            'Cut off mininum force (percentage of FAD):', ...
            'Cut off force (percentage of FAD):' ...
            'Minimum number of points for fit:', ...
            'Correct value for R^2> RR (0/1)', ...
            'Cut off RR:'};
        
dlg_title='Metrics dFAD/Work of Adhesion';
% num_lines=1;
default={'10','1', '10', '1', '1.5', '0', '0.1','0.6', '20', '1', '0.7'};
answer=inputdlg(prompt,dlg_title,[1, length(dlg_title)+40], default); 
 
 
R=str2double(answer(1));
plot_inference_normalized_single=str2double(answer(2));
how_many_plots=str2double(answer(3));
use_cut_off_larger_distance=str2double(answer(4));  %%% how many nm larger?
cut_off_distance_nm=str2double(answer(5));  %%% this is the distance from Percentage_OF(FAD)
use_cut_off_larger_force=str2double(answer(6));
cut_off_force_min=str2double(answer(7));
cut_off_force=str2double(answer(8));  %% implies 0.5 or higher than force of adhesion
minimu_number_for_fit=str2double(answer(9));  %% minimum number of points left for fit
correct_by_R2=str2double(answer(10));  %% take only values with large RR
cut_off_RR=str2double(answer(11));  %% take only values with large RR

if plot_inference_normalized_single==1
    
    counter_plots=0;
end

%%%%%%%%%%%%%%%%%
names_forces=fieldnames(D);


%% looping thorugh forces

Hamaker_matrix=[];

HamakerRadius_matrix=[];
matrix_stats_normalized=[];



for iii=1:length(names_forces)
    
    dumb_current_force=sprintf('No_%i', iii);
    
    dumb_distance=D.(dumb_current_force);
    dumb_FORCE=FORCE.(dumb_current_force);

    FORCE_adhesion=min(dumb_FORCE);
    FORCE_adhesion_nN=FORCE_adhesion*1e9;

    %%%% get raws for defomrmation d<0

    minima_index_multiple=find(dumb_distance==0);
    minima_index=minima_index_multiple(1);

    Attractive_force_dumb=dumb_FORCE(1:minima_index);
    distance_deformation_raw_dumb=dumb_distance(1:minima_index);

    negative_elements=find(distance_deformation_raw_dumb<0);

    %%%% right distances
    Attractive_force_dumb(negative_elements)=[];
    distance_deformation_raw_dumb(negative_elements)=[];
    %%%%%%%

    Attractive_force_nN=Attractive_force_dumb*1e9;
    distance_raw_nm=distance_deformation_raw_dumb*1e9;


    %%%% CUTTING VECTOR from Force=0.5FAD (i.e. cut off force) to about 3 nm (i.e. cut off distance)

    %%% cut off force
    larger_forces_indices=find(abs(Attractive_force_nN)< cut_off_force*abs(FORCE_adhesion_nN));

    Attractive_force_nN_cut_off=Attractive_force_nN(larger_forces_indices);
    distance_raw_nm_cut_off=distance_raw_nm(larger_forces_indices);

    %%% cut off distance
    if use_cut_off_larger_distance==1
        smaller_distances_indices=find(distance_raw_nm_cut_off< cut_off_distance_nm);

        Attractive_force_nN_cut_off=Attractive_force_nN_cut_off(smaller_distances_indices);
        distance_raw_nm_cut_off=distance_raw_nm_cut_off(smaller_distances_indices);
    end

    if use_cut_off_larger_force==1
        smaller_distances_indices=find(abs(Attractive_force_nN_cut_off)> cut_off_force_min*abs(FORCE_adhesion_nN));

        Attractive_force_nN_cut_off=Attractive_force_nN_cut_off(smaller_distances_indices);
        distance_raw_nm_cut_off=distance_raw_nm_cut_off(smaller_distances_indices);
    end


    linear_distance_raw_nm=distance_raw_nm_cut_off.^(-2);

    %%%% REGRESSION 

    if length(linear_distance_raw_nm)> minimu_number_for_fit
        
        x=linear_distance_raw_nm;
        y=Attractive_force_nN_cut_off;

        R_squared_dumb=corr(x,y)^2;
        Inference_Regression;

        max_slope=beta1_plus;
        min_slope=beta1_minus;

        error_slope_normalized=max_slope-beta1;   


        matrix_stats_normalized_dumb=[beta0, beta1, SE_beta0, SE_beta1, p_beta0, ...
                    p_beta1, t_beta0, t_beta1, beta1_minus, beta1_plus, R_squared_dumb];



        correction_normalized_indentation=-beta0/beta1;
        if correction_normalized_indentation<0
            
            correction_normalized_indentation=-(-correction_normalized_indentation)^(-0.5);
        else
             correction_normalized_indentation=(correction_normalized_indentation)^(-0.5);
        end
        

        
        Hamaker_RADIUS_dumb=-6*beta1;                  %% in E and R 
        Hamaker_dumb=Hamaker_RADIUS_dumb/(R);        %% in GPA

        %%%% saved matrices
        Hamaker_matrix=[Hamaker_matrix;Hamaker_dumb];
        HamakerRadius_matrix=[HamakerRadius_matrix;Hamaker_RADIUS_dumb];
        matrix_stats_normalized=[matrix_stats_normalized; matrix_stats_normalized_dumb];
    
    
        if plot_inference_normalized_single==1

            if how_many_plots==0

                figure(1)
                hold on

                plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
                plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

                hold on
                plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
                plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 
                
                figure(2)
                hold on
% 
%                     plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
%                     plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

                hold on
                 plot(x,-(Hamaker_dumb*R/6)*x.^(-0.5), '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
                    plot(D.(dumb_current_force), FORCE.(dumb_current_force), '.r')
            else

                if counter_plots<how_many_plots

                    figure(1)
                    hold on

                    plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
                    plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

                    hold on
                    plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
                    plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 
                    
                    figure(2)
                    hold on
% 
%                     plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
%                     plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

                    hold on
                    d_m=1e-9*(x.^(-0.5));
                    R_m=R*1e-9;
                    H_J=Hamaker_dumb*1e-18;
                    y_m=-(H_J*R_m/6)./(d_m.^(2))+beta0*1e-9;
                    
                    plot(d_m,y_m, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','H fit');  
                    plot(D.(dumb_current_force), FORCE.(dumb_current_force), '.r')
                    counter_plots=counter_plots+1;

                end
            end
        end
    end

end

if plot_inference_normalized_single==1
    saveas(1,'E_M','fig')	
end


if correct_by_R2==1
    
    dum_RR=matrix_stats_normalized(:,11);
    
    found_goodRR_indices=find(dum_RR>cut_off_RR);
    
    matrix_stats_normalized_R_corrected=matrix_stats_normalized(found_goodRR_indices, :);
    
    Hamaker_matrix_R_corrected=Hamaker_matrix(found_goodRR_indices);
    HamakerRadius_matrix_R_corrected=HamakerRadius_matrix(found_goodRR_indices);
end


    
save HAMAKER_FIT

    


