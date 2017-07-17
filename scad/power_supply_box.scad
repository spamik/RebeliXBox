/* 
   === RebeliX BoX ===

   power supply box
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

part_height = profile_width + 5;
part_width = 52;
part_length = 60;

wall = 3;

sloupek_D = 8;

module power_base()
{
  rounded_box(part_length,part_width,part_height,corner_rad,1,1,1,1);
  
  // Prichyceni na profil
  translate([0,-part_width/2,-part_height/2 + profile_width/2]) rotate([90,0,0]) drazka_vertical(part_length - 6,1);
  translate([-part_length/2,0,-part_height/2 + profile_width/2]) rotate([90,0,-90]) drazka_vertical(part_width - 6,1);
  
}

module power_holes()
{ 
	difference()
	{
	  // Vnitrni vyrez
	  translate([0,0,wall]) rounded_box(part_length - 2*wall,part_width - 2*wall,part_height,corner_rad,1
	,1,1,1);
	
	  // Sloupky pro prisroubovani krytu
	  translate([part_length/2 - wall - 3,part_width/2 - wall - 3,0]) cylinder(d=sloupek_D,h=part_height,$fn=32,center=true);
	  
	  translate([part_length/2 - wall - 3,-part_width/2 + wall + 3,0]) cylinder(d=sloupek_D,h=part_height,$fn=32,center=true);
	  
	  translate([-part_length/2 + wall + 3,-part_width/2 + wall + 3 ,0]) cylinder(d=sloupek_D,h=part_height,$fn=32,center=true);
	  
	  translate([-part_length/2 + wall + 3,part_width/2 - wall - 3,0]) cylinder(d=sloupek_D,h=part_height,$fn=32,center=true);
	}
	
	// Otvory pro srouby
	translate([part_length/2 - wall - 3,part_width/2 - wall - 3,part_height/2]) cylinder(d=2.2,h=part_height,$fn=32,center=true);
	  
	translate([part_length/2 - wall - 3,-part_width/2 + wall + 3,part_height/2]) cylinder(d=2.2,h=part_height,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,-part_width/2 + wall + 3,part_height/2]) cylinder(d=2.2,h=part_height,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,part_width/2 - wall - 3,part_height/2]) cylinder(d=2.2,h=part_height,$fn=32,center=true);
	
	// Vyrez pro kryt
	translate([0,0,part_height/2]) rounded_box(part_length - 2*wall,part_width - 2*wall,4,corner_rad,1
	,1,1,1);
	
	
	// Otvory na pridelani
	translate([0,-part_width/2,-part_height/2 + profile_width/2]) rotate([90,0,0]) cylinder(d=M6_screw_D,h=30,$fn=32,center=true);
	translate([-part_length/2,0,-part_height/2 + profile_width/2]) rotate([0,90,0]) cylinder(d=M6_screw_D,h=30,$fn=32,center=true);
	
	// Otvory pro zip pasky
	//translate([part_length/2 - 6,part_width/2,0]) rotate([0,90,0]) zip_paska(6);
	//translate([0,part_width/2,0]) rotate([0,90,0]) zip_paska(6);
	//translate([-part_length/2 + 6,part_width/2,0]) rotate([0,90,0]) zip_paska(6);
	
	// Otvor pro kabel 230V
	translate([-part_length/2 + 15,-part_width/2 + 10,-part_height/2]) cylinder(d=9.5,h=30,$fn=32,center=true);
	
}

module euro_konektor(){
  difference(){
    cube([27.8,19.8,10],center=true);
    translate([7.5,19.8/2,-10]) rotate([0,0,-45]) cube([20,20,20]);
	translate([-7.5,19.8/2,-10]) rotate([0,0,135]) cube([20,20,20]);
  }
  // Otvory pro srouby
  translate([20,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  translate([-20,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
}

module kryt_base()
{
  rounded_box(part_length,part_width,2,corner_rad,1,1,1,1);
  translate([0,0,2/2]) rounded_box(part_length - 2*wall - 0.3,part_width - 2*wall - 0.3,4,corner_rad,1
	,1,1,1);
}

module kryt_holes()
{
	// Otvory pro srouby
	translate([part_length/2 - wall - 3,part_width/2 - wall - 3,0]) cylinder(d=3,h=part_height,$fn=32,center=true);
	  
	translate([part_length/2 - wall - 3,-part_width/2 + wall + 3,0]) cylinder(d=3,h=part_height,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,-part_width/2 + wall + 3,0]) cylinder(d=3,h=part_height,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,part_width/2 - wall - 3,0]) cylinder(d=3,h=part_height,$fn=32,center=true);
	
	
	translate([part_length/2 - wall - 3,part_width/2 - wall - 3,-0.01]) cylinder(d1=6,d2=3,h=2,$fn=32,center=true);
	  
	translate([part_length/2 - wall - 3,-part_width/2 + wall + 3,-0.01]) cylinder(d1=6,d2=3,h=2,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,-part_width/2 + wall + 3,-0.01]) cylinder(d1=6,d2=3,h=2,$fn=32,center=true);
	  
	translate([-part_length/2 + wall + 3,part_width/2 - wall - 3,-0.01]) cylinder(d1=6,d2=3,h=2,$fn=32,center=true);
	
	// Vyrez pro vypinac
	translate([14,0,2]) cube([7,22,4],center=true);
	translate([14,0,0]) cube([13,19.2,10],center=true);
	
	// Euro konektor
	translate([-8,0,0]) rotate([0,0,-90]) euro_konektor();
}

module kryt()
{
  difference()
  {
    kryt_base();
    kryt_holes();
  }
}


//translate([0,0,part_height/2]) rotate([180,0,0]) 

// Pozice pro tisk
translate([0,-part_width - 2,-part_height/2 + 2/2]) 
kryt();



module power_cover()
{
  difference()
  {
	power_base();
    power_holes();
  } 
}

mirror([1,0,0]) 
power_cover();



