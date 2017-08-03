/* 
   === RebeliX BoX ===

   x carriage motor
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

base_height = 44;
base_width = MGN12_W + 1.5;
base_thick = 10;

// Delka drzaku kolejnice
rail_holder_length = motor_width + 2;
// Vyska drzaku kolejnice
rail_holder_height = base_height/2 - MGN12_H + 8;

// Vzdalenost X motoru od okraje dilu (2mm = priruba NEMA17 motoru)
motor_mount_height = rail_holder_height + 2 + rail_H + 1.7;

// Sirka vyztuzeni
wall_W = 1;

/* ----------- Parametry drzaku remenu ----------- */

belt_holder_length = motor_mount_height;
belt_holder_width = 15;
// Zakladna 3mm + sirka remenu + 2 
belt_holder_height = 5 + belt_width + 2;

// Mezera mezi otvorem a X motorem
cable_offset = 6;

// Delka drzaku Y endstopu
y_endstop_height = 13;

// Zapusteni sroubu pro pridelani voziku
mount_screw_offset = M3x10_offset;

// Zapusteni sroubu pro pridelani motoru
motor_screw_offset = M3x10_offset;

// Otvory na MGN12_H  
MGN12_holes = [
	[10, 0, 10],
	[10, 0, -10],
	//[-10, 0, -10],
	[-10, 0, 10]
];

/* ----------- Drzak energo retezu ----------- */

// Drzak energo retezu
chain_holder_W = chain_mount_W + 2*mantinel_W;

// Vyska drzaku
chain_holder_H = 10;

// Delka drzaku
chain_holder_L = 25;

// Posun drzaku
chain_holder_offset = 1;

module x_carriage_base()
{
  // Zakladna
  cube([base_width,base_thick,base_height],center=true);
  
  // Motor
  translate([motor_width/2 - base_width/2 + wall_W/2,-motor_width/2 - base_thick/2,-base_height/2 + motor_mount_height/2]) rounded_box(motor_width + wall_W,motor_width,motor_mount_height,6,1,0,1,1);
  
  difference()
  {
    // Vyztuzeni
	translate([-base_width/2 + wall_W/2,-motor_width/2 - base_thick/2 + 4/2,0]) cube([wall_W,motor_width - 4,base_height],center=true);
    // Seriznuti vyztuzeni
    translate([-motor_width/2,-5-motor_width,5]) rotate([25,0,0]) cube([50,motor_width + 30,motor_width]); 
  }
  
  // Drzak kolejnice pojezdu X 
  translate([base_width/2 + rail_holder_length/2 - 0.001,-base_thick/2 + rail_W/2 - (motor_width/2 - 20/2)/2 + 5/2,-base_height/2 + rail_holder_height/2]) rounded_box(rail_holder_length,rail_W + motor_width/2 - 20/2 - 5,rail_holder_height,4,0,1,1,1);
  
  translate([base_width/2 + rail_holder_length/2 - 0.001,-base_thick/2 - motor_width/4 + 10/2 + 5/2,-base_height/2 + rail_holder_height/2 + 2/2]) rounded_box(rail_holder_length, motor_width/2 - 10 - 5,rail_holder_height + 2,4,0,0,1,1); 
  
  // Cable X motor holder
  translate([(wall_W + motor_width + 10)/2 - base_width/2,-base_thick/2 - motor_width/4 + 10/2,-base_height/2 + rail_holder_height/2 + 2/2]) rounded_box(wall_W + motor_width + 10, motor_width/2 - 10,rail_holder_height + 2,4,0,0,1,1);
  
  // Drzak energo retezu
  translate([profile_width/2 + chain_holder_W/2 + chain_x_offset,-base_thick/2 + rail_W + chain_holder_H/2 + chain_holder_offset,-base_height/2 + chain_holder_L/2]) rounded_box(chain_holder_W,chain_holder_H,chain_holder_L,4,0,0,0,0);
  
  translate([profile_width/2 + chain_holder_W/2 + chain_x_offset,-base_thick/2 + rail_W/2 - (motor_width/2 - 20/2)/2 + 5/2 + chain_holder_H/2 + chain_holder_offset/2,-base_height/2 + rail_holder_height/2]) rounded_box(chain_holder_W,rail_W + motor_width/2 - 20/2 - 5 + chain_holder_H + chain_holder_offset,rail_holder_height,4,0,0,1,0); 
  
  // Zarazka pro energo retez
  translate([profile_width/2 + chain_x_offset + mantinel_W/2,-base_thick/2 + rail_W + chain_holder_H/2 + 2/2 + chain_holder_offset,-base_height/2 + chain_holder_L/2]) cube([mantinel_W,chain_holder_H + 2,chain_holder_L],center=true);
  
  // Zarazka pro energo retez
  translate([profile_width/2 + chain_holder_W + chain_x_offset - mantinel_W/2,-base_thick/2 + rail_W + chain_holder_H/2 + 2/2 + chain_holder_offset,-base_height/2 + chain_holder_L/2]) cube([mantinel_W,chain_holder_H + 2,chain_holder_L],center=true);
  
  // Drzak remenu  
  translate([-base_width/2 + belt_holder_height/2,base_thick/2 -(belt_holder_width + motor_width + base_thick)/2,-base_height/2 + motor_mount_height/2]) rounded_box(belt_holder_height,belt_holder_width + motor_width + base_thick,motor_mount_height,4,1,0,0,0); 
}

