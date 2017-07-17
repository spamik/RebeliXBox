/* 
   === RebeliX BoX ===

   pneufit holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_height = M6_washer_D;

// Vyrez v hlinikovem profilu
space = 8.1;

// Tloustka hliniku
profile_thick = 2.2;
holder_length = profile_thick + 4*extrusion_width;

module pneufit_holder_base()
{
  cylinder(d=15,h=part_height,$fn=32,center=true);
  translate([0,15/4,0]) cube([15,15/2,part_height],center=true);
  translate([M6_washer_D/2,15/4,0]) rounded_box(15 + M6_washer_D,15/2,part_height,3,1,0,0,1);
 
  translate([M6_washer_D/2,15/2,0]) rotate([90,0,180]) drazka_vertical(15 + M6_washer_D,0);
}

module pneufit_holder_cuts()
{
  // Otvor pro M6 sroub
  translate([15/2 + M6_washer_D/2,0,0]) rotate([90,0,0]) cylinder(d=M6_screw_D,h=20,$fn=32,center=true);
  
  // Vyrez pro Pneufit
  translate([0,0,part_height/2]) cylinder(d=4.6,h=9,$fn=32,center=true);
  cylinder(d=2.5,h=part_height + 1,$fn=32,center=true);
  
  translate([15/2 + M6_washer_D/2,15/2 + 3/2,0]) cube([profile_nut_W,3,10],center=true);
}

module pneufit_holder()
{
  difference()
  {
	pneufit_holder_base();
	pneufit_holder_cuts();
  }
}

pneufit_holder();


