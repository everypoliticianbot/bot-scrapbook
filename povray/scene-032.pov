// bot behind HTML (2 layers) from Austian Parlament [sic]

#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);


#macro html_box(html_bitmap, ambient_finish)
  box {
    <0,0,0>,<1,1,0.00001>
    /*
    texture {
      pigment { color rgbt <0, 0, 0, 0.95> }
    }
    */
    texture {
      pigment {
        image_map { png html_bitmap }
      }
      finish { ambient ambient_finish }
    }
    translate <-0.5, -0.5, 0>
    rotate x * 90
    scale 16
    rotate x * -45
  }
#end

// did this as a loop, ended up only needing two (i=0, i=2)
// so cut-and-pasted the object twice instead
#local i = 0;
object { 
  html_box("bitmaps/austria-html-transparent.png", 0.1 * i)
  rotate y * (i - 1) * 8
  translate <0.5 + i, 3 + i * 1.4, 2>
}  
#local i = i + 2;
object { 
  html_box("bitmaps/austria-html-transparent.png", 0.1 * i)
  rotate y * (i - 1) * 8
  translate <0.5 + i, 3 + i * 1.4, 2>
}  

object {
   create_bot(with_textures)
   rotate y * 0
}

light_source { default_light }
light_source { default_flood_light }

background{ Black }

camera {
  location  <0, 3, -6.5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.3
  focal_point <0,1.7, 0>
  look_at   <0,1.7, -1>
}
