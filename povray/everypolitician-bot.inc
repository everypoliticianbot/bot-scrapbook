// POV-Ray definition of everypoliticianbot
//--------------------------------------------------
// requires colors include files already
//

#include "metals.inc"
#include "textures.inc"


#declare bot_rad = 1;
#declare botbody_height = bot_rad*1.2;
#declare dome_scale = 0.72;

#declare skirt_height = 0.333;
#declare skirt_thickness = 0.15;
#declare rivet_rad = 0.06;
#declare skirt_rivet_angle = 6;

#declare hat_button_rad = 0.25;
#declare hat_button_thickness = 0.2;
#declare hat_button_ferrule_rad = hat_button_rad * 1.1;
#declare hat_button_ferrule_thickness = 0.09;

#declare arm_rad = 0.3;
#declare arm_length = arm_rad * 0.8;
#declare arm_height_above_bottom = skirt_height * 2.2;

#declare finger_rad = 0.06;
#declare finger_length = arm_rad * 1.7;
#declare fingertip_rad = finger_rad * 1.9;

#declare antenna_angle = 50;
#declare antenna_height = 0.75;
#declare antenna_thickness = 0.15;
#declare antenna_bobble_rad = 0.09;

#declare leg_rad = 0.25;
#declare leg_length = 0.7;
#declare leg_cuff_thickness = 0.075 * 2;

#declare wheel_rad = 0.22;
#declare foot_width = 0.6;
#declare foot_length = 0.5;
#declare gap_between_wheels = 0.15;
#declare caterpillar_track_thickness = 0.05;
#declare shoe_thickness = leg_cuff_thickness;

#declare grille_height = 0.666;
#declare grille_width = 1.0;
#declare grille_thickness = 0.05;
#declare mouth_height = 0.1;
#declare mouth_width = 0.3;

#declare eye_lens_radius = 0.25;
#declare eye_frame_thickness = 0.2;
#declare eye_frame_thickness_multiplier = 1.4;
#declare eye_lens_slope_angle = 10;

#declare calculated_body_length = botbody_height + bot_rad * dome_scale;
#declare calculated_eye_height = skirt_height + grille_height + eye_lens_radius;

// bottom of body to wheel axel 
#declare calclulated_foot_drop = leg_length + leg_cuff_thickness/2 + shoe_thickness + caterpillar_track_thickness + wheel_rad/2 + caterpillar_track_thickness;

#declare calculated_body_to_floor_drop = calclulated_foot_drop + wheel_rad + caterpillar_track_thickness;

#declare screw_scale = 0.04;

#declare texture_none =
  texture {
    pigment { White }
  }

#declare texture_eye =
  texture {
    pigment { rgb <0.3, 0.1, 0.1> }
  }

#declare texture_eyeball = 
  texture {
    pigment { White }
  }
  
#declare texture_hat_button = 
  texture {
    pigment { rgb <0.3 0.7 0.3> }
  }

#declare texture_red_metal = 
  texture {
    pigment { rgb <0.8, 0.3, 0.3> }
    finish { F_MetalA }
  }

#declare texture_eye_frame = texture_red_metal

#declare texture_bot_metal = 
  texture {
    Copper_Metal
    //T_Copper_1B
  }

#declare texture_wheels = 
  texture {
    pigment { rgb < 0.4, 0.4, 0.4 > }
  }

#declare texture_grille = 
  texture {
    pigment { White }
    finish { F_MetalB }
  }

#declare texture_caterpillar_tracks = 
  texture {
    pigment { rgb < 0.5, 0.8, 0.5 > }
    normal { bumps 0.1 scale 0.02 }
  }

#declare texture_mouth_cutout = 
  texture {
    pigment { rgb < 0.2, 0.2, 0.2 > }
  }

//-----------------------------------------------------
// macro defined here: scope for want_texures
  
