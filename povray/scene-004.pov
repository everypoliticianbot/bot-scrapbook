#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

object {
   create_bot(with_textures)
   rotate y * 45
   translate x * 2
}

plane {
  y 0
  pigment {
    checker
    pigment { image_map { png "bitmaps/mysociety-logo-circles-faded.png"} }
    pigment { image_map { png "bitmaps/github-mark-grey.png" } }
    rotate x * 90
    scale 4
  }
}

// crazy lovely sky sphere (bonkers colours with turbulence)
sky_sphere {
  pigment {
    gradient y
    color_map {
      [ 0.1  color rgb < 1.0, 0.1, 0.4 > ] 
      [ 0.6  color CornflowerBlue ]
    }
    turbulence 0.5
    scale 2
    translate -1
  }
}

light_source { default_light }
light_source { default_flood_light }

camera {
  location  <0, 0.3, -6>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky <-0.1, 1, 0>
  blur_samples 128
  aperture 0.2
  focal_point <0,1,-1>
  look_at   <0,1.5,0>
}
