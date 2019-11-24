holder_length = 54;
mount_screws_pitch = 37;
screw_dia = 3.6;
screw_top = 6;
wall_thick = 4;
plate_height = 43;
hose_dia = 5;
plate_hose_offset = 25;

module bmg_water_holder() {
	difference() {
		union() {
			cube(size=[holder_length, 2*screw_top, wall_thick], center=true);
			translate([0, 0, plate_height/2 - wall_thick/2]) cube(size=[mount_screws_pitch - 2.8*screw_dia, 2*screw_top, plate_height], center=true);
		}
		// srouby na pridelani k BMG
		translate([mount_screws_pitch/-2, 0, -wall_thick]) cylinder(d=screw_dia, h=wall_thick*2, $fn=100);
		translate([mount_screws_pitch/2, 0, -wall_thick]) cylinder(d=screw_dia, h=wall_thick*2, $fn=100);

		// srouby na hadice
		translate([0, screw_top+1, plate_hose_offset]) rotate(a=[90, 0, 0]) cylinder(d=hose_dia, h=4*screw_top, $fn=100);
		translate([-10, screw_top+1, plate_hose_offset]) rotate(a=[90, 0, 0]) cylinder(d=hose_dia, h=4*screw_top, $fn=100);
		translate([10, screw_top+1, plate_hose_offset]) rotate(a=[90, 0, 0]) cylinder(d=hose_dia, h=4*screw_top, $fn=100);
		translate([0, screw_top+1, plate_hose_offset+10]) rotate(a=[90, 0, 0]) cylinder(d=hose_dia, h=4*screw_top, $fn=100);



	}
}

bmg_water_holder();