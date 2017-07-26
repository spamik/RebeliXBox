/* 
   === RebeliX BoX ===

   y motor
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;
motor_screw_offset = M3x10_offset;

// Posun motoru
motor_offset = -7;

base_height = motor_screw_offset + M3_head_H;
base_width = motor_width;
base_length = motor_width + profile_width + motor_offset;

motor_center_D = 23;

module y_motor_base()
{
  translate([-motor_offset/2 - motor_width/4,0,0]) rounded_box(base_length - motor_width/2,base_width,base_height,6,1,1,1,1);
  
  translate([-motor_offset/2 - motor_width/4,0,0]) rounded_box(base_length - motor_width/2,base_width,base_height,6,1,1,1,1);
  
  translate([-motor_offset/2,-base_width/4 - motor_center_D/4,0]) rounded_box(base_length,base_width/2 - motor_center_D/2,base_height,4,1,0,1,1);
  
  // Drazka pro profil
  translate([-base_length/2 + profile_width/2 - motor_offset/2,0,base_height/2]) rotate([0,0,90]) drazka(base_width);
}

module y_motor_holes()
{   
  // Rozsireni montaynich otvoru (pro napnuti remene)
  hole_distance = 3;
  
  motor_mount_holes = [
  [-31/2,-31/2,0],
  [31/2,-31/2,0],
  //[31/2,31/2,0],
  [-31/2,31/2,0],
  ];
    
  // Otvory pro pridelani motoru
  for (a = motor_mount_holes)
  translate(a + [base_length/2 - motor_width/2 - motor_offset/2,0,-base_height/2 + motor_screw_offset])
  {
	screw_hole(0,hole_distance);	
  } 
  
  // Vyrez pro stred motoru
  translate([base_length/2 - motor_width/2 - motor_offset/2,0,0])
  { 
    translate([hole_distance/2,0,0]) cylinder(d=motor_center_D, h = 20, $fn = 64, center=true);
	translate([-hole_distance/2,0,0]) cylinder(d=motor_center_D, h = 20, $fn = 64, center=true);
    cube([hole_distance,motor_center_D,20], center=true);
  }
  
  // Seriznuti rohu
  translate([base_length/2 - motor_width/2 - motor_offset/2,motor_center_D/2 - 5/2 + 1,0]) rotate([0,0,45]) cube([5,5,base_height + 1],center=true);
   
  // Otvory pro M6 srouby
  translate([-base_length/2 + profile_width/2 - motor_offset/2,0,base_height/2 - M6_screw_offset]) rotate([180,0,0]) screw_hole(1,0,M6_head_D,M6_screw_D);
  
  // Otvory pro zip pasky
  translate([-base_length/2 + profile_width/2 - motor_offset/2 - 5,base_width/2 - 8,-base_height/2]) rotate([90,0,0]) zip_paska(6);
  
  translate([-base_length/2 + profile_width/2 - motor_offset/2 - 5,-base_width/2 + 8,-base_height/2]) rotate([90,0,0]) zip_paska(6);
}

// Cela soucastka
module y_motor()
{
  difference()
  {
    y_motor_base();
    y_motor_holes();
  }
}

// Strana 1
y_motor();

// Strana 2
translate([0,45,0]) mirror([0,1,0]) y_motor();