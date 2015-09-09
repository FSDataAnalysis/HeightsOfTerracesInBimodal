

M_size=7;


[beta0, beta1, SE_beta0, SE_beta1, p_beta0, ...
            p_beta1, t_beta0, t_beta1, beta1_minus, beta1_plus]=GetCoefficients(x,y);

xx_reg=min(x):0.01:max(x);
yy_reg=beta0+beta1*xx_reg;

  


%%%% Statistics on expected response intervals and regresion line intervals %%%%%%%%%%%%%%

[xx, yy, yy_plus_ser, yy_minus_ser, yy_plus_sei, yy_minus_sei]= ...
    IntervalStats(x,y);

% if plot_inference_normalized_single==1
%     
%     if how_many_plots==0
%         
%         figure(1)
%         hold on
% 
%         plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
%         plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   
% 
%         hold on
%     	plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
%         plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 
%     else
%         
%         if counter_plots<how_many_plots
%             
%             figure(1)
%             hold on
% 
%             plot(x,y, 'ok', 'Markersize',M_size, 'displayname','Model');     
%             plot(xx_reg,yy_reg, '-k', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','Model');   
% 
%             hold on
%             plot(xx,yy_plus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression');  
%             plot(xx,yy_minus_ser, '-b', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI regression'); 
%         
%             counter_plots=counter_plots+1;
%            
%         end
%     end
% end

% plot(xx,yy_plus_sei, '-r', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI error');  
% plot(xx,yy_minus_sei, '-r', 'linewidth', M_size-5, 'Markersize',M_size, 'displayname','CI error');

