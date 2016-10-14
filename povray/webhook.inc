#include "functions.inc" // for helix

#declare hook_major_rad = 1;
#declare hook_rad = 0.15;
#declare hook_length = 14;
#declare hoop_rad = bot_rad + hook_rad * 2;

#declare hook_helix_length = 1.2;

#declare helix_x = 0.12;
#declare helix_qty_spheres = 46;

// fudge of 0.955 below is from trial and error
#declare helix_length = (helix_qty_spheres-1) * helix_x * 0.955;

#declare hook_helix =
  sphere_sweep {
    b_spline
    helix_qty_spheres,
  
    <helix_x *  0,  0.0> hook_rad,
    <helix_x *  0.5,0.0> hook_rad,
    <helix_x *  1,  0.0> hook_rad,

    <helix_x *  2,  0.50,  0.00> hook_rad,
    <helix_x *  3,  0.00, -0.50> hook_rad,
    <helix_x *  4, -0.50,  0.00> hook_rad,
    <helix_x *  5,  0.00,  0.50> hook_rad,
    <helix_x *  6,  0.50,  0.00> hook_rad,
    <helix_x *  7,  0.00, -0.50> hook_rad,
    <helix_x *  8, -0.50,  0.00> hook_rad,
    <helix_x *  9,  0.00,  0.50> hook_rad,
    <helix_x * 10,  0.50,  0.00> hook_rad,
    <helix_x * 11,  0.00, -0.50> hook_rad,
    <helix_x * 12, -0.50,  0.00> hook_rad,
    <helix_x * 13,  0.00,  0.50> hook_rad,
    <helix_x * 14,  0.50,  0.00> hook_rad,
    <helix_x * 15,  0.00, -0.50> hook_rad,
    <helix_x * 16, -0.50,  0.00> hook_rad,
    <helix_x * 17,  0.00,  0.50> hook_rad,
    <helix_x * 18,  0.50,  0.00> hook_rad,
    <helix_x * 19,  0.00, -0.50> hook_rad,
    <helix_x * 20, -0.50,  0.00> hook_rad,
    <helix_x * 21,  0.00,  0.50> hook_rad,
    <helix_x * 22,  0.50,  0.00> hook_rad,
    <helix_x * 23,  0.00, -0.50> hook_rad,
    <helix_x * 24, -0.50,  0.00> hook_rad,
    <helix_x * 25,  0.00,  0.50> hook_rad,
    <helix_x * 26,  0.50,  0.00> hook_rad,
    <helix_x * 27,  0.00, -0.50> hook_rad,
    <helix_x * 28, -0.50,  0.00> hook_rad,
    <helix_x * 29,  0.00,  0.50> hook_rad,
    <helix_x * 30,  0.50,  0.00> hook_rad,
    <helix_x * 31,  0.00, -0.50> hook_rad,
    <helix_x * 32, -0.50,  0.00> hook_rad,
    <helix_x * 33,  0.00,  0.50> hook_rad,
    <helix_x * 34,  0.50,  0.00> hook_rad,
    <helix_x * 35,  0.00, -0.50> hook_rad,
    <helix_x * 36, -0.50,  0.00> hook_rad,
    <helix_x * 37,  0.00,  0.50> hook_rad,
    <helix_x * 38,  0.50,  0.00> hook_rad,
    <helix_x * 39,  0.00, -0.50> hook_rad,
    <helix_x * 40, -0.50,  0.00> hook_rad,
    <helix_x * 41,  0.00,  0.50> hook_rad,
    <helix_x * 42,  0.00,  0.00> hook_rad,
    <helix_x * 42.5,0.00,  0.00> hook_rad,
    <helix_x * 44,  0.00,  0.00> hook_rad
  }

#declare hook_end =
  sphere_sweep {
    b_spline
    7
    <-hook_major_rad, 0, 0> hook_rad
    <0, 0, 0> hook_rad
    <hook_major_rad/100, 0, 0> hook_rad
    <hook_major_rad, -hook_major_rad, 0> hook_rad
    <hook_major_rad * 2, 0, 0> hook_rad
    <hook_major_rad,  hook_major_rad, 0> hook_rad
    <0,  -hook_major_rad/2, 0> hook_rad
  }

#local helix_offset = hook_length/4; // how far along hook is helix?

#declare webhook =
  union {
    difference { // main stem wth gap for helix
      cylinder {
        <0, 0, 0> <hook_length, 0, 0> hook_rad
      }
      cylinder {
         x * helix_offset
         x * (helix_offset + helix_length)
         3
      }
    }
    object {
      hook_helix
      translate x * helix_offset
    }
    object {
      hook_end
      translate x * hook_length * 1.01
    }
  }

