/* 
   === RebeliX BoX ===

   x endstop holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_length = 25;
part_width = chain_mount_W + 2*mantinel_W;
part_height = 12;
mount_screws_dist = 8;
endstop_screws_dist = 10;

module x_endstop_holder_base()
{
  translate([0,part_length/2 - 6/2,0]) rounded_box(part_width,6,part_height,2,1,0,0,1);
  translate([part_width/4+19/2,0,-part_height/2 + 4/2]) rounded_box(part_width/2+19,part_length,4,2,1,1,1,1);
}

module x_endstop_holder_cuts()
{
  // Otvory pro pridelani na x_carriage_motor.
  for(i=[-1,1])
  {
    translate([i*mount_screws_dist/2,0,part_height/2 - 5]) rotate([90,0,0]) cylinder(d=3,h=40,$fn=16,center=true);
  
    translate([i*mount_screws_dist/2,-40/2 + part_length/2 - 4,part_height/2 - 5]) rotate([90,0,0]) cylinder(d=6,h=40,$fn=16,center=true);
  }

  // Otvory pro pridelani endstopu  
  translate([part_width/2 - 8 + 5+19,-part_length/2 + 5,0]) rotate([0,0,0]) cylinder(d=2,h=40,$fn=16,center=true);
  
  translate([part_width/2 - 8 + 5+19,-part_length/2 + 5 + endstop_screws_dist,0]) rotate([0,0,0]) cylinder(d=2,h=40,$fn=16,center=true);
}

module x_endstop_holder()
{
  difference()
  {
	x_endstop_holder_base();
	x_endstop_holder_cuts();
  }
}
 
x_endstop_holder();