#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

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
}


// some duplication from the everypolitican-bot.inc but
// this is quick and dirty, and the bot is all
// wrapped up in a macro declaration which makes the
// parts inaccessible. Hack hack hack.

  #macro b_finger(fingertip_pigment)
    union {
      sphere {
        <0, 0 ,0> fingertip_rad
        translate x * finger_length
        texture {
          pigment { fingertip_pigment }
          finish { F_MetalA }
        }
      }
      cylinder { <0, 0, 0> <finger_length, 0> finger_rad }
    }
  #end

  #macro b_hand(pigments)
    union {
      object{ b_finger(fingertip_pigment) rotate z*45 }
      object{ b_finger(fingertip_pigment) }
      object{ b_finger(fingertip_pigment) rotate -z*45 }
    }
  #end

  #macro b_arm(fingertip_pigment)
    union {
      sphere {
        <0, 0 ,0> arm_rad
        translate x * arm_length
      }
      cylinder { <-0.1, 0, 0> <arm_length, 0, 0> arm_rad }
      object { b_hand(fingertip_pigment) translate x * arm_length}
      difference {
        cylinder { <-0.1, 0, 0> <-0.3, 0, 0> arm_rad * 0.85 }
        // slot for fixture of arm: engineering!
        union {
          object {
            RadiusBox(2, 6, 0.333)
            translate -x * 2.8
          }
          object {
            RadiusBox(0.5, 6, 0.333)
            rotate z * 90
            translate <-1.75, 0.5, 0>
          }
          scale 0.1
        }
      }
      // innermost core (otherwise the slot goes right to the middle)
      cylinder { <-0.1, 0, 0> <-0.3, 0, 0> arm_rad * 0.60 }
      texture{ texture_bot_metal }
      rotate z * 90
      translate y * 0.4
    }
  #end

#declare qty_arms = 7;
#declare table_height = 1.5;
#declare table_width = 1.6;
#declare table_length = qty_arms + 2;
#declare tabletop_thickness = 0.2;
// because rounded ends
#declare effective_table_length = table_length + table_width;
#declare podium_rad = 0.5;

// table has fancy podiums on it  
#declare table =
  union {
    difference {
      object {
        RadiusBox(table_length, table_height, table_width/2)
        rotate x * 90
        translate y * table_height/2
      }
      #declare i = 0;
      #while (i < qty_arms) // gutters around podiums
        torus {
          podium_rad 0.1
          translate <i * table_length/(qty_arms-1) - table_length/2, table_height, 0>
        }
        #declare i = i + 1;
      #end
    }
    #declare i = 0;
    #while (i < qty_arms) // podiums
      union {
        #declare edge_rad = 0.05;
        cylinder { <0,-0.5,0> <0,0.1-edge_rad,0> podium_rad }
        cylinder { <0,-0.5,0> <0,0.1,0> podium_rad-edge_rad }
        torus { podium_rad-edge_rad edge_rad translate y * (0.1-edge_rad) }
        translate <i * table_length/(qty_arms-1) - table_length/2, table_height, 0>
      }
      #declare i = i + 1;
    #end
    union {
      // table top edge
      cylinder {
        <-table_length/2, 0, 0> <table_length/2, 0, 0> tabletop_thickness/2
        translate <0, table_height, table_width/2 >
      }
      cylinder {
        <-table_length/2, 0, 0> <table_length/2, 0, 0> tabletop_thickness/2
        translate <0, table_height, -(table_width/2) >
      }
      difference {
        torus { table_width/2 tabletop_thickness/2 }
        plane { x 0 }
        translate <table_length/2, table_height, 0>
      }
      difference {
        torus { table_width/2 tabletop_thickness/2 }
        plane { -x 0 }
        translate <-table_length/2, table_height, 0>
      }
      translate -y * tabletop_thickness/2
    }      
    pigment { rgb <0.8, 0.8, 0.8> }
  }

#declare table_with_arms =
  union {
    object { table }
    #declare i = 1; // deliberately missing out arm 0 (red fingertips)
    #while (i < qty_arms)
      object {
        b_arm(mysoc_colours[i])
        translate x * (-0.1 + 0.2 * rand(r1))
        rotate y * (100 + 45 * rand(r1))
        translate <i * table_length/(qty_arms-1) - table_length/2, table_height, 0>
      }
      #declare i = i + 1;
    #end
    rotate y * 180 // for art: run the colours (and gap) backwards
  }

object { table_with_arms translate z * -3 }
object { table_with_arms translate z *  3  translate x * -0.25} // art
object {
   create_bot(with_textures)
   rotate y * -45
   translate x 
}

#declare xy_pipe =
  union {
    #declare j = 0;
    #while (j < 100)
      sphere {
        0 * y  0.3
        scale <0.333, 1, 1>
        translate x * 0.075 * j
      }
      #declare j = j + 1;  
    #end
  }

#declare wall_height = 10;
#declare wall_panel =
  union {
    box {
      <-2,0,0>, <5, wall_height, 0>
    }
    object { xy_pipe rotate z * 90 translate -x * 2}
    pigment { rgb <0.8, 0.8, 0.4> }
  }

#declare i = 0;
#while (i < 8)
  object {
    wall_panel
    translate z * 10
    rotate y * (i * 30 - 180 )
  }
  #declare i = i + 1;  
#end

object{
  xy_pipe
  pigment { White }
  rotate y * 90
  translate <-3, 0.5, -3>
}

light_source { default_light }
//light_source { default_flood_light }
sky_sphere{ default_sky_sphere }

camera {
  location  <4.5, 3.3, -5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.4
  focal_point <0, 1, -5>
  look_at   <0,1.7, 0>
}
