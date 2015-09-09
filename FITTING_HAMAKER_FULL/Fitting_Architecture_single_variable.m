%%%% Architecture for single  variable FIT  (linear)
  %%%% REGRESSION 
    
if length(deformation_raw_dumb)> minimu_number_for_fit
    
    flag_zero=0;
    
    x=linear_deformation_raw_nm;
    y=Energy_repulsive_zepto_Joules;

    R_squared_dumb=corr(x,y)^2;
    Inference_Regression;

    max_slope=beta1_plus;
    min_slope=beta1_minus;

    error_slope_normalized=max_slope-beta1;   

    matrix_stats_normalized_dumb=[];

    matrix_stats_normalized_dumb=[beta0, beta1, SE_beta0, SE_beta1, p_beta0, ...
                p_beta1, t_beta0, t_beta1, beta1_minus, beta1_plus, R_squared_dumb];




    if plot_inference_normalized_single==1

        if how_many_plots==0

            figure(1)
            hold on

            plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
            plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

            hold on
            plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
            plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 
        else

            if counter_plots<how_many_plots
                
      

                figure(1)
                hold on

                plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
                plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   

                hold on
                plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
                plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 

                counter_plots=counter_plots+1;

            end
        end
    end

else
    
    flag_zero=1;
end
