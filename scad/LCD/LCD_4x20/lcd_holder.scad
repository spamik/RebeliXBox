/* 
   === RebeliX BoX ===

   LCD holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../../configuration.scad>
include <../../inc/functions.scad>

part_thick = 6;
part_height = 15;
base_length = profile_width + 11;

// Delka ramena pro pridelani LCD
holder_length = 44;

// Uhel natoceni drzaku
angle = 25;

$fn=32;

M6_head_offset = 8; // pro M6x14

screw_distance = 25;

// LCD HEIGHT (z lcd_case.scad)
HEIGHT=82 - 11;

module lcd_holder_base()
{
  translate([0,-base_length/2,0]) rounded_box(part_thick,base_length,part_height,5,1,0,0,0);
  
  hull()
  {
    cylinder(d=part_thick,h=part_height,center=true);
    rotate([0,0,angle]) translate([0,holder_length,0]) cylinder(d=part_thick,h=part_height,center=true);
  }
  
  // Prichyceni na profil
  translate([part_thick/2,-base_length + profile_width/2,0]) cube([3,8,part_height],center=true);
}

module lcd_holder_cuts()
{
  // M6 sroub
  translate([0,-base_length + profile_width/2,0]) rotate([0,90,0]) cylinder(d=M6_screw_D, h=30, $fn = 32, center=true);
  
  // Vyrez pro profilovou matku
  translate([part_thick/2 + 3/2,-base_length + profile_width/2,0]) rotate([0,0,180]) profile_nut(10);
  
  // Otvory na prichyceni k LCD
  rotate([0,0,angle]) translate([0,16,0]) rotate([0,90,0]) cylinder(d=M3_screw_D,h=30,center=true);
  
  rotate([0,0,angle]) translate([0,16 + screw_distance,0]) rotate([0,90,0]) cylinder(d=M3_screw_D,h=30,center=true);
}

module lcd_holder()
{
  difference()
  {
	lcd_holder_base();
	lcd_holder_cuts();
  }
}

lcd_holder();