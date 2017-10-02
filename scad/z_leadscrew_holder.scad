/* 
   === RebeliX BoX ===

   z leadscrew holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

/* ----------- Parametry pro idler ----------- */

// Vyska matky + podlozky pod lozisky
//nut_and_washer_height = 4;
nut_and_washer_height = 5.8; // S pojistnou matkou

part_width = big_bearing_OUT_D + 2*10;
part_depth = big_bearing_OUT_D + 10;
part_height = profile_width + 4;

// Zapusteni sroubu
M6_screw_offset = M6x14_offset;
motor_screw_offset = M3x10_offset;
M3_screw_offset = 4;

// Delka sroubu pro prisroubovani idleru
idler_screw_length = 35;

cover_height = big_bearing_H + 2;

// Offset kladek
bearing_offset = part_depth/2 + idler_OUT_D1/2 + 0.5;

// Vyska sloupku pro kladky
sloupek_H = pulley_teeth_offset - idler_Flange_H - idler_washer_H;

// Drzak remenu - delka ramena
bearing_holder_length = part_depth/2 + idler_OUT_D2 + pulley_gear_D + 2*(belt_thick - belt_tooth_height) + idler_OUT_D1/2 + bearing_offset;

// Sirka ramena
bearing_holder_width = part_width - (GT2_pulley_gear_D + 2*belt_core_thickness + idler_OUT_D2);

motor_center_offset =  part_depth/2 + bearing_offset + idler_OUT_D2 + pulley_gear_D/2 + belt_thick - (belt_tooth_height + idler_OUT_D2/2);

motor_holder_length = motor_center_offset + motor_width/2 + profile_width;
motor_holder_width = motor_width;
motor_holder_base_height = 6;
motor_holder_height = part_height - (sloupek_H + part_height - pulley_H) +  motor_holder_base_height + 4;

// Pozice kladky 1
idler_1_pos =  bearing_holder_length/2 - part_depth/2 - bearing_offset;
// Pozice kladky 2
idler_2_pos = idler_1_pos - idler_OUT_D2 - pulley_gear_D - 2*(belt_thick - belt_tooth_height);
// Pozice napinaci kladky 
idler_tens_pos = idler_1_pos + (idler_2_pos - idler_1_pos)/2;

idler_tens_width = bearing_holder_width + M6_washer_D;

// Radius zakulacenych rohu
corner_rad = 6;

module z_leadscrew_holder_base(motor_part = 1)
{ 
  rounded_box(part_width,part_depth,part_height,corner_rad,1,0,0,1);
 
  translate([0,part_depth/2 - 10/2,0]) rounded_box(part_width + 2*15,10,part_height,3,1,0,0,1);
  
  // Drazka pro pridelani na profil
  translate([0,part_depth/2,part_height/2 - profile_width/2]) rotate([90,0,180]) drazka_vertical(part_width + 2*15,0);
  
  if(motor_part)
  {
    // Rameno drzaku lozisek
    translate([part_width/2 - bearing_holder_width/2,part_depth/2 - bearing_holder_length/2,-pulley_H/2]) bearing_holder_base();
	
	// Zakulaceny roh
	translate([part_width/2 - bearing_holder_width,-part_depth/2,- pulley_H/2]) fillet(8,part_height - pulley_H,64);
  }
}

module Z_leadscrew_holder_cuts(motor_part = 1)
{
  // Vyrez lozisek
  translate([0,0,-part_height/2 + profile_width - (axial_bearing_H1 + axial_bearing_H2 + big_bearing_H + pulley_H - 4)]) bearing_cut();
   
  // Otvor pro M3 srouby
  translate([part_width/2 - 5,0,part_height/2 - M3_screw_offset]) nut_hole(1);
  translate([-part_width/2 + 5,0,part_height/2 - M3_screw_offset]) rotate([0,0,180]) nut_hole(1);
  
