#include "textures.inc"

#macro ruby_gemstone()
  #local qty_edges = 10; // qty_edges must > 2
  difference {
    cylinder { -y y*0.25 1 } // 0.25 is top facet of gem
    #local n = 0;
    #while (n < qty_edges)
      union {
        plane { // cut bottom facet of gem
          y 0
          rotate x * 50
          translate -y * 0.5
        }
        plane { // cut top facet of gem
          -y 0
          rotate x * 40
          translate y * 0.5
        }
        rotate y * (n * 360/qty_edges)
      }
      #local n = n + 1;
    #end
    scale 0.5
    material { M_Ruby_Glass }
  }
#end