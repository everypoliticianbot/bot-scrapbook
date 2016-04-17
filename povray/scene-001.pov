#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

object {
   create_bot(with_textures)
   rotate y * 30
   translate <4, 0, -0.25> 
}

#declare j=1;
#while (j < 3)
  #declare i=0;
  #while (i < 7)
    object {
       create_bot(without_textures)
       translate <-12 + i * 4, 0, 1 + j * 3> 
    }
    #declare i=i+1;
  #end
  #declare j=j+1;
#end

plane {
  y 0
  pigment {
    checker
    pigment { image_map { png "bitmaps/mysociety-logo-circles-faded.png"} }
    pigment { image_map { png "bitmaps/github-mark-grey.png" } }
    rotate x * 90
    scale 4
  }
  translate z * 2 // nudge for artistic effect daahlink
}

sky_sphere { default_sky_sphere }
light_source { default_light }
light_source { default_flood_light }

camera {
  location  <-1, 6, -7>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.5
  focal_point look_at_target
  look_at   look_at_target * <1, 1, -1.2>
}
