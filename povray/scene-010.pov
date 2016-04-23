// note: scene-010 uses isosurface for asteroids and takes a considerably
// bit longer to render than any of the other everypolitician bot scenes so far,
// especially with focal blur on the camera
// The star map doesn't show up with focal blur on, but meh.

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#include "functions.inc"

#declare F=function{pigment{
  crackle 
  turbulence 0.1
  color_map { [0 rgb 1] [1 rgb 0] }
  scale 0.5
  }
}

// asteroid chunks
isosurface {
  function { F(x,y,z).red - 0.4 }
  max_gradient 5.5
  contained_by{box{-2,2}}
  pigment {rgb .8}
  scale 4
  translate -x * 5
}

object {
   create_bot(with_textures)
   scale 0.333
   rotate x * 30
   rotate z * 45
   translate <3.2, -0.75, 0> 
}

#include "stars.inc"
sphere{
  <0,0,0>, 1
  hollow
  texture{ Starfield1 scale 0.75 }
  scale 10000
}
      
// handful of explicit "stars" to give the impression of billions
// smoke and mirrors
// carefully positioned to not be obscured by objects already in scene
#declare star_size = 0.005;
union {
  sphere { < 1.5, 0.0, 0> star_size  }
  sphere { < 3.2, 0.3, 0> star_size  }
  sphere { < 3.3, 0.4, 0> star_size * 1.4 }
  sphere { < 4.0,-0.5, 0> star_size }
  sphere { < 4.6,-0.2, 0> star_size * 1.2  }
  sphere { < 2.7,-1.2, 0> star_size }
  sphere { <-1.2,-0.8, 0> star_size * 1.2 }
  sphere { <-1.1,-0.85, 0> star_size }
  pigment { White }
  finish {ambient 0.8 }
}

light_source { default_light }
light_source { default_flood_light }

camera {
  location  <0, 0, -5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.16
  focal_point <0,0,0>
  look_at   <0,0,0>
}
