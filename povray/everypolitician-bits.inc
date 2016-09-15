// POV-Ray definition of bits for everypoliticianbot scenes
//---------------------------------------------------------
//

#declare default_light =
  light_source {<4,5,-4>*1000 colour rgb <1,1,1>}

#declare default_flood_light =
  light_source {
    <-20,20,-70>*1000
    colour rgb <0.6, 0.6, 0.6>
    shadowless
  }

#declare look_at_target = <0, 2, 0>;

#declare camera_3_by_1 =
  camera {
    location  <-1, 4, -8>
    direction <0, 0, 1.5>
    up        <0, 1, 0>
    right     <3, 0, 0>
    look_at   look_at_target
  }

#declare camera_3_by_1_focal_blur =
  camera {
    location  <-1, 4, -8>
    direction <0, 0, 1.5>
    up        <0, 1, 0>
    right     <3, 0, 0>
    blur_samples 128
    aperture 0.5
    focal_point look_at_target
    look_at   look_at_target
  }
  
#declare camera_1_by_1 =
  camera {
    location  <-1, 4, -8>
    direction <0, 0, 1.5>
    up        <0, 1, 0>
    right     <1, 0, 0>
    look_at   look_at_target
  }

// sky sphere because bot metal is reflective:
// http://shakespeare.sayit.mysociety.org/julius-caesar/act-i/scene-ii-a-public-place#s536789
// so probably best to have it in every scene

#declare default_sky_sphere =
  sky_sphere {
    pigment {
      gradient y
      color_map {
        [ 0.5  color CornflowerBlue ]
        [ 1.0  color MidnightBlue ]
      }
      scale 2
      translate -1
    }
  }


#macro debug_axes()
  #local axis_end = 1000;
  #local axis_rad = 0.01;
  union {
    cylinder {-y * axis_end y * axis_end axis_rad}
    cylinder {-y * axis_end y * axis_end axis_rad rotate <90, 0, 0>}
    cylinder {-y * axis_end y * axis_end axis_rad rotate <90, 90, 0>}
    pigment { checker  Red, Yellow  }
    finish { ambient 0.666 }
  }
#end

 