#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare tunnel_rad = 6;
#declare tunnel_length = 50;

difference{
  cylinder { z * tunnel_length  z * -tunnel_length tunnel_rad * 1.1 }
  cylinder { z * tunnel_length * 1.1  z * -tunnel_length * 1.1 tunnel_rad * 1 }
  #declare i = -tunnel_length;
  #while (i < tunnel_length)
    torus {
      tunnel_rad 0.1
      rotate x * 90
      translate z * i
    }
    #declare i = i + 6;
  #end
  pigment { White }
  translate y * 2
}

box { // floor, does not extend beyond end of tunnel
  <-tunnel_length, -tunnel_length, -tunnel_length> <tunnel_length, 0, tunnel_length>
  pigment { White }  
  normal { bumps 0.02 scale 0.1 }
  finish { ambient 0.1}
}

object {
   create_bot(with_textures)
   scale 1.2
   translate <-0.5, 0, 30>
}

sky_sphere { // mere tint of blue in the light at the end of the tunnel
  pigment {
    gradient y
    color_map {
      [ 0.4  color White ]
      [ 1.0  color Blue ]
    }
    scale 2
    translate -1
  }
}

#declare light_location = <-tunnel_rad * 0.9, 2, tunnel_length * 1.1>;

light_source {
  light_location
  White
  area_light <0.01, 0, 0> * light_location <0, 0, 0.01> * light_location, 6, 6 jitter
}

camera {
  location  <-tunnel_rad * 0.9, 2, -10>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  sky <0.05, 1, 0>
  look_at   <18,1.7, 30>
}
