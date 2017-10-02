/* 
   === RebeliX BoX ===

   spool holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;

// Pro jakou maximalni sirku civky ma drzak byt
spool_max_W = 90;

// Minimalni prumer stredu civky
spool_min_center_D = 31;

// Sirka zarazky civky
mantinel_W = 5;

part_L = 2*mantinel_W + spool_max_W + profile_width;
part_H = spool_min_center_D;
part_W = spool_min_center_D;

u = spool_min_center_D - 8;
a = u/2 + 4;
b = sqrt((pow(u,2)-pow(a,2))); 

module spool_holder_base()
{ 
  intersection()
  {
    rotate([0,90,0]) cylinder(d=spool_min_center_D - 8,h=spool_max_W,$fn=64,center=true);
    translate([0,b/2,0])cube([spool_max_W,2*b,a],center=true);
  }	
  
  translate([-spool_max_W/2 - mantinel_W/2 + 0.01,0,0]) intersection()
  {
    rotate([0,90,0]) cylinder(d=spool_min_center_D,h=mantinel_W,$fn=64,center=true);
    translate([0,b/2,0])cube([mantinel_W,2*b,a],center=true);
  }	
  
  translate([spool_max_W/2 + mantinel_W/2 - 0.01,0,0]) intersection()
  {
    rotate([0,90,0]) cylinder(d=spool_min_center_D,h=mantinel_W,$fn=64,center=true);
    cube([mantinel_W,2*b,a],center=true);
  }
  
  // Pridelani na profil
  translate([spool_max_W/2 + mantinel_W + profile_width/2 - 0.1,0,0]) rounded_box(profile_width,40,a,6,1,1,1,1);
  
  // Drazka do profilu
  translate([spool_max_W/2 + mantinel_W + profile_width/2 - 0.1,0,a/2]) rotate([0,0,90]) drazka(40);
}

module spool_holder_holes()
{   
  // Otvor pro M6 sroub
  translate([spool_max_W/2 + mantinel_W + profile_width/2 - 0.1,0,a/2 - M6_screw_offset]) rotate([180,0,0]) screw_hole(1,0,M6_head_D,M6_screw_D);
}

// Cela soucastka
module spool_holder()
{
  difference()
  {
    spool_holder_base();
    spool_holder_holes();
  }
}

mirror([0,1,0]) spool_holder();