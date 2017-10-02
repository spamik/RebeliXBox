/* 
   === RebeliX BoX ===

   RUMBA holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

include <../../inc/functions.scad>
use <../../inc/text_RebeliX.scad>

// Zapusteni M6 sroubu
M6_screw_offset = M6x14_offset;

sirka = 75;
vyska = 135;
rohy_prumer = 5;

tloustka = 6;
tloustka_steny = 3;

// solid_plate = 0 => otvory skrz
// solid_plate = 1 => prvni 2 vrstvy vyplnene na 100%
solid_plate = 0;

// Vyska sloupku
sloupek = 13;
PCB_thickness = 2;

// Drzak energo retezu
HB_chain_holder = 1;
chain_holder_L = 35; 
chain_holder_W = small_chain_H + 2*small_mantinel_W;
chain_holder_H = tloustka + small_chain_mount_W;

// Radius zakulacenych rohu
corner_rad = 3;

wall_thickness = 3.5 -(-rohy_prumer/2 - 0.5) - 4;

RUMBA_mount_holes = [
	[4, 3.5, 0],
	[4 + 36,3.5, 0],
	[4,vyska - 3.5, 0],
	[sirka - 8/2,vyska - 3.5, 0]
];

mount_sloupek = [
	[4, rohy_prumer/2 - 3 + 1.5/2 , 0],
	[4 + 36,rohy_prumer/2 - 3 + 1.5/2, 0],
	[4,vyska-rohy_prumer/2 + 3 - 1.5/2, 0],
	[sirka - 8/2,vyska-rohy_prumer/2 + 3 - 1.5/2, 0]
];

RUMBA_mount_holes_offset = [0,0,0];

cover_corners = [
	[rohy_prumer/2 - 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3 + 10,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3 + 10,vyska-rohy_prumer/2 + 3,0],
	[rohy_prumer/2 - 3,vyska-rohy_prumer/2 + 3,0]
];

zip_position = [
	[sirka/2 - 24,82.5 - 15/2,tloustka/2],
	[sirka/2,82.5 - 45  + 15,tloustka/2],
	[sirka/2 + 20,82.5 - 45,tloustka/2],	
	[sirka/2 - 24,57.5,tloustka/2],
	[sirka/2 - 24,100,tloustka/2],
];

module plate()
{
  vyska_extra = 5;
  vyska = tloustka + sloupek + PCB_thickness + profile_width + vyska_extra;
  plate_height = wall_thickness;

  difference()
  {
    union()
	{
	  translate([(sirka/2 + 10 + 15/2 - plate_height)/2 + 4/2,vyska/2 - tloustka/2,0]) cube([sirka/2 + 10 + 15/2 - plate_height + 4,vyska,plate_height],center=true);
  
      intersection()
      {
        translate([-plate_height/2,vyska/2 - tloustka/2,0]) cube([plate_height,vyska,plate_height],center=true);
  
        translate([0,vyska/2 - tloustka/2,-plate_height/2]) rotate([90,0,0]) cylinder(d=2*plate_height,h=vyska,$fn=32,center=true);
      }
  
      intersection()
      {
        translate([sirka/2 + 10 + 15/2 - plate_height/2 + 4,vyska/2 - tloustka/2,0]) cube([plate_height,vyska,plate_height],center=true);
  
        translate([sirka/2 + 10 + 15/2 - plate_height + 4,vyska/2 - tloustka/2,-plate_height/2]) rotate([90,0,0]) cylinder(d=2*plate_height,h=vyska,$fn=32,center=true);
      }
	}
   translate([-plate_height,vyska/2 - 10,-plate_height/2 - 1/2]) rotate([0,0,40]) cube([sirka,vyska,plate_height + 1],center=false);
  }	
}

module holder_base(sirka,delka = 40)
{
  mount_tickness = 10;
  vyska_extra = 5;
  vyska = tloustka + sloupek + PCB_thickness + profile_width + vyska_extra;

  translate([0,0,sloupek/2 + PCB_thickness/2 + profile_width/2 + vyska_extra/2]) rounded_box(delka,sirka,vyska,corner_rad,0,1,0,0);
  
  translate([rohy_prumer/2,0,0]) rounded_box(delka + rohy_prumer,sirka,tloustka,corner_rad,0,1,0,0);
  
  translate([-delka/2,0,vyska - tloustka/2  - profile_width/2]) rotate([90,0,-90]) drazka_vertical(sirka - 4,1);
}

module holder_cuts(sirka,delka = 40)
{
 mount_tickness = 10;

 cut_dia = delka - mount_tickness;
 vyska_extra = 5;
 vyska = tloustka + sloupek + PCB_thickness + profile_width + vyska_extra;

 // Otvor pro M6 sroub
 translate([-delka/2 + M6_screw_offset,0,vyska - tloustka/2  - profile_width/2]) rotate([0,90,0]) screw_hole(0,0,M6_head_D,M6_screw_D);
 
 // Vyrez pro profilovou matku
 translate([-delka/2 - 3/2,0,vyska - tloustka/2  - profile_width/2]) cube([3,profile_nut_W,10],center=true);

 // Vyrez
 translate([-delka/2 + mount_tickness + cut_dia,0,tloustka/2 + cut_dia]) rotate([90,0,0]) cylinder(r=cut_dia,corner_rad,h=sirka + 1,$fn=64,center=true);
 
 translate([-delka/2 + mount_tickness + cut_dia,0,tloustka/2 + cut_dia + vyska/2]) cube([2*cut_dia,sirka + 1,vyska],center=true);
}

module wire_holder_base(pocet_pozic,delka)
{
  rounded_box(delka,pocet_pozic*15,tloustka,corner_rad,1,1,1,1);
}

module wire_holder_cuts(pocet_pozic,delka)
{
  for(i=[0:15:pocet_pozic*15 - 15])
  {
	translate([0,-(pocet_pozic*15)/2 + 15/2 + i,tloustka/2 + 2]) rotate([0,90,0]) zip_paska(6);
  }
}

module obvod(length)
{ 
  difference()
  {
	hull()
	{
	  for (a = cover_corners)
	  translate(a)
	  {
		cylinder(d=rohy_prumer,h=tloustka,$fn=32);
	  } 
	}	
	//translate([tloustka_steny,tloustka_steny,solid_plate == 0 ? -0.1 : 2*layer_height]) cube([sirka-2*tloustka_steny,vyska-2*tloustka_steny,tloustka+1]);
	//translate([tloustka_steny,tloustka_steny,tloustka/2]) cube([sirka-2*tloustka_steny,vyska-2*tloustka_steny,tloustka]);
  }
  
  // Sloupky pro srouby
  for (a = RUMBA_mount_holes)
  translate(a+RUMBA_mount_holes_offset)
  {
	cylinder(d=8,h=tloustka + sloupek,$fn=32);
	cylinder(d=10,h=tloustka,$fn=32);
  } 
  
  for (a = mount_sloupek)
  translate(a+RUMBA_mount_holes_offset)
  {
	translate([0,0,(tloustka + sloupek)/2]) cube([8,3.5 -(-rohy_prumer/2 - 0.5),tloustka + sloupek],center=true);
  } 
  
  // Zarazky pro elektroniku
  translate([0,-4/2,(tloustka + sloupek)/2 + PCB_thickness/2])
  {
	translate(mount_sloupek[0]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
	
	translate(mount_sloupek[1]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
  }
  
  translate([0,4/2,(tloustka + sloupek)/2 + PCB_thickness/2])
  {
	translate(mount_sloupek[2]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
	
	translate(mount_sloupek[3]) cube([8,3.5 -(-rohy_prumer/2 - 0.5) - 4,tloustka + sloupek + PCB_thickness],center=true);
  } 
  
  // Sloupky pro podepreni elektroniky
  translate(RUMBA_mount_holes[0] + [0,43,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(RUMBA_mount_holes[1] + [14 + 12.5/2,13.5 + 12/2,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(RUMBA_mount_holes[0] + [10,84,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(RUMBA_mount_holes[1] + [14 + 12.5/2,13.5 + 12/2,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(RUMBA_mount_holes[1] + [14 + 12.5/2,13.5 + 12/2 + 46.5,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
  translate(RUMBA_mount_holes[1] + [-6,61,0]) cylinder(d=8,h=tloustka + sloupek,$fn=32);
}

module mrizka()
{
  intersection()
  {
    union()
	{
      // Honeycomb(length, width, height, cell_size, wall_thickness);
      honeycomb(sirka, vyska, tloustka, 8, 1.2);
	  // Pole pro text
	  translate([0,vyska - 20 - 15,0]) cube([sirka,20,tloustka]);
	  
	  // Pozice pro zip pasky
	  for(a = zip_position)
	  translate(a)
	  {
	    wire_holder_base(1,8);
	  }	
	}
	
	hull()
	{
	  for (a = cover_corners)
	  translate(a)
	  {
	    cylinder(d=rohy_prumer,h=tloustka,$fn=32);
	  }
	}
  }
}

module otvory()
{
  for (a = RUMBA_mount_holes)
  {
    // Otvory pro srouby	
	translate(a+[0,0,4]+RUMBA_mount_holes_offset) rotate([180,0,0]) screw_hole(1);
  }
}

module chain_holder_hb_base()
{
  rounded_box(chain_holder_W,chain_holder_L,tloustka - 3,4,1,1,1,1);
  
  translate([-chain_holder_W/2 + small_mantinel_W/2,- 5/2 ,-(tloustka - 3)/2 + chain_holder_H/2]) rounded_box(small_mantinel_W,chain_holder_L - 5,chain_holder_H,4,1,1,1,1);
  
  translate([-chain_holder_W/2 + small_mantinel_W/2, 0,-(tloustka - 3)/2 + 8/2]) rounded_box(small_mantinel_W,chain_holder_L,8,4,1,1,1,1);
  
  translate([chain_holder_W/2 - small_mantinel_W/2,- 5/2 ,-(tloustka - 3)/2 + chain_holder_H/2]) rounded_box(small_mantinel_W,chain_holder_L - 5,chain_holder_H,4,1,1,1,1);
  
  translate([chain_holder_W/2 - small_mantinel_W/2, 0,-(tloustka - 3)/2 + 8/2]) rounded_box(small_mantinel_W,chain_holder_L,8,4,1,1,1,1);
}

module chain_holder_hb_cuts()
{
  translate([chain_holder_W/2 - small_mantinel_W/2,0,0]) 
  {
    cube([2,4,50],center=true);
  }	
  
  translate([-chain_holder_W/2 + small_mantinel_W/2,0,0]) 
  {
    cube([2,4,50],center=true);
  }	

  translate([0,chain_holder_L/2 + 2.5/2 - 13,(tloustka - 3)/2 + small_chain_mount_W/2]) 
  cube([chain_holder_W + 1,2.5,4],center=true);
  translate([0,chain_holder_L/2 - 2.5/2 - 22,(tloustka - 3)/2 + small_chain_mount_W/2]) cube([chain_holder_W + 1,2.5,4],center=true);
  
  translate([0,0,(tloustka - 3)/2 + chain_holder_H - 6 + 0.01]) cube([chain_holder_W - small_mantinel_W,4,6],center=true);
}

module chain_holder_hb()
{
  difference()
  {
    chain_holder_hb_base();
    chain_holder_hb_cuts();
  }
}

//chain_holder_hb();

module RUMBA_holder()
{
  difference()
  {
    union()
    {
	  obvod();
	  //mrizka();
	  
	  // Sloupky pro pridelani na profil
	  translate([sirka + 20/2 - cover_corners[0][0] + 0.01 + 4/2,vyska + rohy_prumer/2 - 20/2 - cover_corners[0][0],tloustka/2]) rotate([0,0,180]) holder(20,19);
	  
	  translate([sirka + 20/2 - cover_corners[0][0] + 0.01 + 4/2,-rohy_prumer/2 + 20/2 + cover_corners[0][0],tloustka/2]) rotate([0,0,180]) mirror([0,1,0]) holder(20,19);
	  
	  // Vyztuha
	  translate([sirka/2 - cover_corners[0][0],-rohy_prumer/2 + cover_corners[0][0] - wall_thickness/2 + 0.001,tloustka/2]) rotate([90,0,0]) plate();
	  
	  translate([sirka/2 - cover_corners[0][0],vyska + rohy_prumer/2 - cover_corners[0][0] - wall_thickness/2 + wall_thickness - 0.001,tloustka/2]) rotate([90,0,0]) mirror([0,0,1]) plate();
	  
	  translate([chain_holder_W/2 + 11,5/2 - (chain_holder_L - 5)/2 - corner_rad,(tloustka - 3)/2]) chain_holder_hb();
    }	
  otvory();
  
  // Otvovry pro zip pasky (motory)
  translate([sirka + 7,5*15/2 + 16/2,tloustka/2]) wire_holder_cuts(4,9);
  
  // Zip pasky
  for(a = zip_position)
  translate(a)
  {
    wire_holder_cuts(1,8);
  }	
  
  // Otvor pro hlavni kabelovy svazek
  translate([sirka+ rohy_prumer/2 + 3,vyska,tloustka + 8/2 + 2.5]) rotate([90,0,0]) cylinder(d=11,h=20,$fn=32,center=true);
  
  translate([sirka+ rohy_prumer/2 + 3,vyska,tloustka + 8/2 + 2.5 + sloupek]) rotate([90,0,0]) cylinder(d=11,h=20,$fn=32,center=true);
  
  translate([sirka+ rohy_prumer/2 + 3,vyska,tloustka + 8/2 + 2.5 + sloupek/2]) cube([11,20,sloupek - 1],center=true);
  
   translate([sirka+ rohy_prumer/2 + 1.5,0,tloustka + 8/2 + 1]) rotate([90,0,0]) cylinder(d=8,h=20,$fn=32,center=true);
  
  translate([sirka+ rohy_prumer/2 + 1.5,0,tloustka + 8/2 + 1 + sloupek]) rotate([90,0,0]) cylinder(d=8,h=20,$fn=32,center=true);
  
  translate([sirka+ rohy_prumer/2 + 1.5,0,tloustka + 8/2 + 1 + sloupek/2]) cube([8,20,sloupek],center=true);

  //translate([sirka + 20/2,vyska - profile_width/2 - offset_horni,tloustka/2 + 8]) rotate([90,0,0]) zip_paska(6);
  
  //translate([cover_corners[0][0] + 15,cover_corners[0][1] - rohy_prumer/2 - 5,tloustka/2 + 15]) rotate([0,90,0]) zip_paska(6);
  
  //translate([cover_corners[0][0] + 55,cover_corners[0][1] - rohy_prumer/2 - 5,tloustka/2 + 15]) rotate([0,90,0]) zip_paska(6);
  
  translate([sirka/2 + 10/2,vyska - 20 - 5,-tloustka + 1]) mirror([1,0,0]) scale([0.9,0.9,1]) text_RebeliX(tloustka);
  }
}  

module holder(sirka,delka)
{
  difference()
  {
	holder_base(sirka,delka);
	holder_cuts(sirka,delka);
  }
}


module wire_holder(pocet_pozic=1,delka=12)
{
  difference()
  {
	wire_holder_base(pocet_pozic,delka);
	wire_holder_cuts(pocet_pozic,delka);
  }
}

RUMBA_holder();