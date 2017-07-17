/* 
   === RebeliX BoX ===

   z lead nut holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Zapusteni sroubu
M6_screw_offset = M6x14_offset;

part_depth = big_bearing_OUT_D + 10;
part_height = profile_width;

/* ----- Lead nut holder ------- */
nut_offset = 38.5 + mount_dia/2 - part_depth/2; 
D_leadscrew = 22 + 2*0.6; 

part_width = D_leadscrew + 2*M6_washer_D;

module nut_holder_base(mount_offset = 5)
{
  hull()
  {
    translate([0,nut_offset,0]) cylinder(d=D_leadscrew,h=part_height,$fn=64,center=true);
    translate([0,corner_rad/2,0]) cube([part_width,corner_rad,part_height],center=true);
  }	
  
  // Drazka pro profil
  translate([0,0,mount_offset]) rotate([-90,180,180]) drazka_vertical(part_width,2);
}

module nut_holder_cuts(mount_offset = 5)
{
  // seriznuti pro trapezovou matka
  top_cut = 6 ;
  
  translate([0,nut_offset,part_height/2]) cylinder(d=big_bearing_OUT_D + 8, h = 2*top_cut,$fn=64,center=true); 
  translate([0,nut_offset + 5,part_height/2]) cube([big_bearing_OUT_D + 8,big_bearing_OUT_D + 8,2*top_cut],center=true);
  
  // Otvor pro M6 srouby
  translate([part_width/2 - M6_washer_D/2,M6_screw_offset,mount_offset]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([part_width/2 - M6_washer_D/2 + part_width/2 - M6_head_D/2,part_width/2 + M6_screw_offset,part_width/2 + mount_offset]) cube([part_width,part_width,part_width],center=true);
  
  translate([part_width/2 - M6_washer_D/2 + part_width/2,part_width/2 + M6_screw_offset,part_width/2  - M6_head_D/2 + mount_offset]) cube([part_width,part_width,part_width],center=true);
  
  translate([-part_width/2 + M6_washer_D/2,M6_screw_offset,mount_offset]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([-part_width/2 + M6_washer_D/2 - part_width/2 + M6_head_D/2,part_width/2 + M6_screw_offset,part_width/2 + mount_offset]) cube([part_width,part_width,part_width],center=true);
  
  translate([-part_width/2 + M6_washer_D/2 - part_width/2,part_width/2 + M6_screw_offset,part_width/2  - M6_head_D/2 + mount_offset]) cube([part_width,part_width,part_width],center=true);

  // Trapezova matka
  translate([0,nut_offset,-part_height/2]) leadscrew_nut();
  
  translate([0,nut_offset,part_height/2]) cylinder(d=18,h=30,$fn=64,center=true);
  
  // Vyrez pro sroub od HB
  translate([-3,10,part_height/2 + 9]) cylinder(d=8,h=part_height,$fn=32,center=true);
  translate([3,10,part_height/2 + 9]) cylinder(d=8,h=part_height,$fn=32,center=true);
  translate([0,0,part_height/2 + 9]) cube([6,20 + 8,part_height],center=true);
  translate([0,0,part_height/2 + 9]) cube([8 + 6,20,part_height],center=true);  
}

module nut_holder()
{
  difference()
  {
	nut_holder_base();
	nut_holder_cuts();
  }
}

nut_holder();