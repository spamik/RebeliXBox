/* 
   === RebeliX BoX ===

   filament sensor
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_L = 30;
part_H = 13;
part_W = 45;

module filament_sensor_base()
{
  rounded_box(part_W,part_L,part_H,4,1,1,1,1);
  
  // Plocha pro pridelani
  translate([-part_W/2 + profile_width/2,-part_L/2 + (M6_washer_D + part_L)/2,-part_H/2+6/2]) rounded_box(profile_width,M6_washer_D + part_L,6,4,1,1,1,1);
}

module filament_sensor_holes()
{   
  offset = 7;
  
  // Vyrez pro micro spinac
  translate([4,-3.5,part_H/2 - offset]) microswitch_body();
  
  // Draha pro filament
  translate([0,9.2,part_H/2 - offset + 6.4/2]) rotate([0,90,0]) cylinder(d=2, h=part_W + 1, $fn=32,center=true);
  
  // Nabeh pro filament
  translate([-12.5 + 4,9.2,part_H/2 - offset + 6.4/2]) rotate([0,90,0]) cylinder(d1=2, d2=6/2, h=1, $fn=32,center=true);
  translate([-7 + 4,9.2,part_H/2 - offset + 6.4/2]) rotate([0,-90,0]) cylinder(d1=2, d2=6/2, h=1, $fn=32,center=true);
  translate([-12.5 + 4 - (-7 + 4) - 0.25 ,9.2,part_H/2 - offset + 6.4/2]) rotate([0,-90,0]) cylinder(d=6/2, h=4.6, $fn=32,center=true);
  
  // Vyrez pro pneufit
  translate([-part_W/2,9.2,part_H/2 - offset + 6.4/2]) rotate([0,90,0]) cylinder(d=4.5,h=2*4.5,$fn=32,center=true);
  
  // Nabeh pro filament
  translate([part_W/2 - 2,9.2,part_H/2 - offset + 6.4/2]) rotate([0,90,0]) cylinder(d1=2,d2=6,h=6,$fn=32,center=true);
  
  // Otvor pro M6 sroub
  translate([-part_W/2 + profile_width/2,-part_L/2 + part_L + M6_washer_D/2,0]) cylinder(d=M6_screw_D,h=20,$fn=32,center=true);
}

module microswitch_body()
{
  switch_L = 20.4;
  switch_H = 6.4 + 10;
  switch_W = 10.6; 
  
  arm_L = 20;
  arm_angle = 10 -3;
  
  translate([0,0,switch_H/2])
  {  
    // Telo
    translate([0,0,0]) cube([switch_L,switch_W,switch_H],center=true);
  
    // Otvory pro pridelani
    translate([5,-switch_W/2 + 3,0]) cylinder(d=2,h=30,$fn=16,center=true);
    translate([-5,-switch_W/2 + 3,0]) cylinder(d=2,h=30,$fn=16,center=true);
  
    // Rameno s kladkou
    translate([switch_L/2 - 3,switch_W/2,-switch_H/2]) rotate([180,180,-arm_angle])
    {
      translate([-2.5,-2,0]) cube([arm_L + 3,6,switch_H],center=false);
	  translate([arm_L - 5.5,-3.5,0]) cube([6,2*3.5,switch_H],center=false);
	  translate([arm_L - 6/2 + 0.5,-3.5,0]) cylinder(d=6,h=switch_H,$fn=32,center=false);
    }
	// Vyrez pro kabely
	difference()
	{
	  translate([0,-switch_W/2 - 20/2,0]) cube([switch_L,switch_W + 20,switch_H],center=true);
	  
	  translate([5 - 2/2,-switch_W/2 - 20/2,0]) cube([3,switch_W + 20,switch_H+1],center=true);
	  
	  translate([-5 + 2/2,-switch_W/2 - 20/2,0]) cube([3,switch_W + 20,switch_H+1],center=true);
	}
  }
}

// Cela soucastka
module filament_sensor()
{
  difference()
  {
    filament_sensor_base();
    filament_sensor_holes();
  }
}

mirror([0,1,0]) filament_sensor();