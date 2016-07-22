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

object {
   create_bot(with_textures)
   rotate y * -25
   translate z * -2
}

light_source { default_light }
light_source { default_flood_light }

background{ White }

plane {
  y 0
  pigment {
    image_map { png "bitmaps/TwitterLogo.png" once }
    translate <-0.5, -0.5, -0.5>
    scale <10, 10, 10>
    translate z * 2
    rotate x * 90
  }
  
}


camera {
  location  <0, 5, -6.5> * 1.4
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <0,0, -1.25>
}
