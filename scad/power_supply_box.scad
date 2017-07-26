/* 
   === RebeliX BoX ===

   power supply box
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

include </inc/functions.scad>

// Sirka EURO konektoru
power_plug_W = 50;
// Vydalenost sroubu na EURO konektoru
power_plug_screws_dist = 40;

// Sirka vypinace 230V
power_switch_W = 21;

// Tloustka steny krabicky
wall_W = 3;

part_height = profile_width + 5;
part_width = 50;
part_length = 50 + 21 + 2*wall_W + 5;

sloupek_D = 8;

// Tloustka vicka
lid_height = 4;

tunnel_height = part_height - 17;
tunnel_length = 25;
tunnel_width = 30;
tunnel_offset = 10;
tunnel_hole_offset = 26;

corners_mount_holes = [
  [part_length/2 - wall_W - 3, part_width/2 - wall_W - 3, 0],
  [part_length/2 - wall_W - 3, -part_width/2 + wall_W + 3, 0],
  [-part_length/2 + wall_W + 3, -part_width/2 + wall_W + 3, 0],
  [-part_length/2 + wall_W + 3, part_width/2 - wall_W - 3, 0]
];

module power_base()
{
  // Zakladna
  rounded_box(part_length,part_width,part_height,corner_rad,1,1,1,1);
  
  // Prichyceni na profil
  translate([0,-part_width/2,part_height/2 - profile_width/2]) rotate([90,0,0]) drazka_vertical(part_length - 6,1);
  
  translate([part_length/2,0,part_height/2 - profile_width/2]) rotate([90,0,-90]) drazka_vertical(part_width - 6,1);
  
  // Tunel pro kabely 230V
  translate([-tunnel_length/2,-part_width/2 + tunnel_width/2 + tunnel_offset,-part_height/2 + tunnel_height/2]) cube([tunnel_length + part_length,tunnel_width,tunnel_height],center=true);
}

module power_holes()
{ 
  difference()
  {
    // Vnitrni vyrez
    translate([0,0,wall_W]) rounded_box(part_length - 2*wall_W,part_width - 2*wall_W,part_height,corner_rad,1,1,1,1);
	
    // Sloupky pro prisroubovani krytu
    for (a = corners_mount_holes)
    translate(a)
    {
      cylinder(d=sloupek_D,h=part_height,$fn=32,center=true);
    }	
  }
	
  // Otvory pro srouby
  for (a = corners_mount_holes)
  translate(a + [0,0,part_height/2])
  {
    cylinder(d=2.2,h=part_height,$fn=32,center=true);
  }

  // Vyrez pro kryt
  translate([0,0,part_height/2]) rounded_box(part_length - 2*wall_W,part_width - 2*wall_W,lid_height,corner_rad,1,1,1,1);
	
  // Otvory na pridelani
  translate([0,-part_width/2,part_height/2 - profile_width/2]) rotate([90,0,0]) cylinder(d=M6_screw_D,h=30,$fn=32,center=true);
  
  translate([part_length/2,0,part_height/2 - profile_width/2]) rotate([0,90,0]) cylinder(d=M6_screw_D,h=30,$fn=32,center=true);
	
  // Otvor pro profilovou matku
  translate([0,-part_width/2 - 3/2,part_height/2 - profile_width/2]) cube([profile_nut_W,3,10],center=true);
	
  translate([part_length/2 + 3/2,0,part_height/2 - profile_width/2]) cube([3,profile_nut_W,10],center=true);
	
  // Otvory pro zip pasky
  translate([part_length/2 - 15,part_width/2,part_height/2 - profile_width/2]) rotate([0,90,0]) zip_paska(6);
  
  translate([-part_length/2 + 15,part_width/2,part_height/2 - profile_width/2]) rotate([0,90,0]) zip_paska(6);
  
  // Tunel pro kabely
  difference()
  {
    translate([-part_length/2,-part_width/2 + tunnel_width/2 + tunnel_offset,tunnel_height/2 - tunnel_hole_offset/2 + 0.004]) cube([2*tunnel_length + 1,tunnel_width - 2*2,tunnel_height - (part_height - tunnel_hole_offset)],center=true); 
  
    translate([-part_length/2 - tunnel_length/4,-part_width/2 + tunnel_width/2 + tunnel_offset,-part_height/2 + tunnel_height/2  - lid_height/4]) cylinder(d=8,h=tunnel_height - lid_height/2,$fn=32,center=true);
  }
  
  // Otvor na pridelani vicka tunelu
  translate([-part_length/2 - tunnel_length/4,-part_width/2 + tunnel_width/2 + tunnel_offset,-part_height/2 + tunnel_height]) cylinder(d=2,h=tunnel_height,$fn=32,center=true);
}

module euro_connector()
{
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

module power_switch()
{
  // Vyrez pro vypinac
  translate([0,0,10/2]) cube([7,22,10],center=true);
  cube([13,19.2,20],center=true);
}

module lid_base()
{
  rounded_box(part_length - 2*wall_W - 0.3,part_width - 2*wall_W - 0.3,lid_height,corner_rad,1,1,1,1);
  
  translate([0,0,-lid_height/4]) rounded_box(part_length,part_width,lid_height/2,corner_rad,1,1,1,1);	
  
  // Sloupky pro srouby od Euro zastrcky 
  translate([-part_length/2 + power_plug_W/2 + 1.6 - power_plug_screws_dist/2,0,1]) cylinder(d=6,h=lid_height + 2,$fn=32,center=true);
  
  translate([-part_length/2 + power_plug_W/2 + 1.6 + power_plug_screws_dist/2,0,1]) cylinder(d=6,h=lid_height + 2,$fn=32,center=true);
}

module lid_holes()
{		
  // Otvory pro srouby
  for (a = corners_mount_holes)
  translate(a)
  {
	cylinder(d=3,h=part_height,$fn=32,center=true);
    translate([0,0,-lid_height/4]) cylinder(d1=6,d2=3,h=2 + 0.1,$fn=32,center=true);	
  }
	
  // Vyrez pro vypinac	
  translate([part_length/2 - 2*wall_W - power_switch_W/2,0,-lid_height/2 + 1.3]) rotate([0,0,90]) power_switch();
  
  // Euro konektor
  translate([-part_length/2 + power_plug_W/2 + 1.6,0,0]) rotate([0,0,0]) euro_connector();
}

module tunnel_lid_base()
{
  cube([tunnel_length,tunnel_width - 2*2 - 0.4,lid_height],center=true);
  
  translate([0,0,-lid_height/4]) cube([tunnel_length,tunnel_width,lid_height/2],center=true);
}

module tunnel_lid_holes()
{
  translate([tunnel_length/4,0,0])
  {
    cylinder(d=3,h=part_height,$fn=32,center=true);
    translate([0,0,-lid_height/4]) cylinder(d1=6,d2=3,h=2 + 0.1,$fn=32,center=true);
  }
}

module tunnel_lid()
{
  difference()
  {
    tunnel_lid_base();
    tunnel_lid_holes();
  }
}

module lid()
{
  difference()
  {
    lid_base();
    lid_holes();
  }
}

module power_cover()
{
  difference()
  {
	power_base();
    power_holes();
  } 
}


translate([-part_length/2 - tunnel_length/2 - 5,-part_width - 2,-part_height/2 + lid_height/2]) 
tunnel_lid();

//translate([0,0,part_height/2]) mirror([0,1,0]) rotate([180,0,0]) 

// Pozice pro tisk
translate([0,-part_width - 2,-part_height/2 + lid_height/2]) 
mirror([0,1,0])
lid();

//mirror([0,0,0]) 
power_cover();



