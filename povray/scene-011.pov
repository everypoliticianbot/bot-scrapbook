#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare code_box = 
  box {
    <0,0,0>,<1,1,0.01>
    pigment { image_map { png "bitmaps/countries-json-2.png" } }
    finish { ambient 0.6 }
    translate <-0.5, -0.5, 0>
    rotate x * 90
    scale 20
  }

// code on the floor
object { 
  code_box
  rotate y * -8
  translate z * 4
}

// code off stage right to reflect in the bot (art!)
object { 
  code_box no_shadow
  finish {ambient 1}
  scale 2
  rotate x * -90
  rotate y * 125
  rotate z * 20
  translate <6.5, -4, -6>  
}

object {
   create_bot(with_textures)
   scale 1.4
   rotate y * 45
   translate <1, 0, 0> 
}

light_source { default_light }
light_source { default_flood_light }
// funky green light for the artiness and greeniness
light_source {<-4,8,-2>*1000 colour rgb <0,0.5,0>}

camera {
  location  <0, 8, -4>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.12  // want to be able to read all the code text, so keep it small
  focal_point <0,2,-1>
  look_at   <-0.05,2,0>
}
