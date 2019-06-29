/* 
   === RebeliX BoX ===

   Bondtech BMG-X2 mount plate
  
*/

include <x_carriage_extruder_bltouch.scad>

plate_width_body_h = part_length;
plate_narrow_body_h = part_length+13;
plate_w = 65.4;
plate_narrow_w = carriage_length;
plate_thickness = 13;


module bmg_plate_body() {
	union() {
		cube(size=[plate_w, plate_width_body_h, plate_thickness], center=true);
		translate([0, (plate_narrow_body_h - plate_width_body_h)/-2, 0]) cube(size=[plate_narrow_w, plate_narrow_body_h, plate_thickness], center=true);
	}
}

module bmg_plate_holes() {
	// diry na prisroubovani k voziku
	translate([0,-part_length/2 + carriage_width/2,-2])
  {
	translate([carriage_length/2 - 6,0,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
	translate([carriage_length/2 - 6,11,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
	translate([-carriage_length/2 + 6,0,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
	translate([-carriage_length/2 + 6,11,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
  }	

  // bocni diry pro prisroubovani extruderu
  translate([0,-part_length/2 + carriage_width/2,0]) {
  	translate([plate_w/-2 + (plate_w-carriage_length)/2, 0, 0]) rotate(a=[0, 90, 0]) nut_hole(0, 12);
  	translate([plate_w/-2 + (plate_w-carriage_length)/2, 11, 0]) rotate(a=[0, 90, 0]) nut_hole(0, 12);
  	translate([plate_w/2 - (plate_w-carriage_length)/2, 0, 0]) rotate(a=[0, 90, 0]) nut_hole(0, 12);
  	translate([plate_w/2 - (plate_w-carriage_length)/2, 11, 0]) rotate(a=[0, 90, 0]) nut_hole(0, 12);
  }
  // otvory na matky pro prisroubovani z druhe strany extruderu
  translate([plate_w/-2+M3_nut_D/2+0.6, plate_width_body_h/-2+M3_nut_D, plate_thickness/-2+M3_nut_H-1]) rotate(a=[0, 0, 90]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);	
  translate([plate_w/2-M3_nut_D/2-0.6, plate_width_body_h/-2+M3_nut_D, plate_thickness/-2+M3_nut_H-1]) rotate(a=[0, 0, 90]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);	
  translate([plate_w/-2+M3_nut_D/2+0.6, plate_width_body_h/2-M3_nut_D, plate_thickness/-2+M3_nut_H-1]) rotate(a=[0, 0, 90]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);	
  translate([plate_w/2-M3_nut_D/2-0.6, plate_width_body_h/2-M3_nut_D, plate_thickness/-2+M3_nut_H-1]) rotate(a=[0, 0, 90]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);	
  // srouby pro matky
  translate([plate_w/-2+M3_nut_D/2+0.6, plate_width_body_h/-2+M3_nut_D, 2*M3_nut_H-0.66]) cylinder(d=M3_screw_D, h = plate_thickness,$fn=100, center=true);	
  translate([plate_w/2-M3_nut_D/2-0.6, plate_width_body_h/-2+M3_nut_D, 2*M3_nut_H-0.66]) cylinder(d=M3_screw_D, h = plate_thickness,$fn=100, center=true);	
  translate([plate_w/-2+M3_nut_D/2+0.6, plate_width_body_h/2-M3_nut_D, 2*M3_nut_H-0.66]) cylinder(d=M3_screw_D, h = plate_thickness,$fn=100, center=true);	
  translate([plate_w/2-M3_nut_D/2-0.6, plate_width_body_h/2-M3_nut_D, 2*M3_nut_H-0.66]) cylinder(d=M3_screw_D, h = plate_thickness,$fn=100, center=true);	

  // vyrez pro vedeni kabelu
  translate([0, 0, plate_thickness/-2+2]) cube(size=[17, plate_narrow_body_h*2, 6], center=true);
  // prurez pro vedeni kabelu BLTouche
  translate([0, 5/2, 0]) cube(size=[17, 5, plate_thickness*2], center=true);
  // vykus pro plat s BLTouchem
  translate([0, plate_width_body_h/2-4.99/2, 0]) cube(size=[35, 5, plate_thickness*2], center=true);
  // diry pro prisroubovani BLTouch platu
  translate([35/-2+M3_nut_D/2, plate_width_body_h/2-10, 0]) rotate(a=[0, 90, 90]) nut_hole(0, 12);
  translate([35/2-M3_nut_D/2, plate_width_body_h/2-10, 0]) rotate(a=[0, 90, 90]) nut_hole(0, 12);
  // zip prichytky na kabely
  translate([0, 10, 5/-2]) rotate(a=[90, 0, 0]) zip_paska(4);
  translate([0, -7, 5/-2]) rotate(a=[90, 0, 0]) zip_paska(4);
  translate([0, -20, 5/-2]) rotate(a=[90, 0, 0]) zip_paska(4);
  // diry pro prisroubovani vrchniho dilu
  translate([part_length/-2+3,plate_narrow_body_h/-2,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
  translate([part_length/2-3,plate_narrow_body_h/-2,plate_thickness/-2+2+4]) rotate(a=[180, 0, 0]) screw_hole(1);
  // vykus horni strany pro zalomeni kabelu
  translate([0, plate_narrow_body_h/-2-4, 0]) cube(size=[17, 13, plate_thickness*2], center=true);
}

module bmg_plate() {
	difference() {
		bmg_plate_body();
		bmg_plate_holes();
	}
}

translate([0, 0, -20]) rotate(a=[0, 0, 0]) bmg_plate();