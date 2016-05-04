// note: final image has Photoshop lens flare (with some restraint,
//       e.g., dropped the outer artefacts) added to fuzz the light
//       source up a bit

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

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

union {
  object {
     create_bot(with_textures)
     rotate y * 0
     translate <3, 0, 0>
  }
  plane { // Gundamcat from GitHub
    z 0
    pigment {
      image_map {
        png "bitmaps/gundamcat.png" once 
      } 
      scale 4
    }
    finish { ambient 0.666 }
    translate <-4, 0, 0>
  }
  plane { // floor
    -y 0
    texture { pigment { floor_colour }}
    texture { texture_lines }
    texture { texture_lines rotate y * 90 }
  }
  scale 0.8
  rotate x * -4 // tip everything down a bit to get better floor shadows
}

// background wall for shadows
plane {
  z 3
  pigment { rgb < 0.8, 0.8, 0.8 > }
}

sky_sphere { default_sky_sphere }

light_source { default_flood_light }

#declare light_at = <0,0.333,-3>;

light_source {
  light_at
  colour White
  area_light <0.015, 0, 0> *  light_at  <0, 0, 0.015> *  light_at, 4, 4
}
sphere { light_at 0.15 no_shadow pigment { White } finish { ambient 1 } }

camera {
  location  <-2, 1, -9>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky       <0.1, 1, 0>
  look_at   <0,2,0>
}
