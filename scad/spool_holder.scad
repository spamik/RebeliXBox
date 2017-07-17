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

spool_d_max = 205;
d_min = spool_d_max - 30;
d_max = spool_d_max + 30;
height = 7;
height_holder = 23;
angle = 13;
d_rod = 16;

module spool_holder_base()
{
  intersection()
  {
    union()
    {
	  intersection()
	  {
	    difference()
	    {
	      cylinder(d=d_max,$fn=64,h=height,center=true);
	      cylinder(d=d_min,$fn=64,h=height+1,center=true);
        }
	    translate([d_max/2,-d_max/2 - sin(angle)*spool_d_max/2,0]) cube([d_max,d_max,height],center=true);	
	  }
	  // Zakladna pro prisroubovani
	  translate([10/2,-spool_d_max/2,height_holder/2-height/2]) cube([10,(d_max-d_min)/2 + 5,height_holder],center=true);
	  translate([10,-spool_d_max/2,height/2]) rotate([0,0,0]) cube([2*height,(d_max-d_min)/2 + 5,2*height],center=true);
	  
	  // Drazka do profilu
	  translate([0,-spool_d_max/2,height_holder/2 - height/2]) cube([3,8,height_holder],center=true);
	  
	  // Zaobleni
	  d_round = ((d_max - d_min)/2 - d_rod)/2;
	  translate([cos(angle)*(spool_d_max/2 - d_rod) + d_round/2,- sin(angle)*spool_d_max/2,0]) cylinder(r=d_round/2 + 0.3,h=height,$fn=32,center=true);
	  translate([cos(angle)*(spool_d_max/2 + d_rod) - d_round/2,- sin(angle)*spool_d_max/2,0]) cylinder(r=d_round/2 + 0.3,h=height,$fn=32,center=true);
	}
	difference()
	{
	  translate([0,0,-height/2 - 1]) cylinder(d=d_max,$fn=64,h=60);
	  translate([0,0,-height/2 - 1]) cylinder(d=d_min,$fn=64,h=60);
	}
  }
}


module spool_holder_cuts()
{
  angle_a = 35;
  angle_b = 68;
  
  // Vyrez pro tyc s loziskem 
  rotate([0,0,-angle-5]) translate([spool_d_max/2,0,0]) cylinder(d=d_rod,h=30,$fn=32,center=true);
  
  intersection()
  {
    difference()
	{
      cylinder(d=spool_d_max + d_rod,$fn=64,h=height + 1,center=true);
      cylinder(d=spool_d_max - d_rod,$fn=64,h=height + 1,center=true);
    }
    rotate([0,0,-angle-5]) translate([spool_d_max/2,angle_b-angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
  }
   
  // Odlehceni
  rotate([0,0,-angle_b]) translate([spool_d_max/2,0,0]) cylinder(d=14,h=30,$fn=32,center=true);
  rotate([0,0,-angle_a]) translate([spool_d_max/2,0,0]) cylinder(d=14,h=30,$fn=32,center=true);
  intersection()
  {
    difference()
	{
      cylinder(r=spool_d_max/2 + 7,$fn=64,h=height + 1,center=true);
      cylinder(r=spool_d_max/2 - 7,$fn=64,h=height + 1,center=true);
    }
    rotate([0,0,-angle_b]) translate([spool_d_max/2,angle_b-angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
    rotate([0,0,-angle_a]) translate([spool_d_max/2,-angle_b+angle_a,0]) cube([60,2*(angle_b-angle_a),height + 1],center=true);
  }
  
  // Otvor na prisroubovani do kombistojky
  translate([M6_screw_offset,-spool_d_max/2,height/2 + M6_head_D/2]) rotate([-90,0,-90]) screw_hole(0,0,M6_head_D,M6_screw_D);
  
  // Vyrez pro profilovou matku
  translate([-3/2,-spool_d_max/2,height/2 + M6_head_D/2]) rotate([0,0,0]) profile_nut(10);
  
  // Vyztuzeni uchytu
  translate([10 + height,-spool_d_max/2,3*height/2]) rotate([90,0,0]) cylinder(r=height,h=(d_max-d_min)/2 + 5,$fn=32,center=true); 
}

module spool_holder()
{
  difference()
  {
    spool_holder_base();
    spool_holder_cuts();
  }
}

spool_holder();
translate([-30,30,0]) rotate([0,0,-100]) mirror([0,1,0]) spool_holder();   

// Testovaci civka
/*
%rotate([0,0,-angle-5]) translate([spool_d_max/2,0,height]) cylinder(d=spool_d_max,h=2,$fn=64,center=true);
%rotate([0,0,-angle-5]) translate([spool_d_max/2,0,0]) cylinder(d=d_rod,h=40,$fn=64,center=true);
*/
