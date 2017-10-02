/* 
   === RebeliX BoX ===

   extruder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

motor_screw_offset = M3x10_offset;
extruder_mount_offset = M3x10_offset;

// Delka voziku
length_carriage = 44;
// Sirka voziku
width_carriage = MGN12_W + 1.5;
// Vyska voziku
height_carriage = 10;

base_height = 7.5;

// Vyska dilu
part_height = height_carriage + MGN12_H;

// drive gear
drive_gear_outer_radius = 9.00;
drive_gear_hobbed_radius = 8;
drive_gear_hobbed_offset = 4.2;
drive_gear_tooth_depth = 0.35;

// filament
filament_diameter = 1.75;
filament_offset = drive_gear_hobbed_radius/2 + filament_diameter / 2 - drive_gear_tooth_depth;

// Prumer teflonove trubicky
teflon_tube_diameter = 4;

x_motor_offset = 0;

// Hodnota z nozzle_mount.scad (sirka drzaku HE)
//mount_width = 20;
HE_mount_height = 31;

packa_height = 15;

// Pritlacna pruzina
spring_D = 5.4;
spring_L = 13;
spring_screw_D = M3_screw_D;

extruder_mount_height = width_carriage/2 + 10;

// Nastaveni drzaku pneufitu
pneufit_dia = 4.6;
pneufit_length = 4;

teflon_holder = 1;
teflon_holder_height = base_height + 15;
teflon_holder_length = 31;
teflon_holder_width = motor_width/2;

echo("Z probe Y-offset",HE_mount_height/2 + Z_probe_D/2);
echo("Z probe X-offset",motor_width/2 + abs(filament_offset + x_motor_offset) + Z_probe_D/2);

module extruder_base()
{
  // Zakladna pro pridelani motoru extruderu
  translate([x_motor_offset,0,0]) rounded_box(motor_width,motor_width,base_height,6,1,1,1,0);

  translate([x_motor_offset,-motor_width/4 - ext_idler_OUT_D/4 - 1/4,15/2]) rounded_box(motor_width,motor_width/2 - (ext_idler_OUT_D + 1)/2,base_height + 15,4,1,1,1,0);
  
  translate([x_motor_offset - motor_width/2 + motor_width/4 - 23/4,-motor_width/4 + 5/2,15/2]) rounded_box(motor_width/2 - 23/2,motor_width/2 + 5,base_height + 15,4,1,1,1,0);
  
  // Operka pro prst
  translate([x_motor_offset - motor_width/2 + motor_width/4 - 23/4 - 9/2,0,15/2]) rounded_box(motor_width/2 - 23/2 + 9,10,base_height + 15,4,1,1,1);
  
  translate([x_motor_offset - motor_width/2 + motor_width/4,-motor_width/4,15/2]) rounded_box(motor_width/2,motor_width/2,base_height + 15,4,1,1,1,0);
  
  translate([x_motor_offset + filament_offset,-motor_width/4,15/2]) cube([ext_idler_OUT_D,motor_width/2, base_height + 15],center=true);
 
  // Zakladna pro pridelani HE 
  translate([10/2,-motor_width/2-extruder_mount_height/2 + 0.001,-base_height/2 + HE_mount_height/2]) rounded_box(motor_width - 10,extruder_mount_height,HE_mount_height,2,1,0,0,1);
  
  translate([x_motor_offset/2,-motor_width/2 - width_carriage/2 - 1,-base_height/2 + 10/2]) rounded_box(motor_width - x_motor_offset,extruder_mount_height/2,10,6,1,1,1,1);
  
  // Pridelani bloweru
  translate([-motor_width/2 + 15,-motor_width/2 + 9/2,-base_height/2 + HE_mount_height/2]) rounded_box(10,9,HE_mount_height,2,0,1,1,0);
  
  // Zakladna drzaku pneufitu
  if(teflon_holder)
  {
    translate([x_motor_offset + filament_offset,teflon_holder_length/2,0]) rounded_box(motor_width/2,motor_width + teflon_holder_length,base_height,3,1,1,1,0);
  
    translate([x_motor_offset + filament_offset,motor_width/2 + teflon_holder_length - 18/2,-base_height/2 + teflon_holder_height/2]) rounded_box(teflon_holder_width,18,teflon_holder_height,3,1,1,1,1);	
  }
}

module extruder_holes()
{  
  motor_screw_offset = 5;
  
  // Vyrez pro motor
  cut_height = 3;
  
  motor_MGN12_holes = [
  [-31/2,-31/2,0],
  [31/2,-31/2,0],
  [31/2,31/2,base_height/2],
  [-31/2,31/2,0]
  ];
  
  MGN12_holes = [
	[length_carriage/2 - 6,-motor_width/2 - width_carriage/2,-base_height/2 + extruder_mount_offset],
	[-length_carriage/2 + 6,-motor_width/2 - width_carriage/2,-base_height/2 + extruder_mount_offset],
	//[-1.5,-motor_width/2 - 5,-base_height/2 + extruder_mount_offset],
  ];
    
  // Otvory pro pridelani motoru 
  for (a = motor_MGN12_holes)
  translate(a + [x_motor_offset,0,-base_height/2 + motor_screw_offset]) rotate([0,180,0])
	{
	  rotate([180,0,0]) screw_hole(0);
	}
	
  // Vyrez pro motor	
  translate([x_motor_offset,0,15/2])
  {
    difference()
	{
	  cylinder(d=23, h = part_height + 1, $fn = 64, center=true);
	  difference()
	  {
	    translate([filament_offset,-motor_width/4,0]) cube([ext_idler_OUT_D + 2,motor_width/2, part_height + 1],center=true);
	    
		// Hnaci kolecko
        translate([0,0,-15/2 - base_height/2 + part_height/2 + 1/2 + cut_height]) cylinder(d=drive_gear_outer_radius + 1, h = part_height + 1, $fn = 32, center=true);
		
        // Vyrez pro sroubek hnaciho kolecka
		translate([0,0,-15/2 - base_height/2 + 9 + 2/2 + cut_height - 0.01]) cylinder(d1=drive_gear_outer_radius + 4,d2=drive_gear_outer_radius + 1, h = 2, $fn = 32, center=true);
		
		translate([0,0,-15/2 - base_height/2 + 9/2 + cut_height]) cylinder(d=drive_gear_outer_radius + 4, h = 9, $fn = 32, center=true);
	    
		// Pritlacne lozisko
	    translate([filament_offset + ext_idler_OUT_D/2 + 0.1,0,-15/2 - base_height/2 + part_height/2 + 1/2 + cut_height]) cylinder(d=ext_idler_OUT_D + 1,h=part_height + 1,$fn=32,center=true);
		
		// Podpory
		translate([filament_offset,-motor_width/4,-15/2 - base_height/2 + cut_height/2 - 2*layer_height]) cube([ext_idler_OUT_D + 2 - 2*0.6,motor_width/2 - 2*0.6, cut_height],center=true);
	  }
    }
	// Zip paska na prichyceni kabelu od HE
    translate([-motor_width/2 + 10,-motor_width/2 - 5,-15/2]) zip_paska(4);
	translate([-motor_width/2 + 10,-motor_width/2 - 5,-15/2 + 10]) zip_paska(4);
  }
  
  // Vyrez pro matku pritlacneho raminka
  translate([x_motor_offset + 23/2,0,base_height/2]) cylinder(d=9,h=6,$fn=32,center=true);
  
  // Vyrez pro pruzinu
  translate([x_motor_offset -motor_width/2 + spring_D/2 + 2,10,base_height/2 + 15/2]) rotate([90,0,0]) cylinder(d=spring_D + 0.3,h=spring_L,$fn=32,center=true);
  
  // Vyrez pro maticku od pruzinky
  translate([x_motor_offset -motor_width/2 + spring_D/2 + 2,-1,base_height/2 + 15/2]) rotate([0,-90,90]) nut_hole(0,20);

  // Otvory pro pridelani na carriage
  for (a = MGN12_holes)
  translate(a + [0,-1,0]) rotate([0,180,0])
	{
	  rotate([180,0,0]) screw_hole(0);
	}
  
  // Vyrez pro HE
  translate([filament_offset + x_motor_offset,-motor_width/2 - extruder_mount_height + 4.8 - 0.005,HE_mount_height >= 31 ? -base_height/2 + HE_mount_height/2 : -base_height/2 + 31/2]) rotate([90,0,0]) grooveMGN12_holes();	
  
  translate([filament_offset + x_motor_offset,-motor_width/2 - extruder_mount_height + 4.8,-base_height/2 + HE_mount_height - M3_nut_D/2]) rotate([90,-90,0]) nut_hole(0,20);
  
  translate([filament_offset + x_motor_offset,-motor_width/2 - extruder_mount_height + 4.8,-base_height/2 + M3_nut_D/2]) rotate([90,90,0]) nut_hole(0,20);

  // Vyrez pro prsty
  if(teflon_holder)
  {
    translate([x_motor_offset + filament_offset,motor_width/2 + teflon_holder_length - 20/2 - 8,base_height/2 + 20/2]) rotate([0,90,0]) cylinder(d=20,h=teflon_holder_height + 1,$fn=64,center=true);
 
    translate([x_motor_offset + filament_offset,motor_width/2 + teflon_holder_length - 20/2 - 8,base_height/2 + 20]) cube([teflon_holder_height+1,20,20],center=true);
  }
  
  // Otvory pro blower
  translate([-motor_width/2 + 15,-motor_width/2 + 5,-base_height/2 + HE_mount_height - 5 ]) rotate([0,0,90]) nut_hole(1);
  
  translate([motor_width/2 - M3_nut_D/2,-motor_width/2 - 5,-base_height/2 + HE_mount_height - 5 ]) nut_hole(1);
}

module grooveMGN12_holes (extruder_recess_big_d=16.4, 
						  extruder_recess_big_h=4.8, 
						  extruder_recess_small_d=12.4,
						  extruder_recess_small_h=4.6)
{	
  // Zakladna HE (pro zasunuti do extruderu)
  cylinder(d=extruder_recess_big_d,h=extruder_recess_big_h,$fn=64);
  translate([0,0,extruder_recess_big_h]) cylinder(d=extruder_recess_small_d,h=extruder_recess_small_h+0.001,$fn=40);
  translate([0,0,extruder_recess_big_h+extruder_recess_small_h]) 
  cylinder(d=extruder_recess_big_d,h=extruder_recess_big_h,$fn=64);
  // Otvor pro filament
  cylinder(d=teflon_tube_diameter,h=260,$fn=16,center=true);  	
}

module packa_extruderu_base(height = 15)
{ 
  translate([-9/2,motor_width/4,0]) rounded_box(motor_width + 9,motor_width/2,height,2,1,1,1,1);
  translate([motor_width/4 + drive_gear_outer_radius/4 + 1/2,motor_width/4 - 5/2,0]) rounded_box(motor_width/2 - (drive_gear_outer_radius/2 + 1),motor_width/2 + 5,height,8,1,1,1,1);
}

module packa_extruderu_cuts(height = 15)
{   
  translate([0,1,0]) cylinder(d=drive_gear_outer_radius + 2,h=50,$fn=32,center=true);
  
  rotate([0,0,-10]) translate([-motor_width/2,0,0]) cube([motor_width,drive_gear_outer_radius + 4,50],center=true);
  
  translate([-motor_width/2 + drive_gear_outer_radius/2 + 2/2,-20/2,0]) cube([motor_width,20,50],center=true);
  
  translate([31/2,31/2,-base_height/2 + motor_screw_offset])
  {
	screw_hole(0);
  }
	
  // Vyrez pro filament 
  translate([filament_offset,motor_width/2 - 50/2 - pneufit_length,0]) rotate([90,0,0]) cylinder(d=filament_diameter + 0.6,h=50,$fn=16,center=true);
  
  translate([filament_offset,motor_width/2 - pneufit_length - pneufit_length/2 + 0.01,0]) rotate([90,0,0]) cylinder(d1=pneufit_dia,d2=filament_diameter + 0.6,h=pneufit_length,$fn=16,center=true);
  
  // Vyrez pro pneufit
  translate([filament_offset,motor_width/2,0]) rotate([90,0,0]) cylinder(d=pneufit_dia,h=2*pneufit_length,$fn=16,center=true);  
  
  translate([filament_offset + ext_idler_OUT_D/2 + 0.3,0,0])
  {
	// Otvor pro sroub
	cylinder(d=ext_idler_screw_D,h=100,$fn=16,center=true);
  
    // Otvor pro matku
	translate([0,0,-height/2]) cylinder(d=ext_idler_nut_D,h=2*ext_idler_nut_H,$fn=6,center=true);
  
	// Vyrez pro pritlacne lozisko
	cylinder(d=ext_idler_OUT_D + 1,h=ext_idler_H,$fn=32,center=true);
  
	translate([-1,0,0]) cylinder(d=ext_idler_OUT_D + 1,h=ext_idler_H,$fn=32,center=true);
  
	translate([-1/2,0,0]) cube([1,ext_idler_OUT_D + 1,ext_idler_H],center=true);
  
	translate([0,-30/2,0]) cube([ext_idler_OUT_D + 1,30,ext_idler_H],center=true);
  }
  
  // Vyrez pro pruzinu
  translate([-motor_width/2 + spring_D/2 + 2,motor_width/2 - 9,0]) rotate([90,0,0]) screw_hole(0,1,spring_D,spring_screw_D); 
}

// Cela soucastka
module extruder()
{
  difference()
  {
    extruder_base();
    extruder_holes();
  }
}

module packa_extruderu(packa_height)
{
  difference()
  {
	packa_extruderu_base(packa_height);
    packa_extruderu_cuts(packa_height);
  }
}

mirror([0,1,0])
extruder();

mirror([0,1,0])
rotate([-90,0,0]) 
translate([x_motor_offset + 30,- motor_width/2 + base_height/2,0]) rotate([0,90,0]) packa_extruderu(packa_height);