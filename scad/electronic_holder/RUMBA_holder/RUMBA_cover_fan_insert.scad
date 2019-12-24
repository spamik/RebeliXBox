/* 
   === RebeliX BoX ===

   RUMBA cover
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../../configuration.scad>
include <../../inc/functions.scad>
use <../../inc/text_RebeliX.scad>

sirka = 75;
vyska = 135;
rohy_prumer = 5;
tloustka = 2.5;
tloustka_steny = 3;
// solid_plate = 0 => otvory skrz
// solid_plate = 1 => prvni 2 vrstvy vyplnene na 100%
solid_plate = 0;
// Vyska sloupku
sloupek = 0;

noctua_hole = 4.5;
noctua_pitch = 50;
noctua_fanhole = 60;

RUMBA_mount_holes = [
	[4, 3.5, 0],
	[4 + 36,3.5, 0],
	[4,vyska - 3.5, 0],
	[sirka - 8/2,vyska - 3.5, 0]
];

RUMBA_mount_holes_offset = [0,0,0];

cover_corners = [
	[rohy_prumer/2 - 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,rohy_prumer/2 - 3,0],
	[sirka-rohy_prumer/2 + 3,vyska-rohy_prumer/2 + 3,0],
	[rohy_prumer/2 - 3,vyska-rohy_prumer/2 + 3,0]
];

module obvod(length)
{ 
  difference()
  {
	hull()
	{
	  for (a = cover_corners)
	  translate(a)
	  {
		cylinder(r=rohy_prumer/2,h=tloustka,$fn=32);
	  } 
	}	
	//translate([tloustka_steny,tloustka_steny,solid_plate == 0 ? -0.1 : 2*layer_height]) cube([sirka-2*tloustka_steny,vyska-2*tloustka_steny,tloustka+1]);
  }
  // Otvory pro srouby
  for (a = RUMBA_mount_holes)
  translate(a+RUMBA_mount_holes_offset)
  {
	// Sloupek
	cylinder(d=8,h=tloustka + sloupek,$fn=32);
  } 
}


module otvory()
{
  for (a = RUMBA_mount_holes)
  {
    // Otvory pro srouby
	translate(a+[0,0,-0.1]+RUMBA_mount_holes_offset)
	cylinder(d=3.6,h=tloustka+sloupek + 1,$fn=16);
  }
}

module fan_module() {
	// mounting holes
	translate([0, 0, 0]) cylinder(d=noctua_hole, h=tloustka+sloupek+1, $fn=16);
	translate([noctua_pitch, 0, 0]) cylinder(d=noctua_hole, h=tloustka+sloupek+1, $fn=16);
	translate([0, noctua_pitch, 0]) cylinder(d=noctua_hole, h=tloustka+sloupek+1, $fn=16);
	translate([noctua_pitch, noctua_pitch, 0]) cylinder(d=noctua_hole, h=tloustka+sloupek+1, $fn=16);
	// fan hole
	translate([noctua_pitch/2, noctua_pitch/2, 0]) cylinder(d=noctua_fanhole, h=tloustka+sloupek+1, $fn=24);
}


module RUMBA_cover()
{ 
  difference()
  {
  	union() {
	obvod();
	//translate([sirka/2-60/2, 8, -0.1]) cube(size=[60, 60, 25]);
	//translate([sirka/2-60/2, 74, -1.1]) cube(size=[60, 60, 25]);

	}	
  	otvory();
  	translate([sirka/2-noctua_pitch/2, 13, -0.1]) fan_module();
  	translate([sirka/2-noctua_pitch/2, 79, -0.1]) fan_module();


  // Napis
  //translate([sirka/2,vyska - 20 - 5,tloustka - 1.5]) scale([0.7,0.7,1]) text_RebeliX(tloustka);
  }
}  

RUMBA_cover();