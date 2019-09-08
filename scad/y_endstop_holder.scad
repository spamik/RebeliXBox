/* 
   === RebeliX BoX ===

   y endstop holder and activator
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Radius zakulacenych rohu
corner_rad = 3;

module y_endstop_activator_base(holder_length = 24.6)
{
  rounded_box(18 + 5,5,profile_width - 10,corner_rad,0,0,1,0);
  
  translate([-(18 + 5)/2 + 5/2,- 5/2 + holder_length/2+18/2,0])  rounded_box(5,holder_length+18,profile_width - 10,corner_rad - 1,0,0,1,0);
  
  // Drazka pro pridelani do profilu
  translate([0,-5/2,0]) cube([18 + 5,3,8],center=true);
}

module y_endstop_activator_cuts()
{  
  // M6 sroub
  translate([(18 + 5)/2 - 18/2,0,0]) rotate([90,0,0]) cylinder(d=M6_screw_D, h=20, $fn=32, center=true);
  // Seriznuti pro lehci tisk
  translate([-(18+5)/2 - 0.01,-5/2,-8/2]) rotate([90 + 30,0,0]) cube([18+5 + 1,3,8]);
  // Vyrez pro profilovou matku
  translate([(18 + 5)/2 - 18/2,-5/2 - 3/2,0])  cube([profile_nut_W,3,10],center=true);
}

module y_endstop_holder_base()
{
  translate([0,motor_width/2 - (5+11)/2 + 5,0]) cube([motor_width,5+11,4],center=true);
  translate([0,motor_width/2 + 5/2,-12/2 + 4/2]) cube([motor_width,5,12],center=true);
}

module y_endstop_holder_cuts()
{
  // Otvory pro pridelani drzaku na motor
  for (a = motor_mount_holes)
  translate(a + [0,0,0]) 
	{
	  screw_hole(1);
	}
	
  // Vyrez na kabely od motoru
  translate([0,motor_width/2 + 10/2,0]) cube([5,10,30],center=true); 
  
  // Pridelani endstopu
  translate([5,motor_width/2,4/2 - 8]) rotate([90,0,0]) cylinder(d=2,h=40,$fn=16,center=true);
  
  translate([-5,motor_width/2,4/2 - 8]) rotate([90,0,0]) cylinder(d=2,h=40,$fn=16,center=true);
  
  // Seriznuti hran
  translate([-20,motor_width/2 + 8,0]) rotate([0,0,20]) cube([30,10,30],center=true);
  translate([20,motor_width/2 + 8,0]) rotate([0,0,-20]) cube([30,10,30],center=true);
  
  // Stredovy vyrez
  cylinder(d=34,h=30,$fn=64,center=true);
}

// Drzak y endstopu
module y_endstop_holder()
{
  difference()
  {
    y_endstop_holder_base();
	y_endstop_holder_cuts();
  }
}

// Doraz y endstopu
module y_endstop_activator(holder_length)
{
  difference()
  {
	y_endstop_activator_base(holder_length);
    y_endstop_activator_cuts();
  } 
}

//translate([0,-motor_width/2,0]) rotate([0,180,0]) y_endstop_holder();
translate([0,15,(profile_width - 10)/2 - 4/2]) y_endstop_activator(24.6);