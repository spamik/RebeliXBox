/* 
   === RebeliX BoX ===

   corner coupler
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

module drazka()
{
  distance = M6_screw_D >= profile_nut_W ? M6_screw_D : profile_nut_W;
  
  translate([-30/2+4,0,0]) cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([-distance/2-4,0,0]) cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([-distance/4 - 7.5,0,0]) cube([7 - distance/2,8,coupler_thickness+1.5],center=true);
	
  translate([30/2-4,0,0])cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([distance/2+4,0,0])cylinder(r=4,h=coupler_thickness+1.5,$fn=32,center=true);
  translate([distance/4 + 7.5,0,0]) cube([7 - distance/2,8,coupler_thickness+1.5],center=true);
}

module corner_coupler()
{
  difference()
  {
	union()
	{
	  cube([60,30,coupler_thickness]);
	  translate([15,30/2,(coupler_thickness+1.5)/2]) rotate([0,0,90]) drazka();
	  translate([45,30/2,(coupler_thickness+1.5)/2]) drazka();
	}
		
	// Otvory pro srouby
	translate([15,30/2,0])cylinder(h=20,d=M6_screw_D,$fn=32,center=true);
	translate([45,30/2,0])cylinder(h=20,d=M6_screw_D,$fn=32,center=true);
		
	// Zalomene hrany
	translate([-1,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([61,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([-0.1,-1,-5]) rotate([45,0,0]) cube([70,5,5]);
	translate([-0.1,31,-5]) rotate([45,0,0]) cube([70,5,5]);
  }
}

corner_coupler();
