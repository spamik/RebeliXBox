

module c13_connector()
{
  // Vydalenost sroubu na EURO konektoru
  power_plug_screws_dist = 36;
  difference()
  {
    cube([27.8,19.8,10],center=true);
    translate([7.5,19.8/2,-10]) rotate([0,0,-45]) cube([20,20,20]);
	  translate([-7.5,19.8/2,-10]) rotate([0,0,135]) cube([20,20,20]);
  }
  // Otvory pro srouby
  translate([power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  translate([-power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  
  //%cube([50,22,10],center=true);
}

module c14_connector()
{
  // Vydalenost sroubu na EURO konektoru
  power_plug_screws_dist = 40;
  difference()
  {
    cube([32.8,24.8,10],center=true);
    translate([9,24.8/2,-10]) rotate([0,0,-45]) cube([20,20,20]);
    translate([-9,24.8/2,-10]) rotate([0,0,135]) cube([20,20,20]);
  }
  // Otvory pro srouby
  translate([power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  translate([-power_plug_screws_dist/2,0,0]) cylinder(r=1.2,h=20,$fn=16,center=true);
  
  //%cube([50,22,10],center=true);
}

module 2p_switch() {
  cube(size=[31, 22.5, 10], center=true);
}

/*
c13_connector();
translate([0, 50, 0]) c14_connector();
translate([0, -50, 0]) 2p_switch();*/