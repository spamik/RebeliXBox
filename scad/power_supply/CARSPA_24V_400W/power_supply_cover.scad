/* 
   === RebeliX BoX ===

   power supply CarSPA 24V/400W
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

include <../../inc/functions.scad>
use <../../inc/text_RebeliX.scad>

hole_length = 114.8;
hole_height = 50.9;
hole_width = 55;

wall_W = 4 - 1;
bottom_thick = 2;

alu_W = 1.5;
alu_wing_W = hole_width - 19;

box_length = hole_length + wall_W;
box_height = hole_height + 2*wall_W;
box_width = hole_width + wall_W + 20;

// Sirka EURO konektoru
power_plug_W = 50;
// Vydalenost sroubu na EURO konektoru
power_plug_screws_dist = 40;

power_switch_W = 19.2;

cable_dist = 16;
cable_length = 58 - 45;
cable_offset = 20 + alu_W;
cable_hole_dia = 8;

side_mount_screws_dist = 25;
side_mount_screws_offset = -0.8;

back_mount_screws_dist = 50;
back_mount_screws_offset = 0.6;

lock_dist = 7.6;
lock_dia = 3;
lock_height = 20;
lock_length = 0;
lock_thick = 2*alu_W;

profile_holder = 1;

module power_supply_holder_base()
{
  rounded_box(box_length,box_height,box_width,3,1,1,1,1);
  
  // Vystupky pro sroubky na prichyceni na zdroj
  translate([-hole_length/2 + wall_W/2 + hole_length/2 + back_mount_screws_dist/2 + back_mount_screws_offset,-box_height/2,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([90,0,0]) cylinder(d1=13,d2=9,h=5,$fn=32,center=true);
  
  translate([-hole_length/2 + wall_W/2 + hole_length/2 - back_mount_screws_dist/2 + back_mount_screws_offset,-box_height/2,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([90,0,0]) cylinder(d1=13,d2=9,h=5,$fn=32,center=true);
  
  // Packa pro prichyceni k profilu
  if(profile_holder)
  {
    translate([box_length/2 + profile_width/2 - lock_thick/2 + 0.3,-box_height/2 + 10/2 + wall_W + profile_width,-box_width/2 + profile_width/2]) rounded_box(profile_width + lock_thick,10,profile_width,4,0,0,1,0);
	
	translate([box_length/2 + profile_width/2 + 0.3,-box_height/2  + wall_W + profile_width,-box_width/2 + profile_width/2]) cube([8,3,profile_width],center=true);
  }
}

module power_supply_holder_cuts()
{
  // Otvor pro M6
  if(profile_holder)
  {
    translate([box_length/2 + profile_width/2 + 0.3,-box_height/2  + wall_W + profile_width + 6,-box_width/2 + profile_width/2]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
    translate([box_length/2 + profile_width/2 + 0.3,-box_height/2  + wall_W + profile_width - 3/2,-box_width/2 + profile_width/2]) rotate([0,0,90]) profile_nut(10);
  
    translate([box_length/2 + 1/2,-box_height/2  + wall_W + profile_width,-box_width/2 + profile_width/2]) cylinder(d=1.2,h=profile_width,$fn=16,center=true);  
  }
  
  difference()
  {  
    difference()
    {
      union()
	  {
	    translate([wall_W/2 + 0.1/2,0,hole_width - box_width/2 + bottom_thick + hole_width/2 - alu_wing_W/2]) cube([hole_length + 0.1,hole_height,hole_width],center=true);
	  
	    // Vyrez pro hranu zdroje
	    translate([wall_W/2 + 0.1/2,-lock_height/4 - 2 - hole_height/4 ,hole_width - box_width/2 + bottom_thick + hole_width/2 - alu_wing_W/2 - 2]) cube([hole_length + 0.1,(hole_height - (lock_height + 8))/2,hole_width],center=true);
	 
	    translate([wall_W/4,0,hole_width - box_width/2 + bottom_thick]) rounded_box(hole_length - alu_W - lock_thick,hole_height,2*hole_width,6,1,1,1,1);
	  }
	  
	  // Vystupky pro sroubky EURO konektoru
      translate([-box_length/2 + 40,box_height/2 - 5/2,-box_width/2 + power_plug_W/2 + alu_W/2 + power_plug_screws_dist/2]) rotate([90,0,0]) cylinder(d1=13, d2=5,h=5,$fn=32,center=true);
	
	  translate([-box_length/2 + 40,box_height/2 - 5/2,-box_width/2 + power_plug_W/2 + alu_W/2 - power_plug_screws_dist/2]) rotate([90,0,0]) cylinder(d1=13, d2=5,h=5,$fn=32,center=true);
	  
	  // Vyztuha pro zacvaknuti
	  translate([hole_length/2 + wall_W/2 - lock_thick/2 - alu_W,0,-box_width/2 + wall_W + alu_wing_W + lock_dist - 8.5 - hole_width/2 + 20/2]) rotate([0,0,0]) cube([2*alu_W,lock_height + 8,hole_width],center=true);
    }
	// Packa na zacvaknuti
    difference()
	{
	  union()
	  {
	    translate([hole_length/2 + wall_W/2 - lock_thick/2,-lock_height/2,-box_width/2 + wall_W + alu_wing_W + lock_dist]) rotate([0,90,0]) cylinder(d=lock_dia,h=lock_thick,$fn=32,center=true);
  
        translate([hole_length/2 + wall_W/2 - lock_thick/2,lock_height/2,-box_width/2 + wall_W + alu_wing_W + lock_dist]) rotate([0,90,0]) cylinder(d=lock_dia,h=lock_thick,$fn=32,center=true);
  
        translate([hole_length/2 + wall_W/2 - lock_thick/2,0,-box_width/2 + wall_W + alu_wing_W + lock_dist]) rotate([0,0,0]) cube([lock_thick,lock_height,lock_dia],center=true);
	  }
	  translate([hole_length/2 + wall_W/2 - lock_thick/2 + 2,0,-box_width/2 + wall_W + alu_wing_W + lock_dist - 2.5]) rotate([0,-40,0]) cube([lock_thick,lock_height + 10,lock_dia],center=true);
	  
	  translate([hole_length/2 + wall_W/2 - lock_thick/2 + 2,0,-box_width/2 + wall_W + alu_wing_W + lock_dist + 2.5]) rotate([0,-40,0]) cube([lock_thick,lock_height + 10,lock_dia],center=true);
    }	  
  
    translate([hole_length/2 + wall_W/2 - lock_thick/2 - alu_W/2,0,-box_width/2 + wall_W + alu_wing_W + lock_dist - 8.5]) rotate([0,0,0]) cube([alu_W,lock_height + 8,20],center=true);
  }	
  
  // Vyrez pro EURO konektoru
  translate([-box_length/2 + 40,box_height/2,-box_width/2 + power_plug_W/2 + alu_W/2]) rotate([0,90,90]) euro_connector();
  
  // Otvor pro vypinac
  translate([-box_length/2 + 15,box_height/2 - 1.3,-box_width/2 + power_switch_W/2 + alu_W/2 + 2*wall_W]) rotate([90,0,0]) power_switch();
  
  // Otvor pro kabely pro napajeni elektroniky
  translate([hole_length/2 - cable_hole_dia/2 - cable_offset,-hole_height/2 + 16,-box_width/2]) 
  {
    cylinder(d=cable_hole_dia,h=50,$fn=32,center=true); 
    translate([-cable_length,0,0]) cylinder(d=cable_hole_dia,h=50,$fn=32,center=true);
	translate([-cable_length/2,0,0]) cube([cable_length,cable_hole_dia,50],center=true);
  }	
  
  // Seriznuti krytu
  translate([hole_length/2,-20,70]) rotate([0,-40,0]) cube([box_height ,box_height,2*box_height],center=true);
  
  translate([hole_length/2 + 5,box_height/2,box_height + 6]) rotate([0,-40,0]) cube([box_height ,box_height,box_height],center=true);

  // Vyrez krytu horni cast
  difference() 
  {
    translate([0,wall_W,-box_width/2 + wall_W + hole_width/2 + hole_width + 10]) cube([box_length,hole_height + 2*wall_W,hole_width],center=true);

    translate([-hole_length/2 - 35,0,box_height]) rotate([0,-30,0]) cube([box_height ,2*box_height,2*box_height],center=true);
  }
  
  // Otvory pro pridelani na zdroj
  translate([-hole_length/2,side_mount_screws_dist/2 + side_mount_screws_offset,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([0,90,0]) cylinder(d=5,h=50,$fn=32,center=true);
  
  translate([-hole_length/2,-side_mount_screws_dist/2 + side_mount_screws_offset,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([0,90,0]) cylinder(d=5,h=50,$fn=32,center=true);
  
  translate([-hole_length/2 + wall_W/2 + hole_length/2 + back_mount_screws_dist/2 + back_mount_screws_offset,-box_height/2,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([90,0,0]) cylinder(d=5,h=50,$fn=32,center=true);
  
  translate([-hole_length/2 + wall_W/2 + hole_length/2 - back_mount_screws_dist/2 + back_mount_screws_offset,-box_height/2,-box_width/2 + wall_W + alu_wing_W + 32.5]) rotate([90,0,0]) cylinder(d=5,h=50,$fn=32,center=true);
  
  // Text RebeliX
  translate([0,box_height/2 + 1.4,20]) mirror([1,0,0]) rotate([90,180,0]) scale([0.7,0.7,1]) text_RebeliX(2);
  
  translate([0,-box_height/2 + 2 - 1.4,0]) mirror([0,0,0]) rotate([90,180,0]) scale([1,1,1]) text_RebeliX(2);
}

module euro_connector()
{
  difference()
  {
    cube([27.8,19.8,10],center=true);
    translate([7.5,19.8/2,-10]) rotate([0,0,-45]) cube([20,20,20]);
	translate([-7.5,19.8/2,-10]) rotate([0,0,135]) cube([20,20,20]);
  }
  // Otvory pro srouby
  translate([power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  translate([-power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
}

module power_switch()
{
  // Vyrez pro vypinac
  translate([0,0,10/2]) cube([7,22,10],center=true);
  cube([13,power_switch_W,20],center=true);
}

module power_supply_holder()
{
  difference()
  {
    power_supply_holder_base();
	power_supply_holder_cuts();
  }
}

power_supply_holder();