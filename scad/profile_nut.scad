/* 
   === RebeliX BoX ===

   profile nut
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

module nut_base()
{
  spodni_hrana = 10;
  horni_hrana = 21;
  zobacek_vyska = 1.5;
  zobacek_sirka = 8;
  vyska = 5.5;
  
  linear_extrude(height = 10)
  {
    polygon(points=[
      [-spodni_hrana/2,0],
      [spodni_hrana/2,0],
      [horni_hrana/2,vyska],
	  [horni_hrana/2 - (horni_hrana - zobacek_sirka)/2,vyska],
	  [horni_hrana/2 - (horni_hrana - zobacek_sirka)/2,vyska + zobacek_vyska],
	  [horni_hrana/2 - (horni_hrana - zobacek_sirka)/2 - zobacek_sirka,vyska + zobacek_vyska],[horni_hrana/2 - (horni_hrana - zobacek_sirka)/2 - zobacek_sirka,vyska],
	  [-horni_hrana/2,vyska]  
	]);
  }
}

module nut_cuts()
{
  translate([0,3,10/2]) rotate([0,-90,-90]) nut_hole();
}

module nut_hole(solid_layer=0)
{
	nut_diameter=6.6;

	cylinder(r=nut_diameter/2,h=3,$fn=6,center=true);
    translate([15/2,0,0]) cube([15,nut_diameter*cos(30),3],center=true);
	

	if(solid_layer)
	{
	  translate([0,0,5 + 3/2 + layer_height]) cylinder(r=3.3/2,h=10,$fn=16,center=true);
	  translate([0,0,-10/2 - 3/2 + 0.001]) cylinder(r=3.3/2,h=10,$fn=16,center=true);
	} else 
    {
	  cylinder(r=3.3/2,h=15,$fn=16,center=true);
	}
}


module nut()
{
  difference()
  {
	nut_base();
	nut_cuts();
  }
}

nut();