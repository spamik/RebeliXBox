/* 
   === RebeliX BoX ===

   y idler
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;

// Tloustka steny
wall_thick = 5;

part_depth = 27;
part_width = idler_H+2*wall_thick+3;
base_thickness = 10;

// Posun loziska od stredu profilu
bearing_center_offset = profile_width/2 - 7.25;

holder_height = idler_OUT_D2 + 2;

part_height = holder_height + M6_head_D + 4;

// Posun loziska
bearing_offset = part_height - holder_height/2;

module y_idler_base()
{
  // Zakladna
  translate([bearing_center_offset/2,-part_depth/2 + base_thickness/2,0]) rounded_box(part_width + bearing_center_offset,base_thickness,part_height,3,0,1,1,1);
  
  translate([bearing_center_offset,0,-part_height/2 + holder_height/2]) rounded_box(part_width,part_depth,holder_height,3,0,0,0,1);
  
  // Vyrez pro profil
  translate([0,-part_depth/2,0]) cube([8,3,part_height],center=true);
}

module y_idler_cuts()
{	
  y_bearing_offset = part_depth/2 - idler_OUT_D2/2;  
	
  difference()
  {
    // Vyrez pro lozisko
    translate([bearing_center_offset,base_thickness,-0.1]) cube([part_width-2*wall_thick,part_depth,part_height+1],center=true);
    // Mezera pro loziska
    translate([-part_width/2 + wall_thick + 1.6/2 -0.1 + bearing_center_offset,y_bearing_offset,part_height/2 - bearing_offset]) rotate([0,90,0]) cylinder(r1=5,r2=3.1,h=1.6,center=true);
    translate([part_width/2 - wall_thick - 1.6/2 + 0.1 + bearing_center_offset,y_bearing_offset,part_height/2 - bearing_offset]) rotate([0,-90,0]) cylinder(r1=5,r2=3.1,h=1.6,center=true);
  }
  
  // Otvor pro sroub na lozisko
  translate([bearing_center_offset,y_bearing_offset,part_height/2 - bearing_offset])
  {
    // Otvor pro sroub
	rotate([0,90,0]) cylinder(d=idler_screw_D, h = part_width+1, $fn = 30,center=true);
    // Otvor pro hlavu sroubu
    translate([part_width/2,0,0]) rotate([0,90,0])cylinder(d=idler_screw_head_D,h=2*idler_screw_head_H,$fn=32,center=true);
    // Otvor na matku
    translate([-part_width/2,0,0]) rotate([0,90,0]) cylinder(d=idler_nut_D, h = 2*idler_nut_H ,$fn=6,center=true);	
  }
  
  // Otvor na prisroubovani do kombistojky
  translate([0,-part_depth/2 + M6_screw_offset,part_height/2 - M6_head_D/2 - 4/2]) rotate([-90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  // Vyrez pro profilovou matku
  translate([0,-part_depth/2 -3/2,part_height/2 - M6_head_D/2 - 4/2]) rotate([0,0,90]) profile_nut(10);
	
  // Setreni plastem
  translate([bearing_center_offset - part_width/2 - 1/2,part_depth/2,-part_height/2 + holder_height/2 + 2]) rotate([20,0,0]) cube([part_width+1,10,40]);
  
  translate([bearing_center_offset + part_width/2 + 1/2,part_depth/2,-part_height/2 + holder_height/2 - 2]) rotate([180 + 20,0,180]) cube([part_width+1,10,40]);
   
  // Lozisko
  %translate([bearing_center_offset,y_bearing_offset,part_height/2 - bearing_offset]) rotate([0,90,0]) cylinder(d = idler_OUT_D2, h = idler_H, $fn = 30,center=true);
}

module y_idler()
{
  difference()
  {
	y_idler_base();
	y_idler_cuts();
  }	
}

// Cela soucastka
y_idler();  

translate([0,30,0]) mirror([0,1,0]) y_idler();  