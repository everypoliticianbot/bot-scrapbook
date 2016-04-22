#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare floor_colour = rgb <0.5, 0.5, 0.7>;

object {
   create_bot(without_textures)
   texture {
     T_Chrome_3D
     normal { bumps 0.2 scale 5 }
    }
   no_shadow
   rotate y * 0
}

// flamey backdrop
box {
    <-100, -100, 2> <100, 100, 2.0001>
    pigment {
        marble 
        color_map {
          [0.0  color Yellow]
          [1.0  color Red]
        }
        turbulence 2
        scale <5, 10, 5>
    }
    finish { ambient 0.333 }
}

plane { y 0 pigment {rgb 0} }

// throw a bunch of blocks around for reflections
#declare qty_blocks = 16;
#declare i = 0;
#while (i < qty_blocks)
  box {
    <0,0,0>,<10,4,2>
    translate -x * 5
    scale <1 + rand(r1)*-0.2, 0.2 + rand(r1) , 1>
    translate <0,0,-12>
    rotate y * (180/qty_blocks * i - 75)
    translate y * 2
    pigment {rgb 1 - rand(r1)*0.5 }
    finish {ambient 0.5}
    no_shadow
  }
  #declare i=i+1;
#end

sky_sphere {
  pigment {
    gradient y
    color_map {
      [ 0.0  color White ]
      [ 0.5  color CornflowerBlue ]
      [ 1.0  color White ]
    }
    turbulence 0.5
    scale 2
    translate -1
  }
}

light_source { default_light }
light_source { default_flood_light }

// funky light for the artiness
light_source {<-4,8,-2>*1000 colour rgb <1,0,0>}

camera {
  location  <0.1, 1.3, -5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <0,2,0>
}
