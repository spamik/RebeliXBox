/* 
   === RebeliX BoX ===

   endstop holder x
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_length = 34;
part_width = 13;
screws_dist = 8;

module endstop_holder_base()
{
  translate([0,0,-10/2 + 3/2]) rounded_box(part_length,part_width,3,3,1,1,1,0);
  translate([0,-part_width/2 + 5/2,0]) rounded_box(part_length,5,10,3,1,1,1,0); 
  translate([-part_length/2 + 8/2,0,10/2]) rounded_box(8,part_width,20,3,0,1,1,0);
}

module endstop_holder_cuts()
{
  // Otvory pro pridelani endstopu
  translate([part_length/2 -4 -screws_dist,0,0]) rotate([90,0,0]) cylinder(d=3,h=40,$fn=16,center=true);
  translate([part_length/2 -4 -screws_dist,40/2 - part_width/2 + 4,0]) rotate([90,0,0]) cylinder(d=6,h=40,$fn=16,center=true);

  translate([part_length/2 - 4,0,0]) rotate([90,0,0]) cylinder(d=3,h=40,$fn=16,center=true);
  translate([part_length/2 - 4,40/2 - part_width/2 + 4,0]) rotate([90,0,0]) cylinder(d=6,h=40,$fn=16,center=true);
}

module endstop_holder_x()
{
  difference()
  {
	endstop_holder_base();
	endstop_holder_cuts();
  }
}

rotate([90,0,0]) 
endstop_holder_x();