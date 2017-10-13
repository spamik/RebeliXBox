/* 
   === RebeliX BoX ===

   Blower 50 mm SUNON
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>
use </inc/50mm_Blower.scad>
use </inc/text_RebeliX.scad>

base_height = 3;

// Vydalenost sroubu pro pridelani
screws_dist = 24;

x1 = 20;
x2 = -23;
y1 = -17.1;
y2 = 21.1;

pos_x = x2 + (x1 - x2)/2;
pos_y = y1 + (y2 - y1)/2;

d_fan = 48.9;
w_fan = 51.7;
l_fan = 51.6;

module blower_holder_base()
{
  blower_fan_base(base_height,0);
  
  // Prostor k prisroubovani na extruder
  translate([pos_x + d_fan/2 - w_fan + 0.5 + 51/2 - motor_width/2 + screws_dist/2,pos_y + d_fan/2 + 2,0]) rounded_box(screws_dist + M3_washer_D,20,base_height,6,1,1,1,1);
  
  translate([pos_x + d_fan/2 - w_fan + 0.5 + 51/2 - motor_width/2 + screws_dist,pos_y + d_fan/2 + 5 + 2,0]) rounded_box(10,30,base_height,6,1,1,1,1);
}

module blower_holder_holes()
{ 
  mount_screws_dist = 5;
  
  translate([0,0,15.8/2 + base_height/2]) blower_fan_base(15.8,1);
  
  // Otvory pro pridelni na extruder
  translate([pos_x + d_fan/2 - w_fan + 0.5 + 51/2 - motor_width/2 + screws_dist,pos_y + d_fan/2 + 15,0]) 
  {
    translate([0,-mount_screws_dist/2,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
    translate([0,mount_screws_dist/2,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
    cube([3.2,5,10],center=true);
  }
  
  translate([pos_x + d_fan/2 - w_fan + 0.5 + 51/2 - motor_width/2,pos_y + d_fan/2 + 5,0])
  {
    translate([0,-mount_screws_dist/2,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
    translate([0,mount_screws_dist/2,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
    cube([3.2,5,10],center=true);
  }
	
  // Text RebeliX
  translate([-14,-27.5,20.3 - 0.6]) scale([0.3,0.3,1]) text_RebeliX(1);
}

module blower_holder()
{
  difference()
  {
	blower_holder_base();
    blower_holder_holes();
  } 
}

blower_holder();