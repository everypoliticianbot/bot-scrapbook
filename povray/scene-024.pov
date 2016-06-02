// bot in glass bauble

global_settings { max_trace_level 8 }

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare bauble_rad = 3;

object {
   create_bot(with_textures)
   rotate y * 0
   translate x * bauble_rad * 2.1
}

#declare bauble =
  sphere {
    <0,2,0> bauble_rad
    hollow
    pigment { White filter 1 }
    interior{
       ior 1.45
       fade_distance 4
       fade_power 2
       caustics 2.0
    }
    finish {
       ambient 0.2
       diffuse 0.0
       reflection 0.12
       specular 1.0
       roughness 0.001
    }
  }

#declare i = 0;
#while (i < 10)
  object {
    bauble
    translate < (i - 5) *  bauble_rad * 2.1, rand(r1), 0 >
  }
  
  object {
    bauble
    translate <(i - 5) *  bauble_rad * 2.1, bauble_rad * 0.8, bauble_rad * 4>
  }
  
  object {
    bauble
    translate <(i - 5) *  bauble_rad * 2.1, bauble_rad * -1, bauble_rad * 8>
  }

  object {
    bauble
    translate <(i - 5) *  bauble_rad * 2.1, bauble_rad, -bauble_rad * 5>
  }
  
  #declare i = i + 1;
#end

cylinder { // floor
  y * -4  y * -3  32
  pigment { White } 
  normal { crackle scale 2 }
}

light_source { default_light }
light_source { default_flood_light }

// crazy lovely sky sphere (bonkers colours with turbulence)
sky_sphere {
  pigment {
    gradient y
    color_map {
      [ 0.1  color rgb < 1.0, 0.1, 0.4 > ] 
      [ 0.6  color CornflowerBlue ]
      [ 0.8  color CornflowerBlue ]
      [ 1.0  color rgb < 1.0, 0.1, 0.4 > ] 
    }
    turbulence 0.5
    scale 2
    translate -1
  }
}

camera {
  location  <0, 3, -10.5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky <0.1, 1, 0>
  blur_samples 128
  aperture 1
  focal_point <3,1.7,0>
  look_at   <3,1.7, 0>
}
