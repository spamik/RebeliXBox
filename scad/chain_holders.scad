/* 
   === RebeliX BoX ===

   chain holders
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;

/* ----------- Parametry energo retezu ----------- */
// Sirka steny drzaku
wall_W = 3;
 
// Parametry pro drzak na kolejnici 
holder_width = chain_W + 2*wall_W;
holder_height = chain_H + 2*wall_W;
holder_length = 15;

mount_length = 18;
mount_offset = rail_W/2 + 15;
mount_height = holder_height + mount_offset;
 
// Zobacek pro zacvaknuti remenu
cut_H = 6.6;
cut_W = 8;
cut_T = 2;

//Vzdalenost od profilu
//chain_x_offset = 1.5;

// Vyska drzaku energo remenu motoru extruderu
motor_base_extra_height = 9;
motor_base_height = chain_mount_W + mantinel_W + motor_base_extra_height;

corner_dia = 3;

module chain_holder_base(holder_length = 15)
{
  translate([-5/2 + 5/2,0,0]) rounded_box(holder_width,holder_height,holder_length,3,1,1,1,1);
}

module chain_holder_cuts(lock=0,holder_length = 15)
{
  difference()
  {
    union()
	{
	  cube([chain_W,chain_H,holder_length + 1],center=true);
	  // Vyrez pro retez
	  translate([holder_width/2,0,0]) cube([chain_W,chain_H - 2,holder_length + 1],center=true);
	}  
	if(lock) // Zobacek pro prichyceni retezu
	  {
	  difference()
	  {
	    translate([0,chain_H/2,-holder_length/2 + cut_H/2]) cube([cut_W,cut_T,cut_H],center=true);
	    translate([-cut_W/2,chain_H/2,-holder_length/2 + cut_H + 1/2]) rotate([0,180,90 + 60]) cube([cut_W,cut_T,cut_H + 1]);
      }	

	  difference()
	  {
        translate([0,-chain_H/2,-holder_length/2 + cut_H/2]) cube([cut_W,cut_T,cut_H],center=true);
	    translate([-cut_W/2,-chain_H/2,-holder_length/2  - 1/2]) rotate([0,0,90 - 60]) cube([cut_W,cut_T,cut_H + 1]);
	  }
	}
  }
}

module x_chain_holder_base()
{  
  // Drzak energetickho retezu
  chain_holder_base(holder_length);
  
  translate([-holder_width/2 - mount_length/2 + wall_W - 1/2,mount_offset,0]) rounded_box(mount_length + 1,rail_W + 4,holder_length,6,0,0,1,0);
  
  hull()
  {
    translate([-holder_width/2 + wall_W/2,mount_offset/2 - holder_height/2 + wall_W/2 + rail_W/4,0]) cube([wall_W,mount_offset + rail_W/2,holder_length],center=true);
  
    translate([-holder_width/2 - mount_length/2,mount_offset,0]) cylinder(d=2,h=holder_length,$fn=32,center=true);
  }
}

module x_chain_holder_cuts(lock = 0)
{ 
  // Vyrez pro retez
  chain_holder_cuts(lock);
  
  // Vyrez pro kolejnici
  translate([-holder_width/2 - mount_length + wall_W - 1,mount_offset,0]) cube([2,rail_W,holder_length + 1],center=true);
 
  // Otvor pro pridelani na kolejnici
  translate([-holder_width/2 - mount_length + 5 + 3.5,mount_offset,0]) rotate([0,-90,0]) nut_hole(0,20);
}

module y_chain_holder_base(top_holder_L = 41)
{  
  y_holder_H = 20;
 
  pos_x = chain_mount_W/2 + chain_x_offset + mantinel_W + profile_width/2;
 
  // Drzak energetickho retezu
  chain_holder_base(y_holder_H);
  