  // Otvory pro M6 srouby
  translate([part_width/2 + 15/2,part_depth/2 - M6_screw_offset,part_height/2 - profile_width/2]) rotate([90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  translate([-part_width/2 - 15/2,part_depth/2 - M6_screw_offset,part_height/2 - profile_width/2]) rotate([90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  // Vyrez pro profilovou matku
  translate([-part_width/2 - 15/2,part_depth/2 + 3/2,part_height/2 - profile_width/2]) cube([profile_nut_W,3,10],center=true);
  
  translate([part_width/2 + 15/2,part_depth/2 + 3/2,part_height/2 - profile_width/2]) cube([profile_nut_W,3,10],center=true);
    
  // Vyrez poklopu
  translate([0,0,part_height/2 + big_bearing_H/2 - 2]) cylinder(d=big_bearing_OUT_D + 3.3,h=big_bearing_H,$fn=64,center=true);
  
  translate([0,-part_depth/2,part_height/2 + big_bearing_H/2 - 2]) cube([big_bearing_OUT_D + 3.3,part_depth,big_bearing_H + 0.01],center=true);
  
  if(motor_part)
  {  
    // Otvory pro loziska
    translate([part_width/2 - bearing_holder_width/2,part_depth/2 - bearing_holder_length/2,-pulley_H/2]) bearing_holder_cuts();
  }	
}

module bearing_holder_base()
{
  // Rameno pro lozisko
  rounded_box(bearing_holder_width,bearing_holder_length,part_height - pulley_H,4,1,0,0,1);
  
  translate([0,0,sloupek_H/2])
  {
    // Lozisko 1
	  translate([0,idler_1_pos,0]) cylinder(d=10,h=sloupek_H + part_height - pulley_H,$fn=64,center=true);
    // Lozisko 2
    translate([0,idler_2_pos,0]) cylinder(d=10,h=sloupek_H + part_height - pulley_H,$fn=64,center=true);
  }
}

module bearing_holder_cuts()
{
  translate([0,0,(part_height - pulley_H)/2 + sloupek_H - (idler_screw_length - 17)])
  {
    // Osicka pro lozisko 1
	  translate([0,idler_1_pos,0]) rotate([180,0,0]) screw_hole(1,0,idler_nut_D,idler_screw_D,6);
	
    // Osicka pro lozisko 2
	  translate([0,idler_2_pos,0]) rotate([180,0,0]) screw_hole(1,0,idler_nut_D,idler_screw_D,6);
  }
}

module z_motor_holder_base()
{
  // Zakladna
  rounded_box(motor_holder_width,motor_holder_length,motor_holder_base_height,6,1,1,1,1);
  
  // Drazka pro profil
  translate([0,-motor_holder_length/2 + profile_width/2,motor_holder_base_height/2]) drazka(motor_holder_width);
  
  translate([0,motor_holder_length/2 - motor_width/2,-motor_holder_base_height/2 + motor_holder_height/2]) rounded_box(motor_holder_width,motor_width,motor_holder_height,6,1,1,1,1);
  
  translate([motor_holder_width/4,motor_holder_length/2 - (motor_holder_length - profile_width)/2,-motor_holder_base_height/2 + motor_holder_height/2]) rounded_box(motor_holder_width/2,motor_holder_length - profile_width,motor_holder_height,6,1,1,1,1);
}

module z_motor_holder_cuts()
{ 
  // Vyrez pro motor
  translate([0,motor_holder_length/2 - motor_width/2,-motor_holder_base_height/2 + motor_holder_height]) rotate([180,0,180]) nema17([1,1,1,1],1,motor_screw_offset,1,0);
  
  // Otvor pro M6 sroubu
  translate([0,-motor_holder_length/2 + profile_width/2,0]) cylinder(d=M6_screw_D,h=20,$fn=32,center=true);
  
  // Prichyceni kabelu od motoru
  translate([motor_width/4,motor_holder_length/2 - motor_width - 8,-motor_holder_base_height/2 + motor_holder_height]) rotate([90,0,0]) zip_paska(5);
  
  translate([motor_width/4,-motor_holder_length/2 + profile_width + 8,-motor_holder_base_height/2 + motor_holder_height]) rotate([90,0,0]) zip_paska(5);
}

module bearing_cut()
{
  space = 0.6;

  // Axialni lozisko
  difference()
  {
    union()
	{
	  // Stred
	  translate([0,0,100/2]) cylinder(d=big_bearing_CENTER_D,h=100,$fn=64,center=true);
	  translate([0,0,axial_bearing_H1/2]) cylinder(d=axial_bearing_D,h=axial_bearing_H1,$fn=64,center=true);
	}
	translate([0,0,axial_bearing_H1/2 - 0.01]) cylinder(d=5,h=axial_bearing_H1,$fn=64,center=true);
  }	
  translate([0,0,axial_bearing_H1 + axial_bearing_H2/2]) cylinder(d=axial_bearing_D,h=axial_bearing_H2 + 0.01,$fn=64,center=true);
  
  // Lozisko 608
  translate([0,0,axial_bearing_H1 + axial_bearing_H2 + big_bearing_H/2]) cylinder(d=big_bearing_OUT_D,h=big_bearing_H + space,$fn=64,center=true);
  
  // Ozubene kolo
  translate([0,0,axial_bearing_H1 + axial_bearing_H2 + big_bearing_H + pulley_H/2]) cylinder(d=big_bearing_OUT_D,h=pulley_H + 0.01,$fn=64,center=true);

  translate([0,-part_depth/4,axial_bearing_H1 + axial_bearing_H2 + big_bearing_H + pulley_H/2]) cube([big_bearing_OUT_D,part_depth/2 + 0.01,pulley_H + 0.01],center=true);
  
  // Lozisko 608
  translate([0,0,axial_bearing_H1 + axial_bearing_H2 + big_bearing_H + pulley_H + big_bearing_H/2]) cylinder(d=big_bearing_OUT_D,h=big_bearing_H,$fn=64,center=true);
}

module cover_base()
{
  rounded_box(part_width,part_depth,cover_height,6,1,1,1,1);
  
  translate([0,0,cover_height/2 - big_bearing_H/2 + 1.5]) cylinder(d=big_bearing_OUT_D + 3.2,h=big_bearing_H + 0.01,$fn=64,center=true);
  
  translate([0,-part_depth/4,cover_height/2 - big_bearing_H/2 + 1.5]) cube([big_bearing_OUT_D + 3.2,part_depth/2,big_bearing_H + 0.01],center=true);
}

module cover_cuts()
{
  // Otvor pro srouby
  translate([part_width/2 - 5,0,cover_height/2 - M3_screw_offset]) rotate([180,0,0]) 
  screw_hole(1);
  
  translate([-part_width/2 + 5,0,cover_height/2 - M3_screw_offset]) rotate([180,0,0]) 
  screw_hole(1);
  
  translate([0,0,axial_bearing_H1 + axial_bearing_H2 + big_bearing_H + pulley_H + big_bearing_H + cover_height/2 - big_bearing_H]) rotate([180,0,180]) bearing_cut();
  
  // Prostor pro hnaci ozubene kolecko
  cylinder(d=19.5,h=30,$fn=64,center=true);
}

module z_belt_tensioner_base()
{
  bearing_offset = 10;
  
  // Zakladna pro pridelani na profil
  translate([bearing_holder_width/2 - idler_tens_width/2,bearing_holder_length/2 - 10/2,0]) rounded_box(idler_tens_width,10,part_height,3,1,0,0,0);
  
  // Rameno pro lozisko  
  translate([0,-idler_tens_pos/2 - 1/2,-part_height/2 +(part_height - pulley_H)/2 ]) rounded_box(bearing_holder_width,bearing_holder_length + idler_tens_pos + 1,part_height - pulley_H,4,1,0,0,1);
  
  // Napinaci lozisko
  translate([bearing_offset,idler_tens_pos,-part_height/2 +(part_height - pulley_H)/2 + sloupek_H/2]) cylinder(d=10,h=sloupek_H + part_height - pulley_H,$fn=64,center=true);
  
  translate([bearing_offset/2,idler_tens_pos,-part_height/2 +(part_height - pulley_H)/2 ]) rounded_box(bearing_holder_width + bearing_offset,11,part_height - pulley_H,4,1,1,1,1);
  
  // Vyztuzeni
  hull()
  {
    translate([0,-idler_tens_pos/2 - 1/2,-part_height/2 + 5/2]) rounded_box(bearing_holder_width,bearing_holder_length + idler_tens_pos + 1,5,4,1,0,0,1);
  
    translate([bearing_holder_width/2 - idler_tens_width/2,bearing_holder_length/2 - 10/2,-part_height/2 + 5/2]) rounded_box(idler_tens_width,10,5,3,1,0,0,1);
  }

  // Drazka pro pridelani na profil
  translate([bearing_holder_width/2 - idler_tens_width/2,bearing_holder_length/2,part_height/2 - profile_width/2]) rotate([90,0,180]) drazka_vertical(idler_tens_width,0);  
  
  translate([0,bearing_holder_length/2 - 10,-part_height/2 + part_height - pulley_H]) rotate([0,90,0]) fillet(10,bearing_holder_width);
}


module z_belt_tensioner_cuts()
{  
  bearing_offset = 10;
  
  // Napinaci lozisko
  translate([bearing_offset,idler_tens_pos,part_height/2 - pulley_H + sloupek_H - idler_screw_length + 17]) rotate([180,0,0]) screw_hole(1,0,idler_nut_D,idler_screw_D,6);
  
  // Otvor pro M6 sroub
  translate([bearing_holder_width/2 - idler_tens_width + M6_washer_D/2,bearing_holder_length/2 - M6_screw_offset,part_height/2 - profile_width/2]) rotate([90,0,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  // Vyrez pro profilovou matku
  translate([bearing_holder_width/2 - idler_tens_width + M6_washer_D/2,bearing_holder_length/2 + 3/2,part_height/2 - profile_width/2]) cube([profile_nut_W,3,10],center=true);
}

/* Napinak remenu */
module z_belt_tensioner()
{
  difference()
  {
    z_belt_tensioner_base();
    z_belt_tensioner_cuts();
  }
}

/* Drzak motoru */
module z_motor_holder()
{
  difference()
  {
	z_motor_holder_base();
	z_motor_holder_cuts();
  }
}

/* Rameno drzaku lozisek 624 */
module bearing_holder()
{
  difference()
  {
	bearing_holder_base();
    bearing_holder_cuts();
  } 
}

/* Krytka - drzak loziska 608 */
module cover()
{
  difference()
  {
	cover_base();
    cover_cuts();
  } 
}

/* Spodni cast drzaku lozisek */
module z_leadscrew_holder(motor_part = 1)
{
  difference()
  {
	z_leadscrew_holder_base(motor_part);
	Z_leadscrew_holder_cuts(motor_part);
  } 
}

// Drzak bez kladek
z_leadscrew_holder(0);

// Drzak s kladkami pro vedeni remenu
translate([0,-part_depth - 5,0]) z_leadscrew_holder(1);

// Vrchni kryty
translate([-2*part_width + 20,-part_depth - 5,-part_height/2 + cover_height/2]) 
cover();

translate([-2*part_width + 20,0,-part_height/2 + cover_height/2]) 
cover();