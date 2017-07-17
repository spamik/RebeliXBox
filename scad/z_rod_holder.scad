/* 
   === RebeliX BoX ===

   z rod holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_width = profile_width;

// Radius zakulacenych rohu
corner_rad = 4;

module Z_rod_holder_base()
{
  translate([-profile_width/2 + corner_rad/2,0,0]) rounded_box(profile_width + corner_rad,part_width,coupler_thickness,corner_rad,1,1,1,1);
	  
  hull()
  {
	translate([corner_rad/2,-part_width/2 + corner_rad/2,coupler_thickness/2]) cylinder(d=corner_rad,h=10,$fn=16,center=true);
	  
	translate([corner_rad/2,part_width/2 - corner_rad/2,coupler_thickness/2]) cylinder(d=corner_rad,h=10,$fn=16,center=true);
	  
	translate([rod_offset,0,coupler_thickness/2]) cylinder(d=rod_D + 10,h=10,$fn=64,center=true);
  }
	  
  translate([-profile_width/2,0,coupler_thickness/2]) rotate([0,0,90]) drazka();
}

module Z_rod_holder_cuts()
{
  z_rod_offset = coupler_thickness - 2.5;
  
  // Otvor pro sroub
  translate([-profile_width/2,0,0])cylinder(d=M6_screw_D,h=20,$fn=32,center=true);
  
  // Otvor pro hlazenou tyc
  translate([rod_offset,0,-coupler_thickness/2 + 50/2 + z_rod_offset]) cylinder(d=rod_D,h=50,$fn=64,center=true);
	
  translate([rod_offset + rod_D/2,0,-coupler_thickness/2 + 10/2 + z_rod_offset]) cube([10,1,10],center=true);
}

module Z_rod_holder()
{
  difference()
  {
	Z_rod_holder_base();
	Z_rod_holder_cuts();
  }
}

// Drzak vodici tyce
translate([0,-part_width/2 - 1,0]) Z_rod_holder();
translate([0,part_width/2 + 1,0]) Z_rod_holder();
