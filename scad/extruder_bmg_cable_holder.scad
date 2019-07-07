include </inc/functions.scad>
include <extruder_bmg_x2_plate.scad>


holder_height = 42;
holder_depth = 16;
plate_depth = 14;
plate_overlap_chain = 57.5;
plate_overlap_tubes = 13;
holder_width = carriage_length;


module bmg_cable_holder_base() {
	union() {
		cube(size=[holder_width, holder_depth, holder_height], center=true);
		plate_size = plate_overlap_tubes + plate_overlap_chain + holder_depth;
		translate([0, plate_size/2 - holder_depth/2 - plate_overlap_tubes, holder_height/2+plate_depth/2-1]) cube(size=[holder_width, plate_size, plate_depth], center=true);
		translate([0, plate_overlap_tubes/-2, 13/2+0.5]) cube(size=[holder_width, holder_depth+plate_overlap_tubes, holder_height-13], center=true);
	}

}

module bmg_cable_holder_cut() {
	// pruchod na kabely
	translate([0, 0, -1.001]) cube(size=[17, holder_depth*3, holder_height], center=true);
	// diry pro prichyceni cable chainu
	translate([0, holder_depth/2+plate_overlap_chain-11, holder_height/2+M2_nut_H*2]) rotate(a=[180, 0, 90]) nut_hole(1, 10, nut_diameter=M2_nut_D, hole_dia=M2_screw_D);
	translate([10, holder_depth/2+plate_overlap_chain-11, holder_height/2+M2_nut_H*2]) rotate(a=[180, 0, 90]) nut_hole(1, 10, nut_diameter=M2_nut_D, hole_dia=M2_screw_D);
	// zip pasky na prichyceni kabelu
  	translate([0, -plate_overlap_tubes, holder_height/2]) rotate(a=[90, 0, 0]) zip_paska(17/2-1);
  	translate([0, holder_depth/2, holder_height/2]) rotate(a=[90, 0, 0]) zip_paska(17/2-1);
  	translate([0, holder_depth*2, holder_height/2]) rotate(a=[90, 0, 0]) zip_paska(17/2-1);
  	// srouby pro pridelany k extruderu
	translate([part_length/-2+3, holder_depth/2-M3_nut_H+1, holder_height/-2+13/2]) rotate(a=[90, 0, 0]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);
	translate([part_length/2-3, holder_depth/2-M3_nut_H+1, holder_height/-2+13/2]) rotate(a=[90, 0, 0]) cylinder(d=M3_nut_D, h = 2*M3_nut_H,$fn=6,center=true);
	translate([part_length/-2+3, holder_depth/2-M3_nut_H+1, holder_height/-2+13/2]) rotate(a=[90, 0, 0]) cylinder(d=M3_screw_D, h = 3*holder_depth,$fn=100,center=true);
	translate([part_length/2-3, holder_depth/2-M3_nut_H+1, holder_height/-2+13/2]) rotate(a=[90, 0, 0]) cylinder(d=M3_screw_D, h = 3*holder_depth,$fn=100,center=true);
	// otvory na matky pro pridelani drzaku hadic
	translate([part_length/2-3, holder_depth/-2-plate_overlap_tubes/2, holder_height/2+(plate_depth-1)/2]) rotate(a=[90, 0, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([part_length/-2+3, holder_depth/-2-plate_overlap_tubes/2, holder_height/2+(plate_depth-1)/2]) rotate(a=[90, 180, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
}

module bmg_cable_holder() {
	difference() {
		bmg_cable_holder_base();
		bmg_cable_holder_cut();
	}
}

translate([0, -55, -40]) rotate(a=[-90, 0, 180]) bmg_cable_holder();