  hull()
  {
    translate([-(holder_width + 10)/2 + 10/2,0,0]) rounded_box(10,holder_height,y_holder_H,3,1,1,1,1); 
  
	translate([-pos_x,-top_holder_L + 1/2,0]) cube([profile_width,1,y_holder_H],center=true);
  }
  
  // Drazka pro prichyceni do profilu
  translate([-pos_x,-top_holder_L + 1/2,0]) cube([8,3,y_holder_H],center=true);
}

module y_chain_holder_cuts(lock = 0, top_holder_L = 41)
{  
  y_holder_H = 20;
  
  pos_x = chain_mount_W/2 + chain_x_offset + mantinel_W + profile_width/2;
  
  // Vyrez pro retez
  chain_holder_cuts(1,y_holder_H);
  
  // Otvory pro prichyceni
  translate([-pos_x,-top_holder_L + M6_screw_offset,0]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([-pos_x-M6_head_D/2,-top_holder_L + 50/2 + M6_screw_offset,0]) cube([M6_head_D,50,M6_head_D],center=true);
  
  translate([-pos_x -20/2 + M6_head_D/2,-top_holder_L + 50/2 + M6_screw_offset,y_holder_H/2]) cube([20,50,y_holder_H],center=true);
  
  // Vyrez pro profilovou matku
  translate([-pos_x,-top_holder_L  - 3/2,0]) rotate([0,0,90]) profile_nut(10);
}

module chain_holder_motor_base()
{ 
  translate([-motor_width/2 + 16/2,0,0]) rounded_box(16,motor_width,motor_base_height,6,1,1,1,1);

  translate([-motor_width/2 + 16/2 + 2/2,motor_width/4,-motor_base_height/2 + (motor_base_height - chain_mount_W)/2]) rounded_box(16 + 2,motor_width/2,motor_base_height - chain_mount_W,6,1,1,1,1);
}

module chain_holder_motor_cuts()
{    
  for (a = motor_mount_holes)
  translate(a + [0,0,-motor_base_height/2 + 6]) 
	{
	  screw_hole(0);
	}
  
  // Vyrez pro drzak retezu
  translate([-motor_width/2 + 15,motor_width/2 - 6,motor_base_height/2 - chain_mount_W/2])
  {
    rotate([0,90,0,]) cylinder(d=2.2,h=20,$fn=32,center=true);
    
	translate([0,-8,0]) rotate([0,90,0,]) cylinder(d=2.2,h=20,$fn=32,center=true);
	translate([0,-10,0]) rotate([0,90,0,]) cylinder(d=2.2,h=20,$fn=32,center=true);
	translate([0,-9,0]) cube([20,2.2,2.2],center=true);
  }
}

/* Drzak retezu */
module chain_holder(lock,holder_length)
{
  difference()
  {
    chain_holder_base(holder_length);
    chain_holder_cuts(lock,holder_length);
  }
}

/* Drzak retezu pro osu X */
module x_chain_holder(lock,holder_lengt)
{
  difference()
  {
    x_chain_holder_base(holder_lengt);
	x_chain_holder_cuts(lock,holder_lengt);
  }
}

/* Drzak retezu pro osu Y */
module y_chain_holder()
{
  difference()
  {
    y_chain_holder_base();
	y_chain_holder_cuts();
  }
}

/* Drzak retezu na motor Extruderu */
module chain_holder_motor()
{
  difference()
  {
    chain_holder_motor_base();
	chain_holder_motor_cuts();
  }
}

/*Drzaky energetickeho retezu*/
translate([15,20,0]) 
y_chain_holder(1);

translate([15,75,0]) 
y_chain_holder(1);


/*translate([0,110,motor_base_height/2 - 20/2]) 
rotate([0,0,90]) 
chain_holder_motor();
*/

translate([60,0,-20/2 + 15/2])
{ 
  x_chain_holder(1);
  translate([0,22 + mount_offset,0]) x_chain_holder();
  translate([0,65 + mount_offset,0]) x_chain_holder();
}
