/* 
   === RebeliX BoX ===

   sloupek pro drzak elektroniky RUMBA
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../../configuration.scad>
include <../../inc/functions.scad>

length = 30;

module base()
{
  cube([length,8,7],center=true);
}

module cuts()
{
  translate([-length/2+7,0,0]) rotate([0,-90,0]) nut_hole(0);
  translate([length/2,0,0]) rotate([0,-90,0]) cylinder(d=2.4,h=20,$fn=16,center=true);
}

module sloupek()
{
  difference()
  {
	base();
	cuts();
  }
}

for(i=[0:10:30])
{
  translate([0,i,0]) sloupek();
}