/* 
   === RebeliX BoX ===

   nozzle mount
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include </inc/functions.scad>

epsilon = 0.01;

// Vzdalenost otvoru pro pridelani HE od stredu HE
first_hole = 20;
second_hole = 13;

mount_height = 8;
mount_width = 20;
mount_length = first_hole + second_hole + 10;

module nozzle_mount_base()
{
  translate([(-first_hole + second_hole)/2,0,0]) rounded_box(mount_length,mount_width,mount_height,5,1,1,1,1);
}

module nozzle_mount_cuts()
{
  translate([0,0,4.4]) cylinder(r=8.5,h=mount_height,$fn=30,center=true);
  translate([0,-mount_width/2,4.4]) cube([17,mount_width,mount_height],center=true);
	
  translate([0,0,-mount_height/2 - epsilon]) cylinder(r=6.1,h=mount_height,$fn=30);
  translate([0,-mount_width/2,-epsilon]) cube([12.2,mount_width,mount_height],center=true);
	
  // Otvory pro prisroubovani
  translate([-first_hole,0,0]) cylinder(r=1.6,h=mount_height+1,$fn=30,center=true);
  translate([-first_hole - mount_width/2,0,0]) cube([mount_width,2*1.6,mount_height+1],center=true);
		
  translate([second_hole,0,0]) cylinder(r=1.6,h=mount_height+1,$fn=30,center=true);
  translate([-first_hole,0,-mount_height/2 + 4]) cylinder(r=7/2,h=mount_height,$fn=30); translate([-first_hole - mount_width,-7/2,-mount_height/2 + 4]) cube([mount_width,7,mount_height]);
	
  translate([second_hole,0,-mount_height/2 + 4]) cylinder(r=7/2,h=mount_height,$fn=30);
  
  translate([second_hole + mount_width/2,0,0]) cube([mount_width,2*1.6,mount_height+1],center=true);
  translate([second_hole,-7/2,-mount_height/2 + 4]) cube([mount_width,7,mount_height]);
}

module nozzle_mount()
{
  difference()
  {
    nozzle_mount_base();
	nozzle_mount_cuts();
  }
}

nozzle_mount();