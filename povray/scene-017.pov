// Bot with many shiny spheres. No reason except retty reflections,
// which is what POVRay is good at. Also, three coloured light
// sources for the arts.
// Quite slow to render.

global_settings { max_trace_level 8 }
 
#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare stage_rad = 6;
#declare sphere_rad = 1;
#declare qty_spheres = 20;
#declare qty_spheres_y = 24;
#declare j = 0;

#while (j < qty_spheres_y)
  #declare i = 0;
  #while (i < qty_spheres)
    sphere {
      <0,0,0> sphere_rad
      texture { T_Chrome_3E }
      translate < 
        0 // (-qty_spheres/2 + i) * sphere_rad * 2,
        (-qty_spheres_y/2 + j) * sphere_rad * 2,
        6
      >
      #if (mod(i, 2))
        translate y * sphere_rad
      #end
      rotate y * (-180 + ((360 / qty_spheres) * i ))
    }
    #declare i = i + 1;
  #end
  #declare j = j + 1;
#end

union {
  difference {
    sphere { x * 0 sphere_rad + 0.1 }
    plane { -y 0 }
  }
  torus { sphere_rad 0.1 }
  cylinder { y * 0  y * -1000 0.3 }
  texture { T_Chrome_3E }
}

object {
   create_bot(with_textures)
   scale 0.7
   rotate y * 20
}

light_source {<-2,10,-2> colour rgb <0.2,1,0.2>}
light_source {< 0,10,-3> colour rgb <1,0.2,0.2>}
light_source {< 2,10,-4> colour rgb <0.2,0.2,1>}
light_source {
  <1,-2,-4>
  colour rgb <0.6, 0.6, 0.6>
  shadowless
}
light_source { default_flood_light }


camera {
  location  <1, 3.9, -5.4>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.15
  focal_point <0,0.8,0>
  look_at   <0,0.8, 0>
}
