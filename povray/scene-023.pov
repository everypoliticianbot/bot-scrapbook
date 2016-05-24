// bot on glass path with red ground fog

#include "colors.inc"

#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare databox =
  box {
    <0,0,0>, <1,1,1>
    texture {
      pigment { image_map { png "bitmaps/github-mark-grey.png" } }
    }
    translate <-0.5, 0, -0.5>
  }

#macro tower_of_boxes(qty_boxes)
  union {
    #local b = -100;
    #while (b < qty_boxes)
      object {
        databox
        translate y * b * 1.05 // slight gap 
        #if (rand(r1) < 0.5)
          rotate y * -90
        #end
        rotate y * (rand(r1)-0.5) * 20
      }
      #local b = b + 1;
    #end
  }
#end

#declare tower_width = 1;
#declare tower_height = 2;

#declare i = -10;
#while (i < 10)
  #declare j = -2;
  #while (j < 10)
    object {
      tower_of_boxes(tower_height + floor(rand(r1) * 10) )
      rotate y * -45
      translate <2 + i * 6, 0, 2 + j * 6>
    }
    #declare j = j + 1;
  #end
  #declare i = i + 1;
#end

#declare basic_fog = 1; 
#declare ground_mist= 2; 

#declare path_width = 3.2;
union {
  box {
    <-path_width/2,0,1000> <path_width/2,0.1,-100>
    pigment { White filter 0.95 }
    interior{
       ior 1.45
       fade_distance 2
       fade_power 2
       caustics 2.0
    }
    finish {
       ambient 0.2
       diffuse 0.0
       reflection 0.12
       specular 1.0
       roughness 0.001
    }
  }
  union {
    cylinder { <-path_width/2,0,1000> <-path_width/2,0,-100> 0.15 }
    cylinder { < path_width/2,0,1000> < path_width/2,0,-100> 0.15 }
    texture { T_Chrome_3C }
  }
  object {
     create_bot(with_textures)
     rotate y * 0
     scale 1.5
  }
  translate <-1, 1, -2.5>
}

fog{ 
  fog_type ground_mist 
  fog_alt 3  // how fast does fog fade away?
  fog_offset 0 // y height below which it's constant
  distance 8 // close to zero is very dense
  color Red 
  turbulence <0.05, 0.8, 0.05> 
  omega 0.25 
  lambda 2.5 
  octaves 6 
} 

light_source { default_light }
light_source { default_flood_light }

background{ White }

camera {
  location  <-2, 8, -20>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>
  blur_samples 128
  aperture 0.5
  focal_point <0, 3, -2>
  look_at   <0,1.7, 0>
}