#macro tapered_box(taper_angle)
  difference {
    box {
      <0,0,0> <1,1,1>
    }
    plane {  x 0 rotate -z * taper_angle }
    plane { -x 0 rotate  z * taper_angle translate x }
    plane {  z 0 rotate  x * taper_angle }
    plane { -z 0 rotate -x * taper_angle translate z }
    translate <-0.5, 0, -0.5>
  }
#end

#macro row_of_rivets(qty_rivets) // spaced up y at origin
  #local i = 0;
  #while (i <= qty_rivets)
    sphere { y * 0.1 * i  0.02 }
    #local i = i + 1;
  #end
#end

#macro everypolitician_triple_bars(ep_bars_colour)
  union {
    #local bar_length = 0.21;
    #local bar_thickness = 0.04;
    #local bar_radius = 0.04;
    #local i = 0;
    #while (i < 3)
      union {
        sphere { x * -bar_length/2 bar_radius }
        sphere { x *  bar_length/2 bar_radius }
        cylinder {
          x * -bar_length/2
          x *  bar_length/2
          bar_radius
        }
        translate y * (i - 1) * bar_radius * 4
        scale <1, 1, 0.5>
      }
      #local i = i + 1;
    #end
    pigment { ep_bars_colour }
    finish { F_MetalA }
  }
#end

#macro taper_box_with_rivets(taper_angle)
  union {
    tapered_box(taper_angle)
    #local qty_rivets = 8;
    union {
      union {
        row_of_rivets(qty_rivets)
        translate x * 0.05      
        translate <-0.5, 0, -0.5>
        rotate -z * taper_angle
      }
      union {
        row_of_rivets(qty_rivets)
        translate x * (1-0.05)
        translate <-0.5, 0, -0.5>
        rotate  z * taper_angle
      }
      object {
        everypolitician_triple_bars(mysoc_green)
        translate <0.0, 0.425, -0.5>
      }
      rotate  x * taper_angle
    }
    union {
      union {
        row_of_rivets(qty_rivets)
        translate x * 0.05      
        translate <-0.5, 0, -0.5>
        rotate -z * taper_angle
      }
      union {
        row_of_rivets(qty_rivets)
        translate x * (1-0.05)
        translate <-0.5, 0, -0.5>
        rotate  z * taper_angle
      }
      object {
        everypolitician_triple_bars(mysoc_green)
        translate <0.0, 0.425, -0.5>
      }
      translate z
      rotate  -x * taper_angle
    }
  }
#end

#declare webhook_base =
  union {
    difference {
      object {
        taper_box_with_rivets(8)
        scale <2,2,2>
      }
      cylinder { // hole for webhook
        <0,0,0> x * 10 hook_rad * 1.25
        translate 1.5 * y
      }
    }
    object {
      tapered_box(45)
      scale <3, 0.8, 3>
      pigment { 
        gradient x
        color_map {
          [ 0.0  color Yellow ] 
          [ 0.5  color Yellow ] 
          [ 0.5  color Black ]
          [ 1.0  color Black ]
        }
        scale 0.6
        rotate y * 45
      }
    }
  }

// handle_angle: 0 = upright, 90 = pulled fully down
#macro webhook_handle(handle_angle)
  #local handle_length = 2.0;
  #local handle_rad = 0.16;
  union {
    cylinder {
      <0, 0, -handle_length*0.36> <0, 0, handle_length*0.36> handle_rad * 1.4
      pigment { Red }
    }
    cylinder {
      <0, 0, -handle_length*0.5> <0, 0, handle_length*0.5> handle_rad/2
    }
    cylinder {
      <0, 0, -handle_length*0.5> <0, 0, handle_length*0.5> handle_rad/2
      translate -y
    }
    union {
      object {
        RadiusBox(1, 0.075, handle_rad)
        translate z * -handle_length * 0.45
      }
      object {
        RadiusBox(1, 0.075, handle_rad)
        translate z * handle_length * 0.45
      }
      rotate z * 90
      translate y * -0.5
    }
    translate y * 1
    rotate z * handle_angle
    translate <-0.3, 1.8, 0>
    pigment{ White }
  }
#end

#declare texture_webhook_base = texture {
  pigment { rgb 0.9 }
  finish { F_MetalA }
}

#macro webhook_with_base(handle_angle)
  union {
    union {
      object { webhook_base }
      object { webhook_handle(handle_angle) }
      texture { texture_webhook_base }
    }
    object {
      webhook
      texture {
        pigment { color mysoc_red }
        finish { F_MetalA }
      }
      translate y * 1.5  
    }
  }
#end