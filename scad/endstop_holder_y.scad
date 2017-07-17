/* 
   === RebeliX BoX ===

   endstop holder y
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Radius zakulacenych rohu
corner_rad = 3;

module endstop_holder_base(holder_length = 17.5)
{
  rounded_box(18 + 5,5,profile_width - 10,corner_rad,0,0,1,0);
  
  translate([-(18 + 5)/2 + 5/2,- 5/2 + holder_length/2,0])  rounded_box(5,holder_length,profile_width - 10,corner_rad - 1,0,0,1,0);
  
  // Drazka pro pridelani do profilu
  translate([0,-5/2,0]) cube([18 + 5,3,8],center=true);
}

module endstop_holder_cuts()
{  
  // M6 sroub
  translate([(18 + 5)/2 - 18/2,0,0]) rotate([90,0,0]) cylinder(d=M6_screw_D, h=20, $fn=32, center=true);
  // Seriznuti pro lehci tisk
  translate([-(18+5)/2 - 0.01,-5/2,-8/2]) rotate([90 + 30,0,0]) cube([18+5 + 1,3,8]);
  // Vyrez pro profilovou matku
  translate([(18 + 5)/2 - 18/2,-5/2 - 3/2,0])  cube([profile_nut_W,3,10],center=true);
}

module endstop_holder_y(holder_length)
{
  difference()
  {
	endstop_holder_base(holder_length);
    endstop_holder_cuts();
  } 
}

endstop_holder_y(17.5);