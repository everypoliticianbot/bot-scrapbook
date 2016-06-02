// many, many rainbow bots (actually mySociety colours, of course)
// note this is an orthographic projection
// one bot is the textured bot

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare half_bot_height = 1.9;

#declare botx = -4;
#declare boty = 1;

#declare spacer = 3.8;
#declare i = -20;
union {
  #while (i < 20)
    #declare j = -10;
    #while (j < 10)
      object {
        #if (i = botx & j = boty)
          create_bot(with_textures)
        #else
          create_bot(without_textures)
          pigment {
            mysoc_colours[floor(rand(r1) * 7)]
          }
        #end
  
        translate y * -half_bot_height
        #if (mod(i + j, 2) = 0)
          rotate z * 45
        #else 
          rotate z * -45
        #end
        translate y * half_bot_height
        
        translate <i * spacer * 1.1, j * spacer, 0>
      }
      #declare j = j + 1;
    #end
    #declare i = i + 1;
  #end
  scale 0.05
}

light_source { default_light }
light_source { default_flood_light }

background { White }

camera {
  orthographic
  location  <0, 0, -10>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  look_at   <0,0, 0>
}
