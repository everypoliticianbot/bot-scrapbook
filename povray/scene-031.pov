// wikidata

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare whole_scene_y_rotate = -40;

#declare wikidata_clear = rgb 1;
#declare wikidata_red   = rgb  <153,   0,   0> / 255;
#declare wikidata_green = rgbt < 51, 153, 102> / 255;
#declare wikidata_blue  = rgbt <  0, 102, 153> / 255;

#declare wikidata_ambience = 0.15;

#declare wikidata_texture = texture {
  pigment {
    gradient x
    color_map {
      [ 0.00 color wikidata_clear ]
      [ 0.02 color wikidata_clear ]
      [ 0.02 color wikidata_red ]
      [ 0.06 color wikidata_red ]
      [ 0.06 color wikidata_clear ]
      [ 0.10 color wikidata_clear ]
      [ 0.10 color wikidata_red ]
      [ 0.19 color wikidata_red ]
      [ 0.19 color wikidata_clear ]
      [ 0.23 color wikidata_clear ]
      [ 0.23 color wikidata_red ]
      [ 0.32 color wikidata_red ]
      [ 0.32 color wikidata_clear ]
      [ 0.36 color wikidata_clear ]
      [ 0.36 color wikidata_green ]
      [ 0.40 color wikidata_green ]
      [ 0.40 color wikidata_clear ]
      [ 0.44 color wikidata_clear ]
      [ 0.44 color wikidata_green ]
      [ 0.48 color wikidata_green ]
      [ 0.48 color wikidata_clear ]
      [ 0.52 color wikidata_clear ]
      [ 0.52 color wikidata_blue ]
      [ 0.61 color wikidata_blue ]
      [ 0.61 color wikidata_clear ]
      [ 0.65 color wikidata_clear ]
      [ 0.65 color wikidata_blue ]
      [ 0.69 color wikidata_blue ]
      [ 0.69 color wikidata_clear ]
      [ 0.73 color wikidata_clear ]
      [ 0.73 color wikidata_blue ]
      [ 0.82 color wikidata_blue ]
      [ 0.82 color wikidata_clear ]
      [ 0.86 color wikidata_clear ]
      [ 0.86 color wikidata_green ]
      [ 0.90 color wikidata_green ]
      [ 0.90 color wikidata_clear ]
      [ 0.94 color wikidata_clear ]
      [ 0.94 color wikidata_green ]
      [ 0.98 color wikidata_green ]
      [ 0.98 color wikidata_clear ]
      [ 1.00 color wikidata_clear ]
    }
  }
  finish { ambient wikidata_ambience }
}

merge {
  object {
    create_bot(without_textures)
    scale 0.28
    translate z * -0.1
    texture { wikidata_texture translate - x * 0.5}
  }
  box {
    <0,-100, 0> <1,0,100>
    texture { wikidata_texture }
    translate <-0.5, 0, -0.25>
  }
  box {
    <0,0,0>,<1,0.18,100> // 0.18 because only want letters
    texture {
      pigment {
        image_map { png "bitmaps/wikidata-logo-en-alpha.png" }
      }
      finish { ambient wikidata_ambience }
    }
    rotate x * 90
    translate <-0.5, 0, -0.42> // nudge for lettering alignment
  }
  
  rotate y * whole_scene_y_rotate
}

light_source { default_light rotate y * whole_scene_y_rotate}
light_source { default_flood_light }

light_source {
  <-0,20,-70>*100
  colour rgb <1.0, 1.0, 1.0>
  shadowless
}

sky_sphere { default_sky_sphere }

#declare floor_colour = White;
#declare grout_colour = <0.8, 0.8, 0.8>;
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
  translate <0.55, -0.0001, 0>
  scale 1.2
  rotate y * whole_scene_y_rotate
}

camera {
  location  <0, 1.58, -1.8> * 0.95
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.1
  focal_point <0, 0.3, -0.4>

  look_at   <-0.5, 0.2, 0.05>
}
