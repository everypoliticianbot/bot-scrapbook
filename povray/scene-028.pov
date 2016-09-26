// hook

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#include "webhook.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

webhook_with_base(35)

object {
   create_bot(with_textures)
   rotate y * -70
   translate -x * 3.5
}

light_source { default_light }
light_source { default_flood_light }

// sky_sphere { default_sky_sphere }
background{ White }

camera {
  location  <4 , 3, -11>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <4.75, 1, 0>
}
