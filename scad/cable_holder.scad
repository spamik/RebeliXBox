/* 
   === RebeliX BoX ===

   cable holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_width = 13;
part_height = 7;

// Sirka vyrez v hlinikovem profilu
space = 8.1;

// Tloustka hliniku
profile_thick = 2.2;
holder_length = profile_thick + 4*extrusion_width;

module cable_holder_base()
{
  cube([part_width,2*extrusion_width,part_height],center=true);
  translate([-space/2 + extrusion_width,holder_length/2 - extrusion_width,0]) cube([2*extrusion_width,holder_length,part_height],center=true);
	
  translate([space/2 - extrusion_width,holder_length/2 - extrusion_width,0]) cube([2*extrusion_width,holder_length,part_height],center=true);

  translate([-space/2,2*extrusion_width + profile_thick,0]) rotate([0,0,-180]) cube([2.5,2*extrusion_width,part_height],center=true);
	
  translate([space/2,2*extrusion_width + profile_thick,0]) cube([2.5,2*extrusion_width,part_height],center=true);
}

module cable_holder_cuts()
{
  // Seriznuti "pacicek"
  translate([-space/2 - 2*extrusion_width,extrusion_width + profile_thick,-part_height/2 - 1]) rotate([0,0,57]) cube([5,5,part_width],center=false);
  
  translate([space/2 + 2*extrusion_width,extrusion_width + profile_thick,-part_height/2 - 1]) rotate([0,0,33]) cube([5,5,part_width]);
}

module cable_holder()
{
  difference()
  {
	cable_holder_base();
	cable_holder_cuts();
  }
}

cable_holder();