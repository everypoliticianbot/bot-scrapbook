// ruby

global_settings { max_trace_level 8 }

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#include "ruby-gemstone.inc"

#declare r1 = seed(0);

light_source { default_light }
light_source { default_flood_light }

background { Orange }

object {
   create_bot(with_textures)
   rotate <0, 4, 4>
}

union {
  #declare qty_gems = 90;
  #declare i = 0;
  #while (i < qty_gems)
    #declare i = i + 1;
    object {
      ruby_gemstone()
      translate <3, 0.5 + i * 0.04, 0>
      rotate y * 12 * i // 12 degrees because art
    }
  #end
  rotate z * -10
}

// curved hollow ground for background interest
difference {
  cylinder {
    z * -20 
    z * 20
    30
  }
  cylinder {
    z * -21
    z * 21
    29
  }
  plane { -y 0 }
  translate <1, 28.5, 0>
  scale <1, 0.5, 1>
  rotate z * 20
  pigment { Orange }
}

camera {
  location  <0.5, 3, -5> 
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.2
  focal_point <0, 1, -2>
  look_at   <-0.5, 2, 0>
}
