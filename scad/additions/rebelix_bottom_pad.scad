d1 = 20;
d2 = 17;
h = 30;

$fn=100;

difference() {
	cylinder(d1=d1, d2=d2, h=h);
	translate([0, 0, h-3]) cylinder(d=d2/2, h=h);
}