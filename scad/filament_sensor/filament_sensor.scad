sensor_pcb_w = 27;
sensor_pcb_h = 23;

sensor_w = sensor_pcb_w +5;
sensor_h = sensor_pcb_h + 30;
sensor_d = 15;
wall_thickness = 2.5;

module insert_nut_cover() {
	inner_d = 3.7;
	outer_d = inner_d+4;
	cover_h = 5;
	difference() {
		cylinder(d=outer_d, h=cover_h+wall_thickness, $fn=100);
		translate([0, 0, wall_thickness]) cylinder(d=inner_d, h=cover_h+wall_thickness, $fn=100);
	}
}

module sensor_base() {
	base_w = sensor_w+2*wall_thickness;
	base_h = sensor_h+2*wall_thickness;

	difference() {
		cube(size=[base_w, base_h, sensor_d], center=true);
		translate([0, 0, wall_thickness]) cube(size=[sensor_w, sensor_h, sensor_d], center=true);
		// connector cutout

	}
	// pcb holders
	pcb_y_offset = 10;
	translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3, sensor_d/-2]) insert_nut_cover();
	translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3+16.5, sensor_d/-2]) insert_nut_cover();
	// tmp pcb
	translate([sensor_w/-2, sensor_h/-2+pcb_y_offset, 0]) cube(size=[sensor_pcb_w, sensor_pcb_h, 1.6]);

}

sensor_base();