


if RGB_Scale_Images_smoothen==1


    R_RGB_p2= my_image_p2(:,:,1); % RGB channel
    G_RGB_p2 = my_image_p2(:,:,2); % Green channel
    B_RGB_p2 = my_image_p2(:,:,3); % Blue channel


    %%% getting the number of pixels
    [X_R_p2_RGB,Y_R_p2_RGB] = meshgrid(1:size(R_RGB_p2,1), 1:size(R_RGB_p2,2));
    [X_G_p2_RGB,Y_G_p2_RGB] = meshgrid(1:size(G_RGB_p2,1), 1:size(G_RGB_p2,2));
    [X_B_p2_RGB,Y_B_p2_RGB] = meshgrid(1:size(B_RGB_p2,1), 1:size(B_RGB_p2,2));

    
    out_pixels_X_R_p2_RGB=length(X_R_p2_RGB)*IMAGE_Resolution_TIMES;
    %%%% IMPORTANT! The Interpolation variable needs to be exactly the
    %%%% number of pixels of X_R and X_Y some lines below. You can change
    %%%% the number XXX!
    Interpolation_p2_RGB=(length(X_R_p2_RGB)-XXX)/(out_pixels_X_R_p2_RGB);  



    [m_p2_RGB,n_p2_RGB] = meshgrid(1:size(my_image_p2,1), 1:size(my_image_p2,2));
    [X_R_p2_new_RGB,Y_R_p2_new_RGB] = meshgrid(1:Interpolation_p2_RGB:length(X_R_p2_RGB));


    R_subpixel_RGB_p2 = interp2(m_p2_RGB, n_p2_RGB, R_RGB_p2,X_R_p2_new_RGB, Y_R_p2_new_RGB); %,X_R_p2_new,Y_R_p2_new);
    G_subpixel_RGB_p2 = interp2(m_p2_RGB, n_p2_RGB, G_RGB_p2,X_R_p2_new_RGB, Y_R_p2_new_RGB);
    B_subpixel_RGB_p2 = interp2(m_p2_RGB, n_p2_RGB, B_RGB_p2,X_R_p2_new_RGB, Y_R_p2_new_RGB);


    my_image_subpixel_RGB_p2(m*IMAGE_Resolution_TIMES,n*IMAGE_Resolution_TIMES,3)=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Fill the data for each pixel!
    % I DIVIDE BY 255 because MATLAB RGB takes ratios from 0 to 1, i.e. 255->1
    % and 

    my_image_subpixel_RGB_p2(:,:,1)=R_subpixel_RGB_p2; 
    my_image_subpixel_RGB_p2(:,:,2)=G_subpixel_RGB_p2;
    my_image_subpixel_RGB_p2(:,:,3)=B_subpixel_RGB_p2;


    %%% Generate image 
    f_subpixels_p2=['figure_subpixels_RGB_',file_name];

    cd(Current_Saving_Folder);
%     
%     imwrite(my_image_subpixel_RGB_p2,  f_subpixels_p2);
    figure (1)
    set(1,'visible',display_images);
    image(my_image_subpixel_RGB_p2);
    if save_RGB_sub==1, saveas (1, f_subpixels_p2,'fig'), end
    
end

