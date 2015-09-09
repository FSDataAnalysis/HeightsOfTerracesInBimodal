%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% First to gray

f_subpixels_p2=['figure_subpixels_GRAY_',file_name];

map_shades_gray= gray(Shades_Of_Gray);

my_image_Shades_of_Gray_sub = rgb2ind(my_image_subpixel_RGB_p2, map_shades_gray, dither_RGB2Ind_conversion);

figure (1)
set(1,'visible',display_images);
image(my_image_Shades_of_Gray_sub);
colormap(map_shades_gray), colorbar

cd(Current_Saving_Folder);
if save_gray_sub==1, saveas (1, f_subpixels_p2,'fig'), end



if Copper_Smoothen_Pixels==1

    f_Copper_p2_sub=['figure_Copper_subpixels_',file_name];
    map_shades_gray= copper(Shades_Of_Gray);
    
    figure (1)
    set(1,'visible',display_images);
    image(my_image_Shades_of_Gray_sub);
    colormap(map_shades_gray), colorbar

    if save_copper_sub==1, saveas (1, f_Copper_p2_sub,'fig'), end
     
end



