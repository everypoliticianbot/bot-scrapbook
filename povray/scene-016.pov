#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare cube_size = 0.5;
#macro little_cube(box_colour)
  box {
   <-0.5,0,-0.5><0.5,1,0.5>
   scale cube_size
   pigment { box_colour }
  }
#end

#macro neat_piles_of_two_cubes(
    qty_per_row, box_colour_1, qty_box_1, box_colour_2, qty_box_2
  )
  #local i = 0;
  #local xi = 0; 
  #local yi = 0;
  #local box_colour = box_colour_1;
  #while (i < qty_box_1 + qty_box_2)
    object {
      little_cube(box_colour)
      rotate y * (rand(r1) * 12 - 6)
      translate <xi * cube_size * 1.3, yi * cube_size * 1.3, 0> 
    }
    #local i = i + 1;
    #if (mod(i, qty_per_row) = 0 )
      #local xi = 0;
      #local yi = yi + 1;
    #else
      #local xi = xi + 1;
    #end
    #if (i = qty_box_1)
      #local box_colour = box_colour_2;
    #end
  #end
#end

#local commit_colour = rgb <0.6, 0.6, 1.0>;
#local pr_colour = rgb <0.2, 0.2, 1.0>;

#declare boxes = 
  union {
    neat_piles_of_two_cubes(
      40, 
      commit_colour, 391, 
      pr_colour, 181
    )
  }

object {
  boxes
  translate -max_extent(boxes)/2
  rotate x * 90
  translate y * 0.6
  translate -z * 0.5 // artistic nudge
}
  
object {
  create_bot(with_textures)
  translate <0, 0, 6>
}

background { White }

plane { -y 0 pigment { White } finish { ambient 0.666}}

light_source { default_light }
light_source { default_flood_light }

camera {
  location  <3, 9, -15>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
/*
  blur_samples 128
  aperture 0.1
  focal_point <0, 5, 0>
*/
  look_at   <0.75,0,0>
}
