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

part_upper_cut = 6;
part_lower_cut = 5;

part_depth = big_bearing_OUT_D + 10;
//part_depth = motor_width;
part_height = profile_width - part_upper_cut - part_lower_cut;

/* ----- Lead nut holder ------- */
nut_offset = 38.5 + mount_dia/2 - part_depth/2; 
leadscrew_offset = 10;

D_leadscrew = 22 + 2*0.6; 
D_coupler = 26;

part_width = D_coupler + 2*M6_washer_D;

module z_nut_holder_base(mount_offset = 0)
{
  hull()
  {
    translate([0,nut_offset,0]) cylinder(d=D_leadscrew,h=part_height,$fn=64,center=true);
    translate([0,20/2,0]) cube([part_width,20,part_height],center=true);
  }	
  
  // Drazka pro profil
  translate([0,0,mount_offset - profile_width/2 + part_upper_cut + part_height/2]) rotate([-90,0,180]) drazka_vertical(part_width,2);
}

module z_nut_holder_cuts(mount_offset = 0)
{ 
  // Otvor pro M6 srouby
  translate([part_width/4 + D_coupler/4,M6_screw_offset,mount_offset - profile_width/2 + part_upper_cut + part_height/2]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([part_width - (part_width - D_coupler)/4,part_width/2 + M6_screw_offset,-part_width/2 + mount_offset - profile_width/2 + part_upper_cut + part_height/2  + M6_head_D/2]) cube([part_width,part_width,part_width],center=true);
  
  translate([part_width - (part_width - D_coupler)/4 - M6_head_D/2,part_width/2 + M6_screw_offset,-part_width/2 + mount_offset - profile_width/2 + part_upper_cut + part_height/2]) cube([part_width,part_width,part_width],center=true);
  
  translate([-part_width/4 - D_coupler/4,M6_screw_offset,mount_offset - profile_width/2 + part_upper_cut + part_height/2]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([-part_width + (part_width - D_coupler)/4,part_width/2 + M6_screw_offset,-part_width/2 + mount_offset - profile_width/2 + part_upper_cut + part_height/2  + M6_head_D/2]) cube([part_width,part_width,part_width],center=true);
  
  translate([-part_width + (part_width - D_coupler)/4 + M6_head_D/2,part_width/2 + M6_screw_offset,-part_width/2 + mount_offset - profile_width/2 + part_upper_cut + part_height/2]) cube([part_width,part_width,part_width],center=true);
  
  // Trapezova matka
  translate([0,nut_offset,part_height/2 - leadscrew_offset]) leadscrew_nut();
  //translate([0,nut_offset,part_height/2 - 30/2 - 4]) cylinder(d=15,h=30,$fn=32,center=true);

  // Vrez pro coupler
  translate([0,nut_offset + D_coupler/2 + 4,part_height/2 - leadscrew_offset - part_height/2]) cube([part_width,D_coupler,part_height],center=true);
  
  // Vyrez pro sroub od HB
  translate([0,10,part_height/2]) rounded_box(15,14,60,6,1,1,1,1); 
  translate([0,12,-part_height/2]) rounded_box(20,30,5,6,1,1,1,1); 
}

module z_nut_holder()
{
  difference()
  {
	z_nut_holder_base();
	z_nut_holder_cuts();
  }
}

rotate([0,180,0]) 
z_nut_holder();