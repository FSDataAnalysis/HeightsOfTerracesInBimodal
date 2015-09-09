%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%convert to grey scale from RGB
f_RGB_p2=['figure_RGB_',file_name];    
% figure (c_fig+1)
% plot(my_image_TOGRAYSCALE_p2)
% imshow(my_image_TOGRAYSCALE_p2)
%%% Also possible imshow(Image,[low high]) displays the grayscale image 
cd(Current_Saving_Folder);

figure (1)

set(1,'visible',display_images);


image(my_image_p2);

if save_RGB==1, saveas (1, f_RGB_p2,'fig'), end
% imwrite(my_image_p2, f_RGB_p2); 