module x_carriage_holes()
{    
  // Otvory pro prisroubovani na carriage 
  for (a = MGN12_holes)
  translate(a + [0,base_thick/2 - mount_screw_offset,0]) 
  {
	rotate([90,0,0]) screw_hole();
  }
   
  // Vyrez pro motor
  translate([motor_width - base_width/2 + belt_holder_height,-motor_width/2 - motor_width - base_thick/2,0]) cube([2*motor_width,2*motor_width,base_height + 1],center=true);
  
  translate([motor_width/2 - base_width/2 + wall_W,-motor_width/2 - base_thick/2,-base_height/2 + motor_mount_height]) rotate([180,0,0]) nema17([0,1,1,1],1,motor_screw_offset,1,0);
  
  // Otvory na pridelani kolejnice pojezdu X 
  translate([base_width/2 + rail_first_hole,base_thick/2 + rail_W/2 - base_thick,-base_height/2]) rail_holes(2); 

  // Vyrez srouby (drzak remenu)
  translate([-base_width/2 + belt_holder_height/2 + 2,-motor_width - base_thick/2 - belt_holder_width + M3_head_D/2 + 2,0])
  {
	translate([0,0,-base_height/2 + belt_holder_length - 6]) rotate([0,-90,180]) nut_hole(0);
	translate([0,0,-base_height/2 + 6]) rotate([0,90,0]) nut_hole(0);
  }
     
  // Vyrez pro konektor od X motoru
  translate([(base_width - 1)/2 + 12 + cable_offset + 1,-base_thick/2 - motor_width/4 + 10/2,0]) motor_connector_cut();
  
  // Otvory pro pridelani X endstopu
  translate([profile_width/2 + chain_holder_W/2 + chain_x_offset + 8/2,-base_thick/2 + rail_W + chain_holder_H/2 + chain_holder_offset,-base_height/2 + chain_holder_L]) cylinder(d=2,h=20,$fn=16,center=true);
  
  translate([profile_width/2 + chain_holder_W/2 + chain_x_offset - 8/2,-base_thick/2 + rail_W + chain_holder_H/2 + chain_holder_offset,-base_height/2 + chain_holder_L]) cylinder(d=2,h=20,$fn=16,center=true);
  
  // Vyrez pro kablik od Y endstopu
  translate([0,base_thick/2,y_endstop_height/2]) cube([6.5,base_thick + 2,base_height + y_endstop_height + 10],center=true);
  
  // Otvory pro pridelani chain holderu
  translate([profile_width/2 + chain_holder_W/2 + chain_x_offset,-base_thick/2 + rail_W + chain_holder_offset + 20/2,-base_height/2 + 5]) 
  {
	rotate([90,0,0]) cylinder(d=2,h=20,$fn=16,center=true);
	translate([0,0,8]) rotate([90,0,0]) cylinder(d=2,h=20,$fn=16,center=true);
	translate([0,0,10]) rotate([90,0,0]) cylinder(d=2,h=20,$fn=16,center=true);
	translate([0,0,9]) cube([2,20,2],center=true);
  }
  
  // Otvor pro zip pasku pro kabely od endstopu
  translate([39,-1,-base_height/2]) rotate([40,90,0]) zip_paska(4);
}

module GT2_belt_holder_base()
{  
  rounded_box(belt_holder_length,belt_holder_width + 6,3,4,1,1,1,1);
  
  translate([0,-(belt_holder_width + 6)/2 + belt_holder_width/2,belt_holder_height/2 - 3/2 + 1]) rounded_box(belt_holder_length,belt_holder_width,belt_holder_height,4,1,1,1,1);
}


module GT2_belt_holder_cuts()
{ 
  // Zapusteni sroubu
  M3_screw_offset = 3;
	
  // Vyrez pro remen  
  translate([0,-(belt_holder_width + 6)/2 + 7,3/2 + 3]) belt_holder_beltcut(belt_holder_length,belt_lock_thickness,belt_holder_height - 6.3);
  
  // Prisroubovani drzaku
  translate([0,(belt_holder_width + 6)/2 - M3_head_D/2 - 2,0]) rotate([180,0,0])
  {
	translate([belt_holder_length/2 - 6,0,-M3_screw_offset/2]) rotate([0,180,0]) screw_hole();
	
	translate([-belt_holder_length/2 + 6,0,-M3_screw_offset/2]) rotate([0,180,0]) screw_hole();
  }
}

module motor_connector_cut(pin = 4)
{
  //vyska = 4.5;
  //sirka = 12.5;
  
  vyska = 5;
  sirka = 7;
  
  translate([-sirka/2 + vyska/2,0,0]) cylinder(d=vyska,h=60,$fn=16,center=true);
  translate([sirka/2 - vyska/2,0,0]) cylinder(d=vyska,h=60,$fn=16,center=true);
  cube([sirka - vyska,vyska,60],center=true);
}

// Cela soucastka
module x_carriage_motor()
{
  difference()
  {
    x_carriage_base();
    x_carriage_holes();
  }
}

// Drzak remenu
module GT2_belt_holder()
{
  difference()
  {
	GT2_belt_holder_base();
	GT2_belt_holder_cuts();
  }
}

x_carriage_motor();