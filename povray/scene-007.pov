#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare floor_colour = rgb <0.5, 0.5, 0.7>;

object {
   create_bot(with_textures)
   rotate y * 0
}

// crazy lovely sky sphere (bonkers colours with turbulence)
sky_sphere {
  pigment {
    gradient y
    color_map {
      [ 0.1 color rgb <0,0,0> ]
      [ 0.2 color rgb < 1.0, 0.1, 0.4 > ] 
      [ 0.4 color CornflowerBlue ]
      [ 1.0 color rgb <0,0,0> ]
    }
    turbulence 0.2
    scale 2
    translate -1
  }
}

light_source { default_light }
light_source { default_flood_light }

// funky light for the artiness
light_source {<-4,8,-2>*1000 colour rgb <1,0,0>}

camera {
  location  <0, 2.9, -2.5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky <-0.1, 1, 0>
  blur_samples 128
  aperture 0.25
  focal_point <0,2.5,0>
  look_at   <0,2.7,0>
}
