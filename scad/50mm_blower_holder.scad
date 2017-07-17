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
screws_dist = 16;

x1 = 20;
x2 = -23;
y1 = -17.1;
y2 = 21.1;

pos_x = x2 + (x1 - x2)/2;
pos_y = y1 + (y2 - y1)/2;

module blower_holder_base()
{
  blower_fan_base(base_height,0);
  
  // Prostor k prisroubovani na extruder
  translate([pos_x + 48.9/2 + 20/2 - 51.7 + 0.5 - 20/2 + 51/2,pos_y + 48.9/2 - 3/2,0]) rounded_box(motor_width,20 - 3,base_height,6,1,1,1,1);
}

module blower_holder_holes()
{ 
  translate([0,0,15.8/2 + base_height/2]) blower_fan_base(15.8,1);
  
  // Otvory pro pridelni
  translate([pos_x + 48.9/2 + 20/2 - 51.7 + 0.5 - 20/2 + 51/2 + motor_width/2 - screws_dist/2,pos_y + 48.9/2 + 6.5 - 4,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
  
  translate([pos_x + 48.9/2 + 20/2 - 51.7 + 0.5 - 20/2 + 51/2 - motor_width/2 + screws_dist/2,pos_y + 48.9/2 + 6.5 - 4,0]) cylinder(d=3.2,h=10,$fn=16,center=true);
	
  // Text RebeliX
  translate([-10.5 - 3.5,-27.5,20.3 - 0.6]) scale([0.3,0.3,1]) text_RebeliX(1);
}

module blower()
{
  fan_angle = 18;

  difference()
  {
    cube([20.5,20,16],center=true);
    translate([0,20/2,0]) rotate([-10,180,0]) cube([30,3,20],center=true);
  }
  translate([-20.5/2,20/2 - 3,16/2]) rotate([fan_angle,180,180]) cube([20.5,3,20]);

  translate([0,20/2 - 3 + 5 + 1.5,16/2 + 5 + 1.5]) rotate([fan_angle,0,0]) cube([40,3 + 10,100],center=true);
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




