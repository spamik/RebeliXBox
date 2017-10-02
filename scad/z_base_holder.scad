/* 
   === RebeliX BoX ===

   z base holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

M6_screw_offset = M6x14_offset;

// Prumer linearniho lozisk
//D_bearing = 15; // LM8UU
D_bearing = 19.1; // LM10LUU
//D_bearing = 21; // LM12UU

// Delka linearniho loziska
//L_bearing = 24; // LM8UU
L_bearing = 55.3; // LM10LUU
//L_bearing = 30; // LM12UU

// Vzdalenost lozisek
bearing_distance = 2;

// Sirka zakladny lozisek
base_width = D_bearing + 18;

// Delka zakladny lozisek
base_length = L_bearing + 6;

// Vyska zakladny
base_height = profile_width/2;

// Vzdalenost okraje profilu od stredu lozisek
holder_offset = 38.5 + mount_dia/2 - rod_offset;

// Pozice drzaku profilu
holder_height = profile_width + 9;

module Z_holder_base()
{  
   // Mezera mezi uchytem loziska a drzakem profilu
   gap = 1;
   
   // Zakladna pro loziska
   rounded_box(base_width,base_length,base_height,corner_rad,1,1,1,1);
   
   translate([base_width/2 + gap/2,-base_length/2 + holder_height/2,0]) rounded_box(2*corner_rad + gap,holder_height,base_height,corner_rad,1,1,1,1);
 
   // Zakulaceny roh   
   translate([base_width/2,-base_length/2 + holder_height,0]) rotate([0,0,180]) fillet(3,base_height,64);
 
   // Drazka pro profil
   translate([holder_offset + profile_width/2,-base_length/2 + holder_height,-base_height/2 + profile_width/2]) cube([8,3,profile_width],center=true);
 
   // Drzak hlinikoveho profilu
   translate([holder_offset/2 + profile_width/2 + base_width/4 + gap/2,-base_length/2 + holder_height - profile_width/2,-base_height/2 + profile_width/2]) rounded_box(profile_width + holder_offset -base_width/2 - gap,profile_width,profile_width,2,1,1,1,1);
 
   translate([holder_offset + profile_width + 5/2 + 0.2,-base_length/2 + holder_height - profile_width/2 + 5/2,-base_height/2 + profile_width/2]) rounded_box(5,profile_width + 5,profile_width,2,1,1,1,1);
   
   translate([holder_offset/2 + profile_width/2 + base_width/4 + gap/2 + 5/2,-base_length/2 + holder_height - profile_width/2,-base_height/2 + profile_width/2]) rounded_box(profile_width + holder_offset -base_width/2 - gap + 5,profile_width,profile_width,2,1,1,1,1);
 
 
   translate([base_width/2 + gap,0,-base_height/2]) linear_extrude(height = profile_width)
   {
     hull()
     {
	   translate([corner_rad/2,-base_length/2 + corner_rad/2,0]) circle(d=corner_rad,$fn=16,center=true);
       
       translate([-base_width/2 + holder_offset + profile_width/2 - M6_head_D/2 - corner_rad/2,-base_length/2 + holder_height - profile_width + corner_rad/2,0]) circle(d=corner_rad,$fn=16,center=true);
       
	   translate([corner_rad/2,-base_length/2 + holder_height - profile_width + corner_rad/2,0]) circle(d=corner_rad,$fn=16,center=true);
     }
   }	 
}

module Z_holder_holes()
{ 
  // Vyrez pro lozisko
  translate([0,0,base_height/2]) rotate([0,0,-270]) linear_bearing(1);
 
  // Otvor pro sroub M6
  translate([holder_offset + profile_width/2,-base_length/2 + holder_height -M6_screw_offset,-base_height/2 + profile_width/2]) rotate([90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
 
  // Vyrez pro profilovou matku
  translate([holder_offset + profile_width/2 ,-base_length/2 + holder_height + 3/2,-base_height/2 + profile_width/2]) rotate([0,0,-90]) profile_nut(10);
  
  translate([holder_offset + profile_width - 0.3 + 0.2,-base_length/2 + holder_height + 0.3,-base_height/2 + profile_width/2]) cylinder(d=1,h=profile_width + 1,$fn=16,center=true);
}

module linear_bearing(nut=1)
{
  gap = 0.4;
  M3_offset = 7;
  
  hole_distance = D_bearing + (base_width - D_bearing)/2;
  
  // Pozice otvoru pro pridelani lozisek
  screws_pos = [
  [L_bearing/4,hole_distance/2,-M3_offset],
  [L_bearing/4,-hole_distance/2,-M3_offset],
  [-L_bearing/4,hole_distance/2,-M3_offset],
  [-L_bearing/4,-hole_distance/2,-M3_offset]
  ];
  
  // Lozisko
  rotate([0,90,0]) cylinder(d=D_bearing, h=L_bearing + gap, $fn=64, center=true);

  // Vyrez pro tyc
  rotate([0,90,0]) cylinder(d=D_bearing - 3, h=2*L_bearing, $fn=32, center=true);
  
  // Otvory pro pridelani drzaku loziska
  for (a = screws_pos)
  translate(a)
  {
    translate([0,0,20/2 + layer_height]) cylinder(d=M3_screw_D, h=20,$fn = 16, center=true);
	  
	if(nut)
	{
	  // Vyrez pro maticku
	  translate([0,0,-20/2]) cylinder(d=M3_nut_D, h=20,$fn = 6, center=true);
	} else 
	{
	  // Vyrez pro podlozku 
	  translate([0,0,-20/2]) cylinder(d=M3_washer_D, h=20,$fn = 16, center=true);
	}
  }
}

module bearing_cover_base()
{
  base_offset = 0.5;
  
  translate([0,0,-base_offset/2]) rounded_box(base_width,base_length,base_height - base_offset,corner_rad,1,1,1,1);
}

module bearing_cover_cuts()
{
  translate([0,0,base_height/2]) rotate([0,0,270]) linear_bearing(0);
}

module Z_holder()
{
  difference()
  {
	Z_holder_base();
    Z_holder_holes();
  } 
}

module bearing_cover()
{
  difference()
  {
	bearing_cover_base();
	bearing_cover_cuts();
  }

}

// Strana 1
translate([0,base_length + 5,0])
rotate([0,0,180]) 
Z_holder();

translate([43,base_length + 5,0])
bearing_cover();


// Strana 2
mirror([1,0,0])
Z_holder();

translate([43,0,0])
bearing_cover();



