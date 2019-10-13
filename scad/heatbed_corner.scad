hb_thick = 8;
hb_x = 60;
hb_y = 45;
hb_overlap = 2.8;
corner_size = 11;

screw_size = 4.5;
screw_offset = 35;
spring_hole = 8.3;

module hb_corner() {
	
		translate([corner_size-0.01, corner_size-0.01, 0]) difference() {
			union() {
				cube(size=[hb_x, hb_y, hb_thick]);
				translate([-corner_size+0.01, -corner_size+0.01, -hb_overlap]) cube(size=[hb_x+corner_size-0.01, corner_size, hb_thick+hb_overlap]);
				translate([-corner_size+0.01, -corner_size+0.01, -hb_overlap]) cube(size=[corner_size, corner_size+hb_y-0.01, hb_thick+hb_overlap]);
			}
			translate([hb_thick, 0, -1]) cube(size=[hb_x-2*hb_thick, hb_y-20, hb_thick+2]);
			translate([screw_offset, screw_offset, -1]) cylinder(d=screw_size, h=hb_thick+2, $fn=100);

			// spring hole
			translate([-corner_size/2, -corner_size/2, -hb_overlap-1]) cylinder(d=screw_size, h=1+hb_thick/2, $fn=100);
			translate([-corner_size/2, -corner_size/2, -hb_overlap+hb_thick/2+0.3]) cylinder(d=spring_hole, h=hb_thick, $fn=100);

		}
	
}

hb_corner(); // top right / bottom left
//mirror([1, 0, 0]) hb_corner(); // top left / bottom right
