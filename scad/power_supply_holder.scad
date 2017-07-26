/* 
   === RebeliX BoX ===

   power supply holder 24V/350W
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;
M3_screw_offset = 6.5;
M3_screws_distance = 80;

holder_length = 95 + profile_width;
holder_width = profile_width;
holder_base_height = 6;
holder_height = holder_base_height + 10;

module supply_holder_base()
{
  rounded_box(holder_length,holder_width,holder_base_height,6,1,1,1,1);
  
  translate([-holder_length/2 + profile_width/2,0,holder_height/2 - holder_base_height/2])rounded_box(profile_width,holder_width,holder_height,6,1,1,1,1);
  
  translate([-holder_length/2 + profile_width/2,0,-holder_base_height/2 + holder_height]) rotate([0,0,90]) drazka();
}

module supply_holder_cuts()
{
  // Otvory pro M6 srouby
  translate([-holder_length/2 + profile_width/2,0,-holder_base_height/2 + holder_height - M6_screw_offset]) rotate([180,0,0]) screw_hole(1,0,M6_head_D,M6_screw_D);

  // M3 otvory
  translate([-holder_length/2 + profile_width + 9,0,holder_base_height/2 - M3_screw_offset]) rotate([180,0,0]) screw_hole(1);
  
  translate([-holder_length/2 + profile_width + 9 + M3_screws_distance,0,holder_base_height/2 - M3_screw_offset]) rotate([180,0,0]) screw_hole(1);
  
  // Vyrez v drzaku
  translate([-holder_length/2 + profile_width + 9 + 15,0,0]) cylinder(d=holder_width/2,h=30,$fn=32,center=true);
  translate([-holder_length/2 + profile_width + 9 + M3_screws_distance - 15,0,0]) cylinder(d=holder_width/2,h=30,$fn=32,center=true);
  translate([15 + M3_screw_D/2,0,0]) cube([M3_screws_distance - 30,holder_width/2,30],center=true); 
}

module supply_holder()
{
  difference()
  {
    supply_holder_base();
	supply_holder_cuts();
  }
}

supply_holder();