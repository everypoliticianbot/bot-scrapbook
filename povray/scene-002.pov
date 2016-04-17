#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare busy_green = <0.26, 0.63, 0.25>;

#declare cube_size = 0.26;
#declare greencube =
  box {
   <-0.5,0,-0.5><0.5,1,0.5>
   scale cube_size
    pigment { rgb busy_green }
  }

#macro pile_of_cubes(quantity)
  #local i = 0;
  #local xi = 0; 
  #local zi = 0;
  #while (i < quantity)
    object {
      greencube 
      rotate y * rand(r1) * 90
      #if (rand(r1) > 0.5)
        #local xi = xi + cube_size + cube_size * rand(r1) * 2;
      #else 
        #local xi = xi - cube_size + cube_size * rand(r1) * 2;
      #end
      #if (rand(r1) > 0.5)
        #local zi = zi + cube_size + cube_size * rand(r1) * 2;
      #else 
        #local zi = zi - cube_size + cube_size * rand(r1) * 2;
      #end
      translate <xi, 0, zi> 
    }
    #local xi = xi + cube_size;
    #local zi = zi + cube_size;
    #local i = i + 1;
  #end
#end

union { 
  // union because cheekily we're spinning the whole thing for the camera

  union {
    pile_of_cubes(10)
    rotate y * 30
    translate <3, 0, 6>
  }

  union {
    pile_of_cubes(10)
    rotate y * 30
    translate <-10, 0, -3>
  }

  plane {
    y 0
    texture {
      pigment { White }
      finish { ambient 0.333 }
    }
    texture {
      pigment {
        image_map { png "bitmaps/github-activity.png" once } 
        rotate x * 90
      }
      translate -x * 0.5
      scale 18
      finish { ambient 0.333 }
    }
  }
  
  object {
    create_bot(with_textures)
    scale 0.8
    rotate -y * 70
    translate <-1.2, 0, 1.75>
  }
  
  rotate y * 30
  translate <-3, 0, -2>
  
}

sky_sphere { default_sky_sphere }
light_source {
  <-8,5,1>*1000
  colour rgb <1,1,1>
  area_light
  <4, 0, 0> <0, 0, 4> 8, 8
  adaptive 0 jitter
}
light_source { default_flood_light }

camera {
  location  <-1, 7, -5>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.1
  focal_point <0, 3, 0>
  look_at   <0,0,0>
}
