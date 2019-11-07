difference() {
	union() {
		import("JS_FGLCD_Case_Dock.stl");
		translate([0, -20, -4]) cube(size=[100, 20, 5], center=true);

	}

	translate([-35, -33, -10]) cylinder(d=3.5, h=15, $fn=100);
	translate([-35, -33, -6.5+2]) cylinder(d=8, h=15, $fn=100);

	translate([35, -33, -10]) cylinder(d=3.5, h=15, $fn=100);
	translate([35, -33, -6.5+2]) cylinder(d=8, h=15, $fn=100);


}

