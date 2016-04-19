#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);
#declare boxsize = 0.9;

#macro databox()
  box {
    <0,0,0>, <1,1,1>
    texture {
      pigment { image_map { png "bitmaps/github-mark-grey.png" } }
    }
    translate <-0.5, 0, 0.5>
    rotate y * 30 * (rand(r1)-0.5)
    scale boxsize // smaller than width of rollers
  }
#end

#macro cylinders(quantity, height, box_modulo)
  #local cylinder_rad = 0.2;
  #local i = 0;
  #while (i < quantity)
    union{
      #if (mod(i, box_modulo) = 0)
        object {
          databox()
          translate <0.50, cylinder_rad, 0>
        }
      #end
      // roller
      cylinder {
        <0,0,0> <1,0,0> cylinder_rad
        texture {
          pigment { rgb 0.3 }
          normal {
            bumps 0.4 scale 0.01
          }
        }
      }
      cylinder {
        <-0.2,0,0> <1.2,0,0> cylinder_rad / 3
      }
      cylinder {
        <0,0,0> <cylinder_rad * 2.1 ,0,0> cylinder_rad / 3
        rotate y * 90
        translate x * -0.2
      }
      cylinder {
        <0,0,0> <cylinder_rad * 2.1 ,0,0> cylinder_rad / 3
        rotate y * 90
        translate x * 1.2
      }
      #if (mod(i, 8) = 0) // every fourth roller: a leg
        cylinder {<-0.2,0,0> <-0.2,-10,0> cylinder_rad / 3 }
        cylinder {< 1.2,0,0> < 1.2,-10,0> cylinder_rad / 3 }
        // top
        torus { cylinder_rad/2  cylinder_rad/3 rotate x * 90 translate x * -0.2 }
        torus { cylinder_rad/2  cylinder_rad/3 rotate x * 90 translate x *  1.2 }
        // foot
        torus { cylinder_rad/2  cylinder_rad/3 translate <-0.2, -height, 0> }
        torus { cylinder_rad/2  cylinder_rad/3 translate < 1.2, -height, 0> }
      #end
      texture { T_Chrome_3C }
      translate <-0.5, height, i * cylinder_rad * 2.1>
    }
    #local i = i + 1;
  #end
#end

#declare i = 0;
union {
  #while (i < 5)
    object {
      databox()
      rotate y * 90
      translate <11, 0, 0 + boxsize * i * 1.5> 
    }
    #declare i = i +1;
  #end
}

object {
   create_bot(with_textures)
   rotate y * -30
   translate <-1.6, 0, 1> 
}


union {
  cylinders(100, 1, 8)
  translate -z * 10
  rotate y * 45
  translate <0, 0, 0>
}

union {
  cylinders(100, 3, 10)
  translate -z * 20
  rotate y * 0
  translate <3, 0, 0>
}

union {
  cylinders(100, 2.5, 10)
  translate -z * 19
  rotate y * -50
  translate <-4, 0, 0>
}

union {
  cylinders(100, 1, 8)
  translate -z * 20
  rotate y * 60
  translate <0, 0, 14>
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
}

light_source {<2,5,0>*1000 colour rgb <1,1,1>}

sky_sphere { default_sky_sphere }
light_source { default_flood_light }

camera {
  location  <-1, 6, -7>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 256 // high for this scene
  aperture 0.5
  focal_point <0, 1, 0>

  look_at   look_at_target * <0, 1, 0>
}
