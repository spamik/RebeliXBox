fan_size = 40;
fan_tolerance = 2;
adapter_width = 2*fan_size+fan_tolerance;
adapter_thickness = 8;
adapter_height = 10;

fan_pitch = 33;
mount_pitch = 31;
mount_distance = 64;
mount_plate_size = 42;
mount_plate_distance = 6;
mount_pile_size = mount_plate_size+mount_plate_distance+adapter_thickness;

include </inc/functions.scad>


module fanduct_adapter_base(){
	cube(size=[adapter_width, adapter_height, adapter_thickness], center=true);
	translate([mount_distance/-2+adapter_thickness/2, mount_pile_size/2, 0]) cube(size=[adapter_thickness, mount_pile_size, adapter_thickness], center=true); 
	translate([mount_distance/2-adapter_thickness/2, mount_pile_size/2, 0]) cube(size=[adapter_thickness, mount_pile_size, adapter_thickness], center=true); 


}

module fanduct_adatper_holes() {
	// montazni diry na vetraky
	translate([fan_tolerance/-2-(fan_size-fan_pitch)/2, -1.5, 0]) rotate(a=[90, -90, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([fan_tolerance/-2-(fan_size-fan_pitch)/2-fan_pitch, -1.5, 0]) rotate(a=[90, -90, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([fan_tolerance/2+(fan_size-fan_pitch)/2, -1.5, 0]) rotate(a=[90, -90, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([fan_tolerance/2+(fan_size-fan_pitch)/2+fan_pitch, -1.5, 0]) rotate(a=[90, -90, 0]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	// diry na pridelani k platum
	translate([mount_distance/-2+adapter_thickness/2, mount_pile_size - (mount_plate_size-mount_pitch)/2, 0]) rotate(a=[90, -90, 90]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([mount_distance/-2+adapter_thickness/2, mount_pile_size - (mount_plate_size-mount_pitch)/2 - mount_pitch, 0]) rotate(a=[90, -90, 90]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([mount_distance/2-adapter_thickness/2, mount_pile_size - (mount_plate_size-mount_pitch)/2, 0]) rotate(a=[90, -90, 90]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);
	translate([mount_distance/2-adapter_thickness/2, mount_pile_size - (mount_plate_size-mount_pitch)/2 - mount_pitch, 0]) rotate(a=[90, -90, 90]) nut_hole(0, 20, nut_diameter=M3_nut_D, hole_dia=M3_screw_D);


}

module fanduct_adapter() {
	difference() {
		fanduct_adapter_base();
		fanduct_adatper_holes();
	}
}

fanduct_adapter();