/* 
   === RebeliX BoX ===

  holder for water cooling hoses / adaptors to fit 3030 grame

*/

//include <../configuration.scad>
include <../inc/functions.scad>

// Radius zakulacenych rohu
corner_rad = 3;

module hoseholder_base()
{
  translate([0, 1, 0]) rounded_box(30,7,profile_width,corner_rad,0,0,0,0);
  translate([0, 3/2+1, profile_width/-2+7.5/2]) cube(size=[30, 7+3, 7.5], center=true);
    
  // Drazka pro pridelani do profilu
  translate([0,-5/2,0]) cube([30,3,8],center=true);


}

module hoseholder_cuts()
{  
  // M6 sroub
  translate([0,0,0]) rotate([90,0,0]) cylinder(d=M6_screw_D, h=20, $fn=32, center=true);
  // Seriznuti pro lehci tisk
  translate([-(30)/2 - 0.01,-5/2,-8/2]) rotate([90 + 30,0,0]) cube([30+1,3,8]);
  // Vyrez pro profilovou matku
  translate([0,-5/2 - 3/2,0])  cube([profile_nut_W,3,10],center=true);
  
  // diry pro pasky pro pridelani adapteru
  translate([-9, 4, 11]) rotate(a=[0, 0, 0]) zip_paska(4);
  translate([9, 4, 11]) rotate(a=[0, 0, 0]) zip_paska(4);
  // pasky pro fixaci hadic smer hotend
  translate([-9, 4+2.5, -11]) rotate(a=[0, 0, 0]) zip_paska(4);
  translate([9, 4+2.5, -11]) rotate(a=[0, 0, 0]) zip_paska(4);

}


module hose_holder()
{
  difference()
  {
    hoseholder_base();
    hoseholder_cuts();
  } 
}


hose_holder();