#macro create_bot(want_textures)

  // make a box with round ends
  // centred on origin, running along the x-axis, flat side towards z
  #macro RadiusBox(Length, Thickness, Rad)
    union {
      box{ <-Length/2, -Rad, -Thickness/2> <Length/2, Rad, Thickness/2> }
      cylinder {
        <0, 0 ,0> <0, 0, Thickness> Rad
        translate <-Length/2, 0, -Thickness/2>
      }
      cylinder {
        <0, 0 ,0> <0, 0, Thickness> Rad
        translate <Length/2, 0, -Thickness/2>
      }
    }
  #end

  #declare screw_head = 
    difference {
      sphere { <0,0,0> 1 }
      box { <-1.1, -0.2, -0.2> <1.1, 0.2, -1.1> }
      scale <1,1,1> * screw_scale
    }

  #declare bot_body_base =
    union {
      sphere {
        <0, 0 ,0> bot_rad
        scale <1, dome_scale, 1>
        translate y * botbody_height
      }
      cylinder { <0, 0, 0> <0, botbody_height, 0> bot_rad }
    }

  #declare bot_body = 
    difference {
      object { bot_body_base }
      difference {
        box { <-0.01, -0.1 , bot_rad*2>, < 0.01, botbody_height*2, -bot_rad*2> } 
        object { bot_body_base scale <0.95,0.95,0.95> }
        // this box to prevent cutaway within the mouth grille
        // so roughly where the grille cutaway will be
        box {
          <-0.1, skirt_height + screw_scale * 2, 0>
          < 0.1, grille_height * 1.6, -bot_rad * 1.1 >
        }
      }
    }

  #declare bot_finger =
    union {
      sphere {
        <0, 0 ,0> fingertip_rad
        translate x * finger_length
        #if (want_textures)
          texture { texture_red_metal }
        #end
      }
      cylinder { <0, 0, 0> <finger_length, 0> finger_rad }
    }

  #declare bot_hand =
    union {
      object{ bot_finger rotate z*45 }
      object{ bot_finger }
      object{ bot_finger rotate -z*45 }
    }

  #declare bot_arm =
    union {
      sphere {
        <0, 0 ,0> arm_rad
        translate x * arm_length
      }
      cylinder { <-0.1, 0, 0> <arm_length, 0> arm_rad }
      object { bot_hand translate x * arm_length}
      translate <bot_rad, arm_height_above_bottom, 0>
    }

  #declare bot_antenna =
    union {
      sphere {
        <0, 0 ,0> antenna_bobble_rad
        translate y * antenna_height
        #if (want_textures)
          texture { texture_red_metal }
        #end
      }
      cone { <0, 0, 0> antenna_thickness y * antenna_height 0 }
      translate y * bot_rad * dome_scale
      rotate -z * antenna_angle
      translate <0, botbody_height * 0.8, 0>
    }

  #declare bot_wheel =
    union {
      difference {
        cylinder { <0, 0, 0> <foot_width, 0, 0> wheel_rad }
        box {<-gap_between_wheels/2,-1,-1> <gap_between_wheels/2, 1, 1> translate x*foot_width/2}
      }
      // baby hub caps/axel ends
      sphere { <0, 0, 0> wheel_rad/3 }
      sphere { <foot_width, 0, 0> wheel_rad/3 }
      translate -x * foot_width/2
      #if (want_textures)
        texture { texture_wheels }
      #end
    }

  #declare bot_foot =
    union {
      object { bot_wheel translate -z * (foot_length - wheel_rad) } // front
      object { bot_wheel translate  z * (foot_length - wheel_rad)} // rear
      // the shoe
      intersection {
        difference {
          object {
            RadiusBox(
              foot_length + wheel_rad, 
              foot_width + shoe_thickness, 
              wheel_rad + shoe_thickness // + caterpillar_track_thickness
            )
          }
          object {
            RadiusBox(
              foot_length + wheel_rad, 
              foot_width + shoe_thickness * 2, 
              wheel_rad + caterpillar_track_thickness
            )
          }
        }
        object {
          RadiusBox(
            foot_length + wheel_rad, 
            foot_width + shoe_thickness * 2, 
            wheel_rad + shoe_thickness + caterpillar_track_thickness
          )
          translate y * wheel_rad* 1.666
        }
        #if (want_textures)
          texture { texture_red_metal }
        #end
        rotate y * 90 
      }
      // the caterpillar track
      difference {
        object {
          RadiusBox(
            foot_length + caterpillar_track_thickness * 2,
            foot_width, 
            wheel_rad + caterpillar_track_thickness
          )
        }
        object {
          RadiusBox(
            foot_length + caterpillar_track_thickness * 2,
            foot_width + 1, 
            wheel_rad
          )
        }
        rotate y * 90
        #if (want_textures)
          texture { texture_caterpillar_tracks }
        #end
      }
    }

  #declare bot_leg =
    union {
      cylinder { <0, 0, 0> <0, -leg_length, 0> leg_rad }
      torus {
        leg_rad, leg_cuff_thickness / 2
        translate -y * leg_length
      }
      object { bot_foot translate -y * calclulated_foot_drop }
      translate x * bot_rad * 0.5
    }

  #declare mouth_grille_plate =
    union {
      difference {
        cylinder {
          <0,0,0> <0,grille_height,0> bot_rad + grille_thickness
        }
        cylinder {
          <0,-0.1,0> <0,grille_height+0.1,0> bot_rad
        }
        plane { x 0 rotate y * 32 }
        plane { -x 0 rotate -y * 32 }
      }
      // left screws
      union {
        object {
          screw_head rotate z * 40 // random
          translate <0, grille_height - screw_scale * 2, -(bot_rad + grille_thickness )>
        }
        object {
          screw_head rotate z * 80 // random
          translate <0, screw_scale * 2, -(bot_rad + grille_thickness )>
        }
        rotate y * 28
      }
      // right screws
      union {
        object {
          screw_head rotate z * -40 // random
          translate <0, grille_height - screw_scale * 2, -(bot_rad + grille_thickness )>
        }
        object {
          screw_head rotate z * 10 // random
          translate <0, screw_scale * 2, -(bot_rad + grille_thickness )>
        }
        rotate y * -28
      }
      translate y * screw_scale * 2
      #if (want_textures)
        texture { texture_grille }
      #end
    }
  
  #declare mouth_cutout = 
      difference {
        union {
          object {
            RadiusBox(mouth_width, bot_rad * 3, mouth_height / 2)
            translate y * mouth_height * 1.6
          }
          object {
            RadiusBox(mouth_width, bot_rad * 3, mouth_height / 2)
            translate y * mouth_height * 0
          }
          object {
            RadiusBox(mouth_width, bot_rad * 3, mouth_height / 2)
            translate y * mouth_height * -1.6
          }
          translate y * ( screw_scale * 2 + grille_height / 2)
        }
        plane { -z 0 }
        #if (want_textures)
          texture { texture_mouth_cutout }
        #end
      }

  #declare eye_base =
    difference {
      cylinder {
        <0,0,0> <0, 0, -1> eye_lens_radius
      }
      plane { -y 0 rotate z translate y * eye_lens_radius * 0.666 }
    }

  #declare eye_frame =
    intersection {
      difference {
        union {
          difference {
            object {
              eye_base
              scale <1, 1, 1> * eye_frame_thickness_multiplier 
            }
            object { eye_base scale <1, 1, 2> }
            rotate z * eye_lens_slope_angle
            translate -x * eye_lens_radius * eye_frame_thickness_multiplier * 0.9
          }
          difference {
            object {
              eye_base
              scale <1, 1, 1> * eye_frame_thickness_multiplier
            }
            object { eye_base scale <1, 1, 2> }
            rotate -z * eye_lens_slope_angle
            translate x * eye_lens_radius * eye_frame_thickness_multiplier * 0.9
          }
        }
        cylinder { <0,-1,0> <0,1,0> bot_rad - eye_frame_thickness }
      }
      cylinder { <0,-1,0> <0,1,0> bot_rad + eye_frame_thickness }
      #if (want_textures)
        texture { texture_eye_frame }
      #end
    }

  #declare eyeball =
    union {
      // pupil
      object {
        screw_head
        rotate -z * 10
        scale <1,1,0.8> * 2.4
        translate -z * eye_lens_radius 
        #if (want_textures)
          texture { texture_eye }
        #end
      }
      intersection { // cutting eye to fit within frame
        sphere {
          <0, 0, -0.4> eye_lens_radius * 1.1
          scale <1, 1, 0.333>
        }
        object {
          eye_base 
          translate z * 0.5
        }
        #if (want_textures)
          texture { texture_eyeball }
        #end
        scale <1,1,1> * 1.1
      }
    }

  #declare single_eye =
    object {
      eyeball
      translate -z * 0.9
      rotate z * eye_lens_slope_angle
      rotate y * (eye_lens_slope_angle + 5)  // done by inspection
    }

  #declare eyes = 
    union {
      object { eye_frame }
      object {
        single_eye
      }
      object {
        single_eye
        scale <-1, 1, 1>
      }
      translate z * 0.12 // bodge, pulling frame back into body
      rotate x * 10
    }

  #declare eye_frame_support =
    union {
      intersection {
        difference {
          object {
            RadiusBox(
              1, 
              3, 
              0.25
            )
            scale 2 * <eye_frame_thickness, eye_frame_thickness, 0.5>
          }
          plane {  x 0 }
          plane { -z 0 }
          cylinder { <0,-1,0> <0,1,0> bot_rad }
        }
        cylinder { <0,-1,0> <0,1,0> bot_rad + eye_frame_thickness / 3 }
        #if (want_textures)
          texture { texture_eye_frame }
        #end
      }
      object {
        screw_head rotate z * 40 // random
        translate -z * (bot_rad + eye_frame_thickness/3)
        rotate y * -10
      }
    }

  #declare eye_frame_supports =
    union {
      object {
        eye_frame_support
        rotate y * -34
      }
      object {
        eye_frame_support
        scale <-1, 1, 1>
        rotate y * 34
      }
      translate y * eye_frame_thickness/2
    }

  #declare bot_body_with_skirt =
    union {
      difference {
        union {
          object{ bot_body }
          object {
            mouth_grille_plate
            translate y * skirt_height
          }
        }
        object { 
          mouth_cutout
          translate y * skirt_height
        }
      }
      // skirt
      difference {
        cylinder {<0, 0, 0> <0, skirt_height, 0> bot_rad + skirt_thickness}
        cylinder {<0, -1, 0> <0, skirt_height + 0.1, 0> bot_rad}
        box {<-0.01, -1 , 0>, < 0.01, botbody_height*2, -bot_rad*2>} 
      }
      // skirt rivets
      sphere {
        <0, skirt_height/2, -(bot_rad+skirt_thickness)> rivet_rad
        rotate -y*skirt_rivet_angle
      }
      sphere {
        <0, skirt_height/2, -(bot_rad+skirt_thickness)> rivet_rad
        rotate y*skirt_rivet_angle
      }
    }

  #declare hat =
    union {
      // hat button
      intersection {
        cylinder {
          <0, 0, 0> <0 hat_button_thickness 0> hat_button_rad
        }
        cone {
          <0, -0.001, 0> hat_button_rad*2 <0, hat_button_thickness*1.666, 0>  0
        }
        #if (want_textures)
          texture { texture_hat_button }
        #end
      }
      // hat ferrule
      torus {
        hat_button_ferrule_rad, hat_button_ferrule_thickness
        translate -y * hat_button_ferrule_thickness / 2
      }
      translate y * calculated_body_length
    }

    // here's the actual bot! 
    union{
        object { bot_body_with_skirt }
        object { hat }
        object { bot_arm rotate y*20 }
        object { bot_arm rotate y*160 }
        object { bot_antenna }
        object { bot_antenna rotate y * 180 }

        object { bot_leg }
        object { bot_leg rotate y * 180 }

        // glasses and eyes
        union {
          object { eyes }
          object { eye_frame_supports }
          translate y * calculated_eye_height
        }
        translate y * calculated_body_to_floor_drop
        texture {
          #if (want_textures)
            texture_bot_metal
          #else
            texture_none
          #end
        }
    }

#end
//--- end of macro -------------------------------
