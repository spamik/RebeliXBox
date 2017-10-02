/* 
   === RebeliX BoX ===

   z motor
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

include <../inc/functions.scad>

M6_screw_offset = M6x14_offset;
motor_screw_offset = M3x10_offset;

// Posun motoru
motor_offset = 0.3;

base_height = motor_screw_offset;
base_width = motor_width;
base_length = motor_width + profile_width + motor_offset;

motor_center_D = 21;

module z_motor_base()
{ 
  // Zakladna
  translate([-motor_offset/2,0,0]) rounded_box(base_length,base_width,base_height,6,1,1,1,1);
  
  // Drazka pro profil
  translate([-base_length/2 + profile_width/2 - motor_offset/2,0,base_height/2]) rotate([0,0,90]) drazka(base_width);
}

module z_motor_holes()
{       
  // Otvory pro pridelani motoru
  for (a = motor_mount_holes)
  translate(a + [base_length/2 - motor_width/2 - motor_offset/2,0,-base_height/2 + motor_screw_offset])
  {
	screw_hole(0);	
  } 
  
  // Vyrez pro stred motoru
  translate([base_length/2 - motor_width/2 - motor_offset/2,0,0])
  { 
    cylinder(d=motor_center_D, h = 20, $fn = 64, center=true);
	translate([0,0,base_height/2]) cylinder(d=23, h = 5, $fn = 64, center=true);
    translate([0,motor_width/2,0]) cube([motor_center_D,motor_width,base_height + 1],center=true);
  }
   
  // Otvory pro M6 srouby
  translate([-base_length/2 + profile_width/2 - motor_offset/2,0,base_height/2 - M6_screw_offset]) rotate([180,0,0]) screw_hole(1,0,M6_head_D,M6_screw_D);
}

// Cela soucastka
module z_motor()
{
  difference()
  {
    z_motor_base();
    z_motor_holes();
  }
}

// Strana 1
z_motor();

// Strana 2
translate([0,45,0]) mirror([0,1,0]) z_motor();