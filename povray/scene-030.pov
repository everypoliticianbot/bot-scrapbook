// height field

global_settings { max_trace_level 8 }

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#include "ruby-gemstone.inc"

#declare r1 = seed(0);

light_source { default_light rotate y * 90}
light_source { default_flood_light }

sky_sphere { default_sky_sphere }

union {
  object {
     create_bot(with_textures)
     scale 0.8
     translate y *0.4
     rotate y * -12
  }
  object {
    ruby_gemstone()
    scale 10
    translate y * 2
  }
}

height_field {
  gif "bitmaps/heightfield-circular.gif"
  //smooth
  hollow
  translate <-0.5, -0.5, -0.5>
  rotate z * 180
  scale <500, 250, 500>
  pigment { White * 0.8 }
  normal { crackle 1.0 scale 10}
  //finish { ambient 0.4 }
}

light_source {<0,-2,0> colour rgb <1, 0, 0>}

camera {
  location  <0.5, 0.8, -7.2> 
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.2
  focal_point <0, 1, -2>
  look_at   <0, 1.5, 0>
}

