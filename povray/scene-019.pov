// bit looking at names on screen, from behind screen
// all very green

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

plane {
  y 0
  texture { pigment { floor_colour }}
  texture { texture_lines }
  texture { texture_lines rotate y * 90 }
  rotate -y * 12
}

plane {
  -z 1
  texture {
    pigment {
      image_map { png "bitmaps/multilingual-names.png" once } 
      translate <-0.5, -0.5, 0>
      rotate y * 180
      scale 7
      translate y * 2.8
    }
    finish { ambient 1 }
  }
  texture {
    pigment { rgbft <0,0.666,0,0.9, 0.333> }
  }
  no_shadow
}

object {
   create_bot(with_textures)
   rotate y * -12
   translate <-0.6, 0, 0.5>
}

light_source { default_light translate -x * 500}
light_source { default_flood_light }
light_source { <0, 2, -100> Green}

background{ White }

// really using focal blur here to fuzz the text
camera {
  location  <0, 4.5, -4> 
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky <0.1, 1, 0>
  blur_samples 124
  aperture 0.15
  focal_point <0, 0, 0>
  look_at   <0,2.2, 0>
}
