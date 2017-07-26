/* 
   === RebeliX BoX ===

   x carriage extruder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Zapusteni sroubu pro pridelani voziku
mount_screw_offset = M3x10_offset;
 
// Delka voziku
carriage_length = 44;
// Sirka voziku
carriage_width = MGN12_W + 1;
// Vyska voziku
carriage_height = 10;

// Ochrana remene
belt_protector_length = 0;
// Zakladna pro remen
belt_base_length = 15;
// O kolik zvedneme motor nad vozik
extra_length = 6;

// Delka dilu
part_length = carriage_width + extra_length + belt_base_length + belt_protector_length;

// Vyska dilu
part_height = carriage_height + MGN12_H;

// Pozice remenu vuci stredu voziku
belt_position = rail_W/2 + motor_width/2 - idler_OUT_D2/2;

// Vyska zakladny pro prisroubovani matky
Z_probe_base_H = 7;

module x_carriage_base()
{ 
  // Zakladna pro pridelani na vozik kolejnice
  rounded_box(carriage_length,part_length,carriage_height,2,1,1,1,1);
  
  translate([0,part_length/2 -4/2,part_height/2 - carriage_height/2]) rounded_box(carriage_length,4,part_height,2,1,1,1,1);
  
  translate([0,-part_length/2 + carriage_width + belt_base_length/2 + extra_length,part_height/2 - carriage_height/2]) rounded_box(carriage_length,belt_base_length,part_height,2,1,1,1,1);
}

module x_carriage_holes()
{    
  // Otvory pro prisroubovani na carriage 
  for (a = MGN12_holes)
  translate(a + [0,-part_length/2 + carriage_width/2 + extra_length,carriage_height/2 -mount_screw_offset]) 
  {
	rotate([180,0,0]) screw_hole(1);
  }
  
  // Vyrez pro remen
  translate([0,-part_length/2 + carriage_width/2 + extra_length + belt_position,carriage_height/2 + MGN12_H - rail_H]) belt_holder_beltcut(carriage_length + 6,6.2,6.8);
  
  // otvory pro pridelani extruderu
  translate([0,-part_length/2 + carriage_width/2,-1])
  {
	translate([carriage_length/2 - 6,0,0]) nut_hole(1);
	translate([-carriage_length/2 + 6,0,0]) rotate([0,0,180]) nut_hole(1);
	translate([0,-carriage_width/2 + 5,0]) rotate([0,0,-90]) nut_hole(1); 
  }	
  // Otvory pro pridelani Z probe
  translate([-carriage_length/2 + 10,part_length/2 - 4,0]) rotate([0,90,90]) nut_hole(0,20);
  translate([carriage_length/2 - 10,part_length/2 - 4,0]) rotate([0,90,90]) nut_hole(0,20);
}

/* ============================= PROBE HOLDER START ================================== */

module Z_probe_mount_base()
{ 
  Z_base_length = carriage_length + Z_probe_D + (Z_probe_nut_D - Z_probe_D)/2;
  Z_base_width = Z_probe_D + 4;

  translate([0,(Z_probe_D - carriage_height)/2,0]) rounded_box(Z_probe_nut_D,Z_base_width,Z_probe_base_H,4,1,1,1,1);
  
  translate([-Z_base_length/2 + Z_probe_nut_D/2,0,0]) rounded_box(Z_base_length,carriage_height,Z_probe_base_H,4,1,1,1,1);
  
  translate([-Z_base_length/2 + Z_probe_nut_D/2 - Z_base_length/2 + carriage_length/2 - Z_probe_nut_D/4 + Z_probe_D/4,0,Z_probe_nut_H/2]) rounded_box(carriage_length - (Z_probe_nut_D - Z_probe_D)/2,carriage_height,Z_probe_base_H + Z_probe_nut_H,4,1,1,1,1);
}

module Z_probe_MGN12_holes()
{ 
  Z_base_length = carriage_length + Z_probe_D + (Z_probe_nut_D - Z_probe_D)/2;

  translate([0,(Z_probe_D - carriage_height)/2,0]) cylinder(d=Z_probe_D,h=30,$fn=64,center=true);
  
  // Otvory pro matky   
  translate([-Z_base_length/2 + Z_probe_nut_D/2 - Z_base_length/2 + 10,0,Z_probe_base_H/2 + Z_probe_nut_H - mount_screw_offset]) rotate([180,0,0]) screw_hole(1);
 
  translate([-Z_base_length/2 + Z_probe_nut_D/2 - Z_base_length/2 + carriage_length - 10,0,Z_probe_base_H/2 + Z_probe_nut_H - mount_screw_offset]) rotate([180,0,0]) screw_hole(1);
}

module Z_probe_mount()
{
  difference()
  {
	Z_probe_mount_base();
    Z_probe_MGN12_holes();
  } 
}

/* ============================= PROBE HOLDER END ================================== */

// Cela soucastka
module x_carriage_extruder()
{
  difference()
  {
    x_carriage_base();
    x_carriage_holes();
  }
}

x_carriage_extruder();