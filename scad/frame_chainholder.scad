/* 
   === RebeliX BoX ===

   y endstop holder and activator
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Radius zakulacenych rohu
corner_rad = 3;

module frame_chainholder_base(holder_length = 24.6)
{
  rounded_box(18 + 5,5,profile_width - 10,corner_rad,0,0,1,0);
  
  translate([-(18 + 5)/2 + 5/2,- 5/2 + holder_length/2,0])  rounded_box(5,holder_length,profile_width - 10,corner_rad - 1,0,0,1,0);
  
  // Drazka pro pridelani do profilu
  translate([0,-5/2,0]) cube([18 + 5,3,8],center=true);
}

module frame_chainholder_cuts()
{  
  // M6 sroub
  translate([(18 + 5)/2 - 18/2,0,0]) rotate([90,0,0]) cylinder(d=M6_screw_D, h=20, $fn=32, center=true);
  // Seriznuti pro lehci tisk
  translate([-(18+5)/2 - 0.01,-5/2,-8/2]) rotate([90 + 30,0,0]) cube([18+5 + 1,3,8]);
  // Vyrez pro profilovou matku
  translate([(18 + 5)/2 - 18/2,-5/2 - 3/2,0])  cube([profile_nut_W,3,10],center=true);
  // srouby na pridelani retezu
  translate([0, 12, -5]) rotate(a=[0, 90, 0]) cylinder(d=M2_screw_D, h=100, center=true, $fn=100);
  translate([0, 12,  5]) rotate(a=[0, 90, 0]) cylinder(d=M2_screw_D, h=100, center=true, $fn=100);
  // otvory na matky
  translate([18/-2+5/2, 12, -5]) rotate(a=[0, 90, 0]) cylinder(d=M2_nut_D, h=2*M2_nut_H, center=true, $fn=6);
  translate([18/-2+5/2, 12, 5]) rotate(a=[0, 90, 0]) cylinder(d=M2_nut_D, h=2*M2_nut_H, center=true, $fn=6);


}


module frame_chainholder(holder_length)
{
  difference()
  {
	frame_chainholder_base(holder_length);
    frame_chainholder_cuts();
  } 
}


frame_chainholder(24.6);