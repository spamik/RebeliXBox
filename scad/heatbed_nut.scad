/* 
   === RebeliX BoX ===

   heatbed nut
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>
	
// Prumer celeho drzadla
base_diameter = 24;
// Prumer zoubku na kole
tooth_diameter = 2.4;
// Prumer valce
body_diameter = 11;
// Vyska dilu
part_height = 21;

module heatbed_nut_base()
{
  cylinder(d=base_diameter,h=4, $fn=32, center=true);
  translate([0,0,part_height/2 + 4/2 - 0.001]) cylinder(d=body_diameter,h=part_height, $fn=32,center=true);
}

module heatbed_nut_cuts()
{
  for ( i = [0 : 30 : 360] )
  {
	rotate([0,0,i])
	{
	  translate([base_diameter/2 + 0.2,0,0]) cylinder(d=tooth_diameter,h=6, $fn=16,center=true);
	}
  }
  
  // Vyrez pro matku sroubu
  translate([0,0,part_height - 3]) nut_hole(1);
  translate([0,0,-part_height/2 + 3]) cylinder(d=M3_screw_D,h=50,$fn=16, center=true);
}

module heatbed_nut()
{
  difference()
  {
	heatbed_nut_base();
	heatbed_nut_cuts();
  }
}

heatbed_nut();