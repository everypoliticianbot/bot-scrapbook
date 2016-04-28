#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

object {
   create_bot(with_textures)
   rotate y * 188
   translate <-2.95, -1.1, 0>
}

box {
  <0,0,0>,<1,1,0.01>
  pigment { image_map { png "bitmaps/viewer-sinatra-preview-link.png" } }
  finish { ambient 0.3 }
  translate <-0.5, -0.52, 0>
  scale 10
  translate <1, 5, 2>
}

#declare floor_colour = rgb <0.5, 0.5, 0.7>;
#declare grout_colour = <0.4, 0.4, 0.6, 0>;
#declare texture_lines =
  texture {
    pigment{
      gradient x
      color_map{
                [0.0 color rgbt grout_colour ]
                [0.1 color rgbt grout_colour ]
                [0.1 color rgbt <0,0,0,1> ]
                [1.0 color rgbt <0,0,0,1> ]
      }
      rotate y * 90
    }
  }

plane {
  y 0
  texture { pigment { floor_colour }}
  texture { texture_lines }
  texture { texture_lines rotate y * 90 }
  rotate y * 12
  rotate x * 8
}

union {
  box { <-2,-0.333,0><0,0.333,1> }
  difference {
    box { <-0.5, -0.5, 0> <0.5, 0.5, 1> rotate z * 45 }
    plane { x  0 }
  }
  pigment {Red}
  no_shadow
  scale <0.333, 0.333, 0.0001>
  rotate z * -130
  translate <1.4, 1.1, 1.8>
}

light_source { default_light }
light_source { default_flood_light }
sky_sphere { default_sky_sphere }


camera {
  location  <0, 2, -4.5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
/*
  blur_samples 128
  aperture 0.12  // want to be able to read all the code text, so keep it small
  focal_point <0,2,-1>
*/
  look_at   <0,2.1,0>
}
