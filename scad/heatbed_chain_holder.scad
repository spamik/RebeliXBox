holes_pitch = 30;
walls = 3;
chain_height = 10;
chain_pitch = 10;
hole_size = 3.5;
h_base = 100;

w = holes_pitch + 4*walls;


module hb_chain_holder() {
	difference() {
		translate([w/-2, h_base/-2, 0]) union() {
			cube(size=[w, h_base, walls]);
			cube(size=[w, walls, chain_height]);
		}
		cube(size=[hole_size, h_base-3*walls, walls*5], center=true);
		translate([holes_pitch/-2, 0, 0]) cube(size=[hole_size, h_base-3*walls, walls*5], center=true);
		translate([holes_pitch/2, 0, 0]) cube(size=[hole_size, h_base-3*walls, walls*5], center=true);

		translate([chain_pitch/-2, h_base/-2+walls+1, chain_height/2]) rotate(a=[90, 0, 0]) cylinder(d=hole_size, h=walls*3, $fn=100);
		translate([chain_pitch/2, h_base/-2+walls+1, chain_height/2]) rotate(a=[90, 0, 0]) cylinder(d=hole_size, h=walls*3, $fn=100);
	}
}

module chain_profile_pad() {
	difference() {
		cube(size=[26, 30, walls], center=true);
		translate([chain_pitch/-2, 0, walls*-1]) cylinder(d=hole_size, h=walls*2, $fn=100);
		translate([chain_pitch/2, 0, walls*-1]) cylinder(d=hole_size, h=walls*2, $fn=100);
	}
}

//hb_chain_holder();
chain_profile_pad();