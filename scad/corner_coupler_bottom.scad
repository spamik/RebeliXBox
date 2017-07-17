/* 
   === RebeliX BoX ===

   corner coupler bottom
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Prumer pristrojove gumove nozicky
rubber_feet_D = 20;

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

module corner_coupler_bottom()
{
  difference()
  {
	union()
	{
	  cube([60,30,coupler_thickness]);
	  translate([15,30/2,(coupler_thickness+1.5)/2]) rotate([0,0,90]) drazka();
	  translate([45,30/2,(coupler_thickness+1.5)/2]) drazka();
	  translate([15,15-9-rubber_feet_D/2,0]) cylinder(d=rubber_feet_D,h=coupler_thickness,$fn=64);
	  translate([15,15-9,coupler_thickness/2]) cube([rubber_feet_D,rubber_feet_D,coupler_thickness],center=true);
	}
		
	// Otvory pro srouby
	translate([15,30/2,0])cylinder(h=20,d=M6_screw_D,$fn=32,center=true);
	translate([45,30/2,0])cylinder(h=20,d=M6_screw_D,$fn=32,center=true);
	translate([15,15-9-rubber_feet_D/2,0]) cylinder(r=1.5,h=20,$fn=16,center=true);
		
	// Zalomene hrany
	translate([-1,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([61,-0.1,-5]) rotate([0,-45,0]) cube([5,40,5]);
	translate([15+rubber_feet_D/2,-1,-5]) rotate([45,0,0]) cube([70,5,5]);
	translate([15-rubber_feet_D/2,-1,-5]) rotate([45,0,180]) cube([70,5,5]);
	translate([-0.1,31,-5]) rotate([45,0,0]) cube([70,5,5]);
  }
}

corner_coupler_bottom();
translate([0,65,0]) mirror([0,1,0]) corner_coupler_bottom();