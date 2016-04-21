#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

plane { y 0
  texture {
    T_Chrome_3E
    normal {
      ripples 0.8
      turbulence 0.2
      scale 0.5
      translate -x * 2.5
    }
  }
}

object {
   create_bot(with_textures)
   scale 0.8
   rotate -y * 40
   translate -x * 2.5
}

sky_sphere { default_sky_sphere }
light_source { default_light }
light_source { default_flood_light }

camera {
  location  <0, 4, -6>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.1
  focal_point <0,1,0>
  look_at   <0,0.9,0>
}
