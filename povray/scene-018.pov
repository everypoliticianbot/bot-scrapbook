#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare floor_colour = rgb <0.5, 0.5, 0.7>;

#declare xmax = 10;
#declare zmax = 10;
#declare xi = -10;
#declare zmin = -4;

#declare botx = 1;
#declare botz = 0;

#declare turned_botx = -2;
#declare turned_botz = -1;

union {
  #while (xi < xmax)
    #declare zi = zmin;
    #while (zi < zmax)
      // #debug concat("xi=", str(xi,3,0), ", zi=", str(zi,3,0), "\n")
      object {
         #local want_textures = without_textures;
         #if (xi = botx & zi = botz)
           #local want_textures = with_textures;
         #end
         create_bot(want_textures)
         #if (xi = turned_botx & zi = turned_botz)
           rotate y * -120
         #end
         translate <xi, 0, zi + mod(xi,2)/2> * 3
         #if (want_textures = with_textures)
           translate y * 0.5
         #end
      }
      #declare zi = zi + 1;
    #end
    #declare xi = xi + 1;
  #end
  rotate y * 25
}

plane { y 0 pigment {floor_colour}}
sky_sphere { default_sky_sphere }
light_source { default_light }
light_source { default_flood_light }
light_source { <-50,100,-100> Blue }

camera {
  location  <0, 10, -12>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.5
  focal_point <0, 1, -1>
  look_at   <0,1.7, 0>
}
