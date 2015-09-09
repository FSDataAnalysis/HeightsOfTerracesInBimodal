

%%% First convert to Gray 
f_GREY_p2=['figure_GREY_',file_name];   

if Get_range_contrast==2
    Shades_Of_Gray=max_shades;
end

map_shades_gray= gray(Shades_Of_Gray);

my_image_Shades_of_Gray = rgb2ind(my_image_p2, map_shades_gray, dither_RGB2Ind_conversion);

figure (1)
set(1,'visible',display_images);
image(rot90(my_image_Shades_of_Gray, rotate_image_deg));
colormap(map_shades_gray), colorbar

cd(Current_Saving_Folder);
if save_gray==1, saveas (1, f_GREY_p2,'fig'), end
  

if Copper_Pixels==1
  
    f_Copper_p2=['figure_Copper_',file_name];
    map_shades_gray= copper(Shades_Of_Gray);
    figure (1)
    set(1,'visible',display_images);
    image(rot90(my_image_Shades_of_Gray, rotate_image_deg));
    colormap(map_shades_gray), colorbar
    if save_copper==1, saveas (1, f_Copper_p2,'fig'), end
end

