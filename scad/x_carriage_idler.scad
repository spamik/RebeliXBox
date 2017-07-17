/* 
   === RebeliX BoX ===

   x carriage idler
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include <inc/functions.scad>

/* ----------- Parametry pro idler ----------- */

// Vyska matky + podlozky pod lozisky
//nut_and_washer_height = 4;
nut_and_washer_height = 5.8; // S pojistnou matkou

/* ----------- Zakladna pro pridelani na MGN12_H ----------- */

base_height = 44;
base_width = MGN12_W + 1.5;
base_thick = 10;

/* ----------- Parametry kolejnice ----------- */

rail_holder_length = motor_width + 2;
// Vyska drzaku kolejnice
rail_holder_height = base_height/2 - MGN12_H + 8;

x_motor_offset = base_width/2 - 10 - M3_head_D/2 - 1; 

// Vzdalenost X motoru od okraje dilu (2mm = priruba NEMA17 motoru)
motor_mount_height = rail_holder_height + 2 + rail_H + 1.7;

/* ----------- Parametry drzaku remenu ----------- */
belt_holder_length = motor_mount_height;
belt_holder_width = 15;

// Zakladna 3mm + sirka remenu + 2 
belt_holder_height = 5 + belt_width + 2;

belt_holder_thick = (motor_width - 20)/2;
  
// Zapusteni sroubu pro pridelani voziku
mount_screw_offset = M3x10_offset;

module x_carriage_base()
{
  // Zakladna
  rounded_box(base_width,base_thick,base_height,3,0,0,0,0);
 
  // Drzak kolejnice pojezdu X  
  translate([base_width/2 + rail_holder_length/2 - 0.001,-base_thick/2 + rail_W/2 - (motor_width/2 - 20/2)/2 + 5/2,-base_height/2 + rail_holder_height/2]) rounded_box(rail_holder_length,rail_W + motor_width/2 - 20/2 - 5,rail_holder_height,4,0,1,1,1); 
   
  translate([base_width/2 + rail_holder_length/2 - 0.001,-base_thick/2 - motor_width/4 + 20/4 + 5/2,-base_height/2 + rail_holder_height/2 + 2/2]) rounded_box(rail_holder_length, motor_width/2 - 20/2 - 5,rail_holder_height + 2,4,0,0,1,1); 
  
  // Vyztuzeni
  translate([0,-base_thick/2,-base_height/2 + motor_mount_height]) rounded_box(base_width,2*base_thick,2*base_thick,4,0,0,0,1); 
  
  // Drzak remenu
  hull()
  {
	translate([0,- base_thick/2 - belt_holder_thick/2,-base_height/2 + motor_mount_height/2]) rounded_box(base_width,belt_holder_thick,motor_mount_height,4,0,0,0,1);
  
    translate([-base_width/2 + 3/2,- base_thick/2 - belt_holder_thick/2 - belt_holder_thick/2 + 3/2,-base_height/2 + motor_mount_height/2]) cylinder(d=3,h=motor_mount_height,$fn=16,center=true);
  
    translate([motor_width/2 - base_width/2 + x_motor_offset - 8,-motor_width/2 - base_thick/2 - 20/2 + 3/2,-base_height/2 + motor_mount_height/2]) cylinder(d=3,h=motor_mount_height,$fn=16,center=true);
  
    translate([-base_width/2 + 3/2,-motor_width/2 - base_thick/2 - 20/2 + 3/2,-base_height/2 + motor_mount_height/2]) cylinder(d=3,h=motor_mount_height,$fn=16,center=true);
  }
  
  translate([-base_width/2 + belt_holder_height/2,-motor_width/2 - base_thick/2 - belt_holder_width/2,-base_height/2 + motor_mount_height/2]) rounded_box(belt_holder_height,motor_width + belt_holder_width,motor_mount_height,3,1,0,0,0);
}

module x_carriage_holes()
{  
  // Otvory pro pridelani na vozik kolejnice
  MGN12_holes = [
	[10, 0, 10],
	[10, 0, -10],
	//[-10, 0, -10],
	[-10, 0, 10]
  ];
  
  // Otvory pro prisroubovani na carriage 
  for (a = MGN12_holes)
  translate(a + [0,base_thick/2 - mount_screw_offset,0]) 
  {
	rotate([90,0,0]) screw_hole();
  } 
  //Vyrez pro imbusovy klic
  translate([10, -5, -10]) rotate([90,0,0]) cylinder(d=4,h=100,$fn=32);
  
  // Vyrez
  translate([0,-base_thick/2 - base_thick,-base_height/2 + motor_mount_height + base_thick]) rotate([0,90,0]) cylinder(d=2*base_thick,h=base_width + 1, $fn = 64,center=true);  
   
  // Vyrez pro lozisko
  translate([motor_width/2 - base_width/2 + x_motor_offset,-motor_width/2 - base_thick/2,0]) rotate([0,0,90]) 
  {
	difference()
	{
	  union()
	  {
	    translate([0,10,base_height/2 + MGN12_holes[1][2] - M3_head_D/2]) cylinder(d=20, h = base_height, $fn = 32, center=true);
      
	  	translate([0,-motor_width + 10,base_height/2 + MGN12_holes[1][2] - M3_head_D/2]) cube([20,2*motor_width,base_height],center=true);
	  }
	  
	  translate([0,10,-base_height/2 + (rail_holder_height + rail_H/2)/2 - idler_H/4 - nut_and_washer_height/2]) cylinder(d=9.8, h = rail_holder_height + rail_H/2 - idler_H/2 - nut_and_washer_height, $fn = 32, center=true);
	}
	
	// Otvor pro sroub
	translate([0,10,idler_nut_H + layer_height]) cylinder(d=idler_screw_D,h=base_height,$fn=16,center=true);
    translate([0,10,-base_height/2]) cylinder(d=idler_nut_D,h=2*idler_nut_H,$fn=6,center=true);
  }

  // Otvory na pridelani kolejnice pojezdu X 
  translate([base_width/2 + rail_first_hole,base_thick/2 + rail_W/2 - base_thick,-base_height/2]) rail_holes(2);
  
  // Vyrez pro srouby (drzak remenu)
  translate([-base_width/2 + belt_holder_height/2 + 2,-motor_width - base_thick/2 - belt_holder_width + M3_head_D/2 + 2,0])
  {
	translate([0,0,-base_height/2 + belt_holder_length - 6]) rotate([0,-90,180]) nut_hole(0);
	translate([0,0,-base_height/2 + 6]) rotate([0,90,0]) nut_hole(0);
  }
  
}

// Cela soucastka
module x_carriage()
{
  difference()
  {
    x_carriage_base();
    x_carriage_holes();
  }
}

mirror([0,1,0])
x_carriage();