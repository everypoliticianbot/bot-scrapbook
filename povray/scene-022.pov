// Simple bot-on-white scene
// Handy for a starting point for more complex scenes
// Bot is positioned dead centre of frame, toe-to-top visible
// Note: no interesting reflections on bot in an empty scene like this

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);


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
      texture{ texture_bot_metal }
      rotate z * 90
      translate y * 0.4
      // local fixes
      rotate -z * 45
      translate <0.666, 2.1, 0>
      rotate y * 20
    }
  #end

  #declare leg_y_offset = calculated_body_to_floor_drop;
  #declare b_leg =
  intersection {
    object { create_bot(with_textures)}
    box {
      <0, calculated_body_to_floor_drop*0.95, -2>
      <2, -2, 2>
    }
    translate -x * bot_rad * 0.5
    rotate y * -10 // slight turn out
    translate y * -leg_y_offset
    rotate z * 60
    translate y * leg_y_offset * 1.0
    translate x * 0.45
  }

object { create_bot(with_textures) }
object { b_arm( colour_bot_red ) }
object { b_arm( colour_bot_red ) scale <-1, 1, 1> }
object { b_leg }
object { b_leg scale <-1, 1, 1> }

#declare circle_rad = 2;
#declare slen = circle_rad * 1.9;
#declare slen_y = slen * 0.95;
#declare boundary_rad = 0.025;

// Vetruvian frame
union {
  torus {
    circle_rad boundary_rad
    rotate x * 90
    translate y * 1.70
  }
  union {
    cylinder { <-slen/2, 0, 0> < slen/2, 0, 0>  boundary_rad }
    cylinder { <-slen/2, 0, 0> <-slen/2, slen_y, 0> boundary_rad }
    cylinder { <-slen/2, slen_y, 0> < slen/2, slen_y, 0>  boundary_rad }
    cylinder { < slen/2, 0, 0> < slen/2, slen_y, 0> boundary_rad }
    sphere { <-slen/2, 0, 0> boundary_rad }
    sphere { < slen/2, 0, 0> boundary_rad }
    sphere { <-slen/2, slen_y, 0> boundary_rad }
    sphere { < slen/2, slen_y, 0> boundary_rad }
    translate -y * 0.2
  }
  pigment { Brown }
}

plane {
  z 1
  pigment { image_map { jpeg "bitmaps/vetruvian-man.jpg" } scale 5.7 translate <1,-1.2,0>}
  finish { ambient 0.4 }
}

light_source { default_light }
light_source { default_flood_light }


//background{ White }

camera {
  location  <0, 3, -6.5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <0,1.8, 0>
}
