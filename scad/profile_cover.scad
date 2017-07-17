/* 
   === RebeliX BoX ===

   profile cover
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

// Vyska "zobacku" pro zasunuti do profilu
part_height = 7;

// Delka hrany pro zasunuti do profilu
edge = 10.4;

module profile_cover_base()
{
  cube([30,30,4*layer_height],center=true);
  difference()
  {
	union()
	{
	  translate([0,0,part_height/2]) cube([edge,6,part_height],center=true);
	  translate([0,0,part_height/2]) cube([6,edge,part_height],center=true);
	}
	// Seriznuti pro snadnejsi zasunuti do profilu
    translate([edge/2 - 1,-edge/2,0]) rotate([0,35,0]) cube([5,edge,5]);
	translate([-edge/2 + 1,-edge/2,0]) rotate([0,-125,0]) cube([5,edge,5]);
	translate([-edge/2,-edge/2 + 1,0]) rotate([125,0,0]) cube([edge,5,5]);
	translate([-edge/2,edge/2 - 1,0]) rotate([-35,0,0]) cube([edge,5,5]);
  }
}

module profile_cover_cuts()
{
  translate([edge/2,-edge/2,part_height-0.5]) rotate([0,-30,0]) cube([5,edge,5]);
  translate([-edge/2,-edge/2,part_height-0.5]) rotate([0,-60,0]) cube([5,edge,5]);
  translate([-edge/2,edge/2,part_height-0.5]) rotate([30,0,0]) cube([edge,5,5]);
  translate([-edge/2,-edge/2,part_height-0.5]) rotate([60,0,0]) cube([edge,5,5]);
}

module profile_cover()
{
  difference()
  {
    profile_cover_base();
	profile_cover_cuts();
  }
}
	
profile_cover();	