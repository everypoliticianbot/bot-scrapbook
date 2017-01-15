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
   rotate y * 30
   scale 0.8
   translate <5,0,-2.7>
}

box {
  <0,0,0>,<1,1,0.01>
  pigment { image_map { jpeg "bitmaps/old-swiss-map.jpg" } }
  finish { ambient 0.3 }
  translate <-0.5, -0.5, 0>
  rotate x * 90
  scale 30
}


light_source { default_light rotate y * -90 translate -y * 10}
light_source { default_flood_light }

background{ White }

camera {
  location  <3, 4.1, -6.5> * 1.5
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <2.1, 0, -3>
}
