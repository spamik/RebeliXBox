include </inc/functions.scad>

nema17_size = 42;
nema17_pitch = 31;
plate_thickness = 4;
mount_plate_thickness = 13;
plate_overlap = (65.4 - 54)/2;
fan_overlap = 10;
straight_mounts_pitch = 11;
vertical_mounts_pitch = 29.8;
vertical_mounts_pitch_z = 3.8;


module bmg_motor_plate() {
	difference() {
		union() {
			cube(size=[nema17_size, nema17_size, plate_thickness], center=true);
			translate([nema17_size/-2, 0, plate_thickness/-2]) cube(size=[nema17_size, nema17_size/2+mount_plate_thickness+plate_thickness, plate_thickness]);
			translate([nema17_size/-2, nema17_size/2+mount_plate_thickness, plate_thickness/-2]) cube(size=[nema17_size, plate_thickness, plate_thickness+plate_overlap]);
			translate([nema17_size/-2, nema17_size/-2, plate_thickness/-2]) cube(size=[nema17_size+fan_overlap, nema17_size, plate_thickness]);
		}
		// diry pro motory
		translate([nema17_pitch/-2, nema17_pitch/2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		translate([nema17_pitch/-2, nema17_pitch/-2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		translate([nema17_pitch/2, nema17_pitch/2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		translate([nema17_pitch/2, nema17_pitch/-2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		// hridel od motoru
		cylinder(d=22.5, h=plate_thickness*2, $fn=100, center=true);
		// diry pro fan / etc
		translate([nema17_pitch/2+fan_overlap, nema17_pitch/2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		translate([nema17_pitch/2+fan_overlap, nema17_pitch/-2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		// diry pro uchyceni do platu - prime
		translate([straight_mounts_pitch/-2, nema17_size/2+mount_plate_thickness/2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		translate([straight_mounts_pitch/2, nema17_size/2+mount_plate_thickness/2, 0]) cylinder(d=M3_screw_D, h=plate_thickness*2, $fn=100, center=true);
		// diry pro uchyceni do platu - bocni
		translate([vertical_mounts_pitch/-2, 0, plate_thickness/2+vertical_mounts_pitch_z]) rotate(a=[90, 0, 0]) cylinder(d=M3_screw_D, h=(nema17_size+mount_plate_thickness)*2, $fn=100, center=true);
		translate([vertical_mounts_pitch/2, 0, plate_thickness/2+vertical_mounts_pitch_z]) rotate(a=[90, 0, 0]) cylinder(d=M3_screw_D, h=(nema17_size+mount_plate_thickness)*2, $fn=100, center=true);
	}

}

bmg_motor_plate();
//translate([70, nema17_size/2, 0]) mirror([0, 1, 0]) bmg_motor_plate();