
cd(Current_Saving_Folder);

if ~exist('myphase_1_rad')

    load P_1_raw.mat;
    myphase_1_rad=pi/180*Mydata;
end

if ~exist('myphase_2_rad')

    load P_1_raw.mat;
    myphase_1_rad=pi/180*Mydata;
end


if ~exist('Amplitude_1_nm') 
    
    load A_1_raw.mat;
    Amplitude_1_nm=Mydata;
end


if ~exist('Amplitude_2_nm')

    load A_2_raw.mat;
    Amplitude_2_nm=Mydata;
end

%%%% Amplitude_1 RawData_A1
%%%% Phase_1     RawData_P1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Energy 1
aaa_eff=[];
aaa_eff=-(3*k_2*A02/Q_2.*(cos(myphase_2_rad))./Amplitude_2_nm);

bbb_eff=[];
bbb_eff=-3*k_1*A01/Q_1.*(Amplitude_1_nm.^2).*(cos(myphase_1_rad));


%%%% REMOVE OUTLIERS   
mydata_in=aaa_eff;
cd(ParentDir);
ChauveneteSingleVector;
cd(Current_Saving_Folder);
aaa_eff=mydata_out;

mydata_in=bbb_eff;
cd(ParentDir);
ChauveneteSingleVector;
cd(Current_Saving_Folder);
bbb_eff=mydata_out;


   
ccc_eff_raw=(aaa_eff./bbb_eff);

ccc_eff=ccc_eff_raw.^(2/3);

ccc_eff_real=real(ccc_eff);


d_min_eff=-2./(1./(Amplitude_1_nm)-(Amplitude_1_nm).*ccc_eff_real.*(lamda_eff^2));


d_min_eff_real=real(d_min_eff);

aaa=aaa_eff/Tip_Radius;


H_A_2=aaa.*((d_min_eff_real*lamda_eff).^3);

bbb=bbb_eff/Tip_Radius;


H_A_1=bbb.*((d_min_eff_real./Amplitude_1_nm+1).^2-1).^(3/2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO IMAGES


%%%% D MIN
Mydata=d_min_eff_real;
file_name='D_min';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;

cd(ParentDir);
%%% First calculate with contrast of image as given
Process_files_images;

%%%% H2
Mydata=H_A_2;
file_name='H_A2';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;

cd(ParentDir);
%%% First calculate with contrast of image as given
Process_files_images;


%%%% H1
Mydata=H_A_1;
file_name='H_A1';
Number_files=Number_files+1;
File_name_list{Number_files}=file_name;

cd(ParentDir);
%%% First calculate with contrast of image as given
Process_files_images;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SAVE DATA
% cd(Current_Saving_Folder);

Data_dmin_H = sprintf( 'Mydata_dmin_H');
save(Data_dmin_H, 'd_min_eff', 'd_min_eff_real', 'H_A_1', 'H_A_2');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% flag_aaa_eff=0;
% 
% max_i=length(aaa_eff(1,:));
% max_j=length(aaa_eff(:,1));
% limiter_noise=4;
% 
% for i=1:length(aaa_eff(1,:))
%     
%     for j=1:length(aaa_eff(:,1))
%         
%         if bbb_eff(i,j)<0
%      
%             
%             if i>limiter_noise && j>limiter_noise && i<( max_i-limiter_noise)&& j<( max_j-limiter_noise)   
%                        
%                 flag_aaa_eff=flag_aaa_eff+1;
%                 aaa_eff(i,j)=mean(mean(aaa_eff(i-limiter_noise:i-1, j-limiter_noise:j-1)));
%                 
%             elseif i>limiter_noise && i<( max_i-limiter_noise)&& j<( max_j-limiter_noise)   
%                        
%                  flag_aaa_eff=flag_aaa_eff+1;
%                  aaa_eff(i,j)=mean(mean(aaa_eff(i-limiter_noise:i-1, j+1: j+limiter_noise+1 )));
%                  
%             elseif i>limiter_noise && i<( max_i-limiter_noise)&& j>limiter_noise 
%                        
%                 flag_aaa_eff=flag_aaa_eff+1;
%                 aaa_eff(i,j)=mean(mean(aaa_eff(i-limiter_noise:i-1, j-limiter_noise-1: j-1)));
%                 
%             elseif j>limiter_noise && j<( max_j-limiter_noise)&& i<( max_i-limiter_noise)   
%                         
%                  flag_aaa_eff=flag_aaa_eff+1;
%                  aaa_eff(i,j)=mean(mean(aaa_eff(i+1: i+limiter_noise+1,  j-limiter_noise:j-1 )));
%                  
%             elseif j>limiter_noise && j<( max_j-limiter_noise)&& i>limiter_noise 
%                        
%                 flag_aaa_eff=flag_aaa_eff+1;
%                 aaa_eff(i,j)=mean(mean(aaa_eff( i-limiter_noise-1: i-1, j-limiter_noise:j-1)));
% 
%             else
%                 flag_aaa_eff=flag_aaa_eff+1;
%                 aaa_eff(i,j)=mean(mean(aaa_eff(:)));
%             end
%         end
%     end
% end
% % 
% % 
% % flag_bbb_eff=0;

% % for i=1:length(bbb_eff(1,:))
% %     
% %     for j=1:length(bbb_eff(1,:))
% %         
% %         if bbb_eff(i,j)<0
% %             flag_bbb_eff=flag_bbb_eff+1;
% %             bbb_eff(i,j)=mean(mean(bbb_eff));
% %         end
% %     end
% % end