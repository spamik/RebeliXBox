include </inc/functions.scad>


blt_h1 = 13;
blt_h2 = 8;
blt_w1 = 34;
blt_w2 = 25;
blt_thickness = 5;

module blt_plate() {
	difference() {
		union() {
			cube(size=[blt_w1, blt_h1, blt_thickness], center=true);
			translate([0, blt_h2/2, 0]) cube(size=[blt_w2, blt_h1+blt_h2, blt_thickness], center=true);
		}
		// srouby na pridelani k platu
		translate([35/-2+M3_nut_D/2, 0, 0]) cylinder(d=M3_screw_D, h=blt_thickness*2, $fn=100, center=true);
		translate([35/2-M3_nut_D/2, 0, 0]) cylinder(d=M3_screw_D, h=blt_thickness*2, $fn=100, center=true);
		// srouby na prisroubovani BLTouche
		translate([-9, 13/2+8-5.8+1, 0]) cylinder(d=M3_screw_D, h=blt_thickness*2, $fn=100, center=true);
		translate([9, 13/2+8-5.8+1, 0]) cylinder(d=M3_screw_D, h=blt_thickness*2, $fn=100, center=true);
		// vyrez na pruchod kabelu BLTouche
		translate([0, 13/2+8-0.5, 0]) cube(size=[7, 5, blt_thickness*2], center=true);
		// vyrez na kabely do platu
		translate([0, blt_h1/-2+2, 0]) cube(size=[17, 6, blt_thickness*2], center=true);
	}
}

 blt_plate();
