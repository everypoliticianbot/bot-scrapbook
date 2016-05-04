// lots of reflections here (especially visible in the chain, as it happens)
global_settings { max_trace_level 8 }
 
#include "colors.inc"
#include "everypolitician-bot.inc"
#include "everypolitician-bits.inc"

#declare with_textures = 1;
#declare without_textures = 0;

#declare r1 = seed(0);

#declare platform_width = 1.5;
#declare platform_length = 2.5;
#declare platform_height = 0.1;
#declare hoop_rad = 0.3;
#declare chain_rad = 0.03;

#declare link_width = 0.2;
#declare link_length = 0.15;

// lying flat in the y-plane, across the origin, along the x axis
#declare chain_link =
  union {
    cylinder {
      <-link_length/2, 0,-link_width/2>
      < link_length/2, 0,-link_width/2>
      chain_rad
    }
    cylinder {
      <-link_length/2, 0, link_width/2>
      < link_length/2, 0, link_width/2>
      chain_rad
    }
    difference {
      union {
        torus {
          link_width/2 chain_rad
          translate -x * link_length/2
        }
        torus {
          link_width/2 chain_rad
          translate  x * link_length/2
        }
      }
      box {
        <-link_length/2, -link_width, -link_width>
        < link_length/2, +link_width, +link_width>
      }
    }
  }

#macro straight_chain(qty_links)
  #local i = 0;
  #while (i < qty_links)
    object {
      chain_link
      rotate x * 90
      rotate z * 90
      translate y * (link_length/2 - chain_rad)
      #if (mod(i, 2))
        rotate y * 90
      #end
      translate y * i * (link_length + link_width - chain_rad * 2)
    }
    #local i = i + 1;
  #end
#end

#declare floor_texture =
  texture {
    pigment { rgb < 0.666, 0.666, 0.666 > }
    normal { crackle 0.2 scale 0.1}
  }

#declare ampitheatre_ring = 
  difference {
    cylinder { < 0,0,0> <0,1,0> 2 }
    cylinder { < 0,-0.1,0> <0,1.1,0> 1 }
  }

#macro swing(swing_colour)
  union {
    box {
      < platform_length/2,                0,  platform_width/2>
      <-platform_length/2, -platform_height, -platform_width/2>
      pigment { swing_colour }
      normal { gradient z 0.05 scale <1, 1, 0.4> }
    }
    difference {
      union {
        torus {
          hoop_rad chain_rad
          rotate z * 90
          translate y * chain_rad
          translate -x * (platform_length/2 - chain_rad * 2)
        }
        torus {
          hoop_rad chain_rad
          rotate z * 90
          translate y * chain_rad
          translate  x * (platform_length/2 - chain_rad * 2)
        }
      }
      plane { y 0 }
    }
    union {
      straight_chain(100)
      translate -x * (platform_length/2 - chain_rad * 2)
      translate y * hoop_rad + chain_rad * 2
    }
    union {
      straight_chain(100)
      translate  x * (platform_length/2 - chain_rad * 2)
      translate y * hoop_rad + chain_rad * 2
    }
  
    texture { T_Chrome_3E }
  }
#end

union {
  union {
    object {
       create_bot(with_textures)
       scale 0.8
       rotate y * 39
    }
    object {
      swing( Red )
    }
    translate -y * 6
    rotate x * 25 // swwwwwwwing
    translate y * 6
  }
  object { swing( Green ) translate -x * 4}
  object { swing( Blue ) translate    x * 4}

  rotate -y * 20
  translate y * 0.5
}

#declare ampi_rad = 6;

union {
  cylinder {
    <0,-2,0> <0,-10,0> ampi_rad
  }
  #declare i = 0;
  #while (i < 8)
    object{
      ampitheatre_ring
      scale <ampi_rad + i, 0.333, ampi_rad + i >
      translate y * (i * 0.333 - 2)
    }
    #declare i = i + 1;
  #end
  texture { floor_texture }
}
light_source {<4,5,-3>*1000 colour rgb <1,1,1>}
light_source { default_flood_light }
sky_sphere { default_sky_sphere }

camera {
  location  <0, 6, -7>
  direction <0, 0, 1.5>
  up        <0, 1, 0>
  right     <3, 0, 0>

  blur_samples 128
  aperture 0.5
  focal_point <0,1.8,-2>

  look_at   <0,1.8,-1>
}
