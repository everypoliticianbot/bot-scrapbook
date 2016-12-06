// Simple bot-on-white scene
// Handy for a starting point for more complex scenes
// Bot is positioned dead centre of frame, toe-to-top visible
// Note: no interesting reflections on bot in an empty scene like this

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#local ogp_colours = array[14] {
  rgb <1.00, 1.00, 1.00>, // white (not used)
  rgb <0.04, 0.40, 0.40>, // teal
  rgb <0.99, 0.59, 0.18>, // orange
  rgb <0.15, 0.15, 0.15>, // black
  rgb <0.05, 0.43, 0.61>, // sea_blue
  rgb <0.33, 0.35, 0.35>, // dark_grey
  rgb <0.96, 0.14, 0.13>, // red
  rgb <1.00, 0.93, 0.21>, // yellow
  rgb <0.19, 0.68, 0.31>, // green
  rgb <0.81, 0.81, 0.82>, // light_grey
  rgb <0.48, 0.77, 0.64>, // mint_green
  rgb <0.58, 0.59, 0.60>, // mid_grey
  rgb <0.12, 0.69, 0.93>, // sky_blue
  rgb <0.54, 0.23, 0.55>  // purple
}

#local ogp_teal = 1;
#local ogp_orange = 2;
#local ogp_black = 3;
#local ogp_sea_blue = 4;
#local ogp_dark_grey = 5;
#local ogp_red = 6;
#local ogp_yellow = 7;
#local ogp_green = 8;
#local ogp_light_grey = 9;
#local ogp_mint_green = 10;
#local ogp_mid_grey = 11;
#local ogp_sky_blue = 12;
#local ogp_purple = 13;

#local ogp_map_tiles = 86;
#local ogp_map_width = 18;
#local ogp_map_height = 11;

#local ogp_map = array[ogp_map_tiles][3]
  {
    { 5, 0, ogp_teal },
    { 6, 0, ogp_orange },
    { 7, 0, ogp_black },
    {14, 0, ogp_black },
    { 2, 1, ogp_sea_blue },
    { 3, 1, ogp_black },
    { 6, 1, ogp_dark_grey },
    { 7, 1, ogp_red },
    {12, 1, ogp_dark_grey },
    {13, 1, ogp_yellow },
    {14, 1, ogp_sea_blue },
    {15, 1, ogp_orange },
    {16, 1, ogp_dark_grey },
    { 0, 2, ogp_black },
    { 1, 2, ogp_green },
    { 2, 2, ogp_light_grey },
    { 3, 2, ogp_dark_grey },
    { 4, 2, ogp_black },
    { 6, 2, ogp_mint_green },
    { 9, 2, ogp_black },
    {10, 2, ogp_sea_blue },
    {11, 2, ogp_black },
    {12, 2, ogp_mid_grey },
    {13, 2, ogp_red },
    {14, 2, ogp_black },
    {15, 2, ogp_sky_blue },
    {16, 2, ogp_light_grey },
    {17, 2, ogp_black },
    { 1, 3, ogp_dark_grey },
    { 2, 3, ogp_sky_blue },
    { 3, 3, ogp_mid_grey },
    { 4, 3, ogp_light_grey },
    { 5, 3, ogp_green },
    { 8, 3, ogp_dark_grey },
    { 9, 3, ogp_green },
    {10, 3, ogp_orange },
    {11, 3, ogp_teal },
    {12, 3, ogp_black },
    {13, 3, ogp_sky_blue },
    {14, 3, ogp_mint_green },
    {15, 3, ogp_light_grey },
    {16, 3, ogp_red },
    { 2, 4, ogp_red },
    { 3, 4, ogp_yellow },
    { 4, 4, ogp_black },
    { 9, 4, ogp_black },
    {10, 4, ogp_mid_grey },
    {11, 4, ogp_purple },
    {12, 4, ogp_orange },
    {13, 4, ogp_black },
    {14, 4, ogp_mid_grey },
    {15, 4, ogp_black },
    { 2, 5, ogp_purple },
    { 3, 5, ogp_sea_blue },
    { 8, 5, ogp_black },
    { 9, 5, ogp_mid_grey },
    {11, 5, ogp_dark_grey },
    {12, 5, ogp_black },
    {13, 5, ogp_red },
    {14, 5, ogp_dark_grey },
    { 3, 6, ogp_black },
    { 4, 6, ogp_red },
    { 5, 6, ogp_teal },
    { 8, 6, ogp_light_grey },
    { 9, 6, ogp_sky_blue },
    {10, 6, ogp_black },
    {12, 6, ogp_sea_blue },
    {14, 6, ogp_purple },
    {15, 6, ogp_yellow },
    { 4, 7, ogp_mid_grey },
    { 5, 7, ogp_yellow },
    { 6, 7, ogp_black },
    { 9, 7, ogp_black },
    {10, 7, ogp_yellow },
    {14, 7, ogp_sky_blue },
    {16, 7, ogp_orange },
    { 4, 8, ogp_green },
    { 5, 8, ogp_dark_grey },
    { 9, 8, ogp_red },
    {10, 8, ogp_black },
    {15, 8, ogp_black },
    {16, 8, ogp_green },
    { 4, 9, ogp_red },
    { 9, 9, ogp_green },
    {16, 9, ogp_sea_blue },
    { 4,10, ogp_orange }
  };
  
union {
  #local i = 0;
  #while (i < ogp_map_tiles)
    box {
     <0,0,0> <1, 1, 1>
     translate <-0.5, -0.5, -0.5>
     scale 0.9
     translate <ogp_map[i][0], ogp_map_height-ogp_map[i][1], 0>
     pigment {
       ogp_colours[ogp_map[i][2]]
     }
     finish {
       ambient 0.5
     }
    }
    #local i = i + 1;
  #end
  translate <-ogp_map_width/2, -ogp_map_height/2, 0>
  rotate x * 90
}

object {
   create_bot(with_textures)
   rotate y * 30
   translate <0, 0.5, -0.8>
}

light_source { default_light }
light_source { default_flood_light }

background{ White }

camera {
  location  <0, 9, -10>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 120 
  aperture 0.1
  focal_point <0,1,-1>
  
  look_at   <0, 0, -1>
}

