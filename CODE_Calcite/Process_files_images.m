%% WE ARE IN PARENT DIR

phase_min=min(min(Mydata));
phase_max=max(max(Mydata));

%%%% THIS IS THE RANGE IN THE IMAGE!!!!! In absolute numbers
mydata_Phi2_range=abs(phase_max-phase_min);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RANGE OF CONTRAST!!!
fraction=(Mydata-phase_min)/mydata_Phi2_range;

%%%% If will save again in Shorten_ranges if the range is shortened
%%% This will generate a scale of the image chosen by the user, i.e.
%%% cutting part of the image. 
if (Selected_fraction_range~=0.5)
    Shorten_range;  %%% 
end
    

%%% RGB colour palet R=0-255, then G and B from 1 to 255
%%% fraction_Phi2 is the range of values 0 to 1 that are processed here
% if looping==2  %%% otherwise leave Get_range_selection as is
%     Get_range_contrast=Loop_through_contrast;
% end

if Get_range_contrast==1
    
    Data_decimal_pixels=round(fraction*(Number_of_pixels_total));
    %% this implies not 255 shades but only those above noise level, i.e. foo_RATIO                                                                
    %% floor is conservative for floor(foo_RATIO), round is not                                                                       
else
    
    error ('Error in selection of contrast in Process_files_images');
end



c_i=0;
c_j=0;



pixel_num_R_p2=[];
% pixel_num_G_p2=[];
% pixel_num_B_p2=[];

for i=1:Number_of_pixels_AFM_scan
    for j=1:Number_of_pixels_AFM_scan

        dumb_p2=Data_decimal_pixels(j,i);

        pixel_num_R_p2(j,i) = dumb_p2;
        % Rest G, B will be the same!
%             pixel_num_G_p2(i,j) =dumb_p2; 
%             pixel_num_B_p2(i, j) = dumb_p2;

    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% matrix or m-by-n-by-3 array %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a 3d-matrix like this: - Create a matrix ofdimensions, i.e. rows
% and columns, m and n

[m,n]=size(pixel_num_R_p2);  

%% Now m and n are the dimensions of the "image inherited from the pixel
%% matrices RGB 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize the image: Generate an m by n matrix by an array of 3 with all zeros!

my_image_p2(m,n,3)=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fill the data for each pixel!
% I DIVIDE BY 255 because MATLAB RGB takes ratios from 0 to 1, i.e. 255->1
% and 

dumb_pixel_matlab=pixel_num_R_p2/255;

my_image_p2(:,:,1)=dumb_pixel_matlab; 
my_image_p2(:,:,2)=dumb_pixel_matlab;
my_image_p2(:,:,3)=dumb_pixel_matlab;

%%% Generate image in RGB

cd(ParentDir);
RGB_Images;

if RGB_Scale_Images_smoothen==1
      cd(ParentDir);
      SmoothenImagePixels_RGB;
end

if Gray_Pixels==1
    cd(ParentDir);
    Gray_Images;
end

if Gray_Smoothen_Pixels==1
    cd(ParentDir);
    SmoothenImagePixels_Gray;  
end



%%%%% SAVE ALL?
% cd(Current_Saving_Folder);
if Save_images_pixels==1

    Images = sprintf( 'Images%s_pixels_', file_name);
    save(Images, 'my_image_p2', 'Shades_Of_Gray', 'my_image_subpixel_RGB_p2', 'my_image_Shades_of_Gray','my_image_Shades_of_Gray_sub');
    
end


%% YOU CAN SAVE THE ONES BELOW TO PASS TO ANOTHER PROGRAM %%

%  fileOut_R='pixels_R_p2.txt'
% fileOut_G='pixels_G_p2.txt'
% fileOut_B='pixels_B_p2.txt'
% 
% save(fileOut_R,  'pixel_num_R_p2', '-ASCII')
% save(fileOut_G,  'pixel_num_G_p2', '-ASCII')
% save(fileOut_B,  'pixel_num_B_p2', '-ASCII')
