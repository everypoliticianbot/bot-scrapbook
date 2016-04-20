#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

// crazy lovely sky sphere (bonkers colours with turbulence)
sky_sphere {
  pigment {
    gradient y
    color_map {
      [ 0.1 color rgb <0,0,0> ]
      [ 0.2  color rgb < 1.0, 0.1, 0.4 > ] 
      [ 0.4  color CornflowerBlue ]
      [ 1.0 color rgb <0,0,0> ]
    }
    turbulence 0.2
    scale 2
    translate -1
  }
}
#declare screen_depth = 0.05;
#declare screen_height = 1;
#declare screen_width = 1;
#declare strut_rad = 0.05;
#declare major_rad = 5;
#declare elevation_step_degrees = 15;
#declare platform_height = 0.5;

#declare j = -3;
#while (j < 3)
  #declare i = 0;
  #while (i < 270)
    union {
      // screen
      box {
        <0,0,0> <screen_width, screen_height, screen_depth>
        #local channel = int(rand(r1) * 3);
        #switch (channel)
          #case (1)
            texture {
              pigment { image_map { png "bitmaps/github-mark-grey.png" } }
              finish { ambient 0.6 }
            }
          #break
          #case (2)
            texture {
              pigment { image_map { png "bitmaps/mysociety-logo-circles-faded.png" } }
              finish { ambient 0.6 }
            }
          #break
        #else
          pigment { Black }
        #end
        translate <-screen_width/2,-screen_height/2,0>

      }
      cylinder { <-screen_width/2, -screen_height/2, 0>  <screen_width/2, -screen_height/2, 0> strut_rad }
      cylinder { <-screen_width/2, screen_height/2, 0>  <screen_width/2, screen_height/2, 0> strut_rad }
      cylinder { <-screen_width/2, -screen_height/2, 0>  <-screen_width/2, screen_height/2, 0> strut_rad }
      cylinder { <screen_width/2, -screen_height/2, 0>  <screen_width/2, screen_height/2, 0> strut_rad }
      sphere {  <-screen_width/2, -screen_height/2, 0> strut_rad }
      sphere {  <screen_width/2, -screen_height/2, 0> strut_rad }
      sphere {  <-screen_width/2, screen_height/2, 0> strut_rad }
      sphere {  <screen_width/2, screen_height/2, 0> strut_rad }
      translate z * (major_rad - strut_rad * 2)
      rotate x * elevation_step_degrees * j
      rotate y * (-120 + i)
      texture { T_Chrome_3C }
    }
    #declare i = i + 20;
  #end
  difference { // cutting out struts behind
    torus {
      // when someone says "I never used the trig they taught me at school"...
      // what they really means is "I've never used POV-Ray"
      // There are very few things more satisfying than getting this sort of thing right FIRST TIME *
      major_rad * cos(radians(elevation_step_degrees * j)) strut_rad
      translate y * sin(radians(elevation_step_degrees * j)) * major_rad
    }
    box {
      <0,-10,0><10,10,10> rotate y * 135
    }
    texture { T_Chrome_3C }
  }
  #declare j = j + 1;
#end

// platform to stand on
union {
  box {
    <-0.5, -100, -100> <0.5, 0, 0>
  }
  cylinder {
    <0,-100, 0>  <0,0, 0> 1
  }
  // fancy rounded edges to the platform
  union {
    torus { 1 strut_rad }
    cylinder { <-0.5, 0, -100> <-0.5, 0, 0> strut_rad }
    cylinder { < 0.5, 0, -100> < 0.5, 0, 0> strut_rad }
    translate -y * strut_rad
  }
  scale 1.333
  texture { texture_none }
  translate y * platform_height
}

object {
   create_bot(with_textures)
   scale 0.5
   rotate y * 70
   translate <-0.666, platform_height, -0.4>
}

light_source {<-2,4,-0>*1000 colour rgb <1,1,1>}

light_source { default_flood_light }

camera {
  location  <1, 3, -5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.2
  focal_point <0,1,-1>
  look_at   <0,1,0>
  rotate y * 40
}

// * yeah well not exactly first time, but still
