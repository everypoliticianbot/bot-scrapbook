#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

global_settings {
  max_trace_level 8
  photons {
    count 20000
    autostop 0
    jitter .4
  }
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

#declare mirror_width = 2;
#declare mirror_height = 4; // tall even though robot is short
#declare mirror_frame_thickness = 0.2;

union { // mirror
  box {
    <0,0,0> <mirror_width, mirror_height, mirror_frame_thickness/3>
    texture { T_Chrome_3E }
    photons{ target reflection on }
  }
  difference {
    box {
      <-mirror_frame_thickness,-mirror_frame_thickness,-mirror_frame_thickness>
      <mirror_width+mirror_frame_thickness,
       mirror_height+mirror_frame_thickness, mirror_frame_thickness>
    }
    box {
      <0,0,-1> <mirror_width, mirror_height, 1>
    }
  }
  // stand
  box {
    <-mirror_frame_thickness/2, -mirror_frame_thickness, -1>
    <mirror_frame_thickness/2, -mirror_frame_thickness*1.5, 1>
  }
  box {
    <-mirror_frame_thickness/2, -mirror_frame_thickness, -1>
    <mirror_frame_thickness/2, -mirror_frame_thickness*1.5, 1>
    translate x * (mirror_width - mirror_frame_thickness)
  }
  pigment{ White }
  translate -x * ((mirror_width+mirror_frame_thickness) / 2)
  rotate y * 23 // angled to reflect bot like an artist would
  translate <0, 0.5, 4>
  rotate -y * 95
}

object {
   create_bot(with_textures)
   photons{ target reflection on }
   rotate y * -90 // switch to +90 to face mirror (scene-009a)
}

#declare light_location = < 6, 7, 1>;
light_source {
	light_location
	rgb <1.000000, 1.000000, 1.000000>
	spotlight
 	point_at < 0.0, 0.0, 0.0>
	radius 15
	falloff 30
	tightness 10
  area_light <0.05, 0, 0> * light_location <0, 0, 0.05> * light_location, 4, 2
}

camera {
  location  <5, 4, -4>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <1,2,0>
}
