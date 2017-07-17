/* 
   === RebeliX BoX ===

   Fuknce pouzivane v projektu
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

include <../../configuration.scad>

/*========================== Funkce ==========================*/

// Drazka pro pridelani do profilu
module drazka(length = 30)
{ 
  height = 3;
  
  distance = M6_screw_D >= profile_nut_W ? M6_screw_D : profile_nut_W;
  hrana = length/2 - distance/2 - 2*2;
  
  // 1. strana
  translate([-length/2 + 2,-8/2 + 2,0]) cylinder(d=4,h=height,$fn=16,center=true); 
  translate([-length/2 + 2, 8/2 - 2,0]) cylinder(d=4,h=height,$fn=16,center=true);
  
  translate([-distance/2 - 2,-8/2 + 2,0]) cylinder(d=4, h=height, $fn=32, center=true);
  translate([-distance/2 - 2,8/2 - 2,0]) cylinder(d=4, h=height, $fn=32, center=true);
  
  translate([-length/2 + hrana/2 + 2,0,0]) cube([hrana,8,height],center=true); 
  translate([-length/2 + hrana/2 + 2,0,0]) cube([hrana + 4,4,height],center=true);
  
  // 2. strana  
  translate([length/2 - 2,-8/2 + 2,0]) cylinder(d=4,h=height,$fn=16,center=true); 
  translate([length/2 - 2, 8/2 - 2,0]) cylinder(d=4,h=height,$fn=16,center=true);
  
  translate([distance/2 + 2,-8/2 + 2,0]) cylinder(d=4, h=height, $fn=32, center=true);
  translate([distance/2 + 2,8/2 - 2,0]) cylinder(d=4, h=height, $fn=32, center=true);
  
  translate([length/2 - hrana/2 -2,0,0]) cube([hrana,8,height],center=true);
  translate([length/2 - hrana/2 - 2,0,0]) cube([hrana + 4,4,height],center=true);  
}

module drazka_vertical(length = 30, screws = 2)
{ 

  height = 3;
  
  distance = M6_screw_D >= profile_nut_W ? M6_screw_D : profile_nut_W;
  hrana = length/2 - distance/2 - 2*4;
   
  difference()
  {
    cube([length,8,height],center=true);
 	
	if(screws == 2)
	{
	  for(i=[-1,1])
	  {
	    translate([i*length/2 -i*M6_washer_D/2,0,3/2]) cube([profile_nut_W,10,3],center=true);
	  }
	}
	else
	{
	  //translate([0,0,3/2]) cube([profile_nut_W,10,3],center=true);
	}
	
	// Seriznuti pro snazsi tisk
	translate([-length/2 - 1,-8/2,0]) rotate([30,0,0]) cube([length + 2,8,height]);
  }
} 

module profile_nut(len = profile_width)
{
  // Vyrez pro profilovou matku
   cube([3,len,profile_nut_W],center=true);
  intersection()
  {
    translate([3/2,len/2,profile_nut_W/2]) rotate([0,40,180]) cube([3,len,profile_nut_W],center=false);
	cube([3,len,2*profile_nut_W],center=true);
  }	
}

// Otvor pro maticku
module nut(nut_diameter=M3_nut_D,nut_height=3){
	cylinder(r=nut_diameter/2,h=2*nut_height,$fn=6,center=true);
}

// Otvor pro maticku
module nut_hole(solid_layer=0,hole_length=30,nut_diameter = M3_nut_D,nut_height = M3_nut_H,hole_dia=M3_screw_D)
{
  cylinder(d=nut_diameter,h=nut_height,$fn=6,center=true);
  translate([30/2,0,0]) cube([30,nut_diameter*cos(30),nut_height],center=true);
	
  if(solid_layer)
  {
    translate([0,0,5 + 3/2 + layer_height]) cylinder(d=hole_dia,h=10,$fn=16,center=true);
    translate([0,0,-10/2 - 3/2 + 0.001]) cylinder(d=hole_dia,h=10,$fn=16,center=true);
  } else 
  {
    cylinder(d=hole_dia,h=hole_length,$fn=16,center=true);
  }
}

// Nema 17
module nema17(places=[1,1,1,1], solid_layer=false, screw_offset = 6, belt_cut = false, shadow = 1,cutout = 0,hole_distance = 0)
{
  size=15.5;
 
  // Priruba motoru
  cylinder(d=23, h = 4, $fn = 64,center=true);

  // Stred motoru
  cylinder(d=20, h = 2*motor_width, $fn = 32,center=true);

  // Vyrez pro remen
  if(belt_cut)
  {
    translate([motor_width,0,0]) cube([2*motor_width,23,4],center=true);
    translate([0,-20/2,0]) cube([2*motor_width,20,motor_width]);
  }

  for (i=[0:3])
  {
    if (places[i] == 1)
    {
      rotate([0, 0, 90*i]) translate([size, size, 0])
	  { 
	    translate([0,0,screw_offset]) screw_hole(solid_layer);
      }	  
    }
  }

  if (shadow) 
  {
    // Motor
    %translate([0,0,-motor_length/2]) cube([motor_width,motor_width,motor_length],center=true);
    // Osicka
    %cylinder(d=5,h=40,$fn=16,center=true);
  }
}

// Otvor pro sroub
module screw_hole(solid_layer=0,hole_distance = 0,head_diameter=M3_head_D,hole_dia=M3_screw_D,$fn=32)
{	
	if(hole_distance > 0)
	{
	  for(i=[-1,1])
	  {
		translate([i*hole_distance/2,0,40/2]) cylinder(d=head_diameter,h=40,$fn=32,center=true);
		translate([i*hole_distance/2,0,solid_layer ? -40/2 - layer_height: -40/2 + 1]) cylinder(d=hole_dia,h=40,$fn=16,center=true);  
	  }
	  translate([0,0,40/2]) cube([hole_distance,head_diameter,40],center=true);
	  translate([0,0,solid_layer ? -40/2 - layer_height: -40/2 + 1]) cube([hole_distance,hole_dia,40],center=true);
	
	} else {
	  translate([0,0,40/2]) cylinder(d=head_diameter,h=40,$fn=$fn,center=true);
	  translate([0,0,solid_layer ? -40/2 - layer_height: -40/2 + 1]) cylinder(d=hole_dia,h=40,$fn=32,center=true);
	}
}

// Otvory pro maticky v kolejnici
module rail_holes(holes_number = 2, holes_distance = rail_hole_distance)
{
  for(i=[0:holes_distance:(holes_number - 1)*holes_distance])
  {
    translate([i,0,0]) rail_nut(1);
  }	
}
// Maticka pro kolejnici
module rail_nut(solid_layer=0, nuts_distance = 4, nut_diameter = M3_nut_D, nut_height = M3_nut_H,hole_dia = M3_screw_D)
{	
	if(solid_layer)
	{
	  // Otvor pro sroub
	  translate([nuts_distance/2,0,30/2 + nut_height + layer_height]) cylinder(d=hole_dia,h=30,$fn=16,center=true);
	  
	  translate([-nuts_distance/2,0,30/2 + nut_height + layer_height]) cylinder(d=hole_dia,h=30,$fn=16,center=true);
	  
	  translate([0,0,30/2 + nut_height + layer_height]) cube([nuts_distance,hole_dia,30],center=true);
	  
	  // Otvor pro maticku
	  translate([nuts_distance/2,0,0]) cylinder(r=nut_diameter/2,h=2*nut_height,$fn=6,center=true);
	  
	  translate([-nuts_distance/2,0,0]) cylinder(r=nut_diameter/2,h=2*nut_height,$fn=6,center=true);
	  
	  cube([nuts_distance,nut_diameter*cos(30),2*nut_height],center=true);
	  
	} else 
    {
	  cylinder(d=hole_dia,h=60,$fn=16,center=true);
	}
}

// Otvor pro zip pasku
module zip_paska(r_vnejsi)
{
  difference()
  {
    cylinder(r=r_vnejsi,h=3.5,$fn=32,center=true);
    cylinder(r=r_vnejsi-2,h=4,$fn=32,center=true);
  }
}

// Zaoblene rohy
module rounded_box(x, y, z, rdim = 6, r1 = 1,r2 = 1,r3 = 1,r4 = 1)
{
  // r1 - r4 urcuje, ktery roh bude zakulaceny, 1 = zakulaceny
  hull()
  {
    if(r1)
	  translate([-x/2 + rdim/2,-y/2 + rdim/2,0]) cylinder(r=rdim/2,h=z,$fn=16,center=true);
    else
	  translate([-x/2 + rdim/2,-y/2 + rdim/2,0]) cube([rdim,rdim,z],center=true);
	
	if(r2)
	  translate([-x/2 + rdim/2,y/2 - rdim/2,0]) cylinder(r=rdim/2,h=z,$fn=16,center=true);
	else
	  translate([-x/2 + rdim/2,y/2 - rdim/2,0]) cube([rdim,rdim,z],center=true);
	
	if(r3)
	  translate([x/2 - rdim/2,y/2 - rdim/2,0]) cylinder(r=rdim/2,h=z,$fn=16,center=true);
	else
	  translate([x/2 - rdim/2,y/2 - rdim/2,0]) cube([rdim,rdim,z],center=true);
	  
	if(r4)  
      translate([x/2 - rdim/2,-y/2 + rdim/2,0]) cylinder(r=rdim/2,h=z,$fn=16,center=true);
	else
	  translate([x/2 - rdim/2,-y/2 + rdim/2,0])	cube([rdim,rdim,z],center=true);
  }
}

// Trapezova matka
module leadscrew_nut()
{
	// Parametry trapezove matice
	D_leadscrew = 22 + 2*0.6;
	//h_base = 3.6;
	//D_body = 10.6;
	D_body = 12.5;
	screw_offset = 16.3;

	translate([0,0,-50/4]) cylinder(d=D_leadscrew,h=50/2,$fn=64,center=true);
	cylinder(d=D_body,h=100,$fn=64,center=true);
	
	for(i=[0:90:360])
	{
	  rotate([0,0,i]) translate([0,screw_offset/2,0]) cylinder(d=2.4, h=24, $fn=16,center=true);
	}
}

// Vyrez pro remen
module belt_holder_beltcut(len=67, belt_cut_out = belt_lock_thickness, insert_pos = 10)
{
  cut_height = 15;
  position_tweak=-1.1 + 1.1;
  //belt_core_thickness = 0.75;
  //belt_tooth_height = 1.7;
  belt_thickness =  belt_core_thickness + belt_tooth_height;
  
  // Vyrez pro remen
  translate([0,belt_core_thickness/2,cut_height/2]) cube([len,belt_core_thickness,cut_height],center=true);
 
  // Vyrez pro snadnejsi zasunuti remenu
  translate([0,belt_core_thickness/2,insert_pos + 5*cos(45)]) rotate([45,0,0]) cube([len,5,5],center=true);
  
  // Jednotlive zuby
  for ( i = [-round(len/belt_tooth_distance)/2 : round(len/belt_tooth_distance)/2] )
  {
    translate([0-i*belt_tooth_distance+position_tweak,belt_thickness/2,cut_height/2]) cube([belt_tooth_ratio*belt_tooth_distance,belt_thickness,cut_height],center=true);
   }
  // Middle opening
  translate([0,20/2,cut_height/2]) cube([belt_cut_out,20,cut_height],center=true);	
}

// Zakulaceny roh
module fillet(radius, height=100, $fn=0) {
	difference()
	{
	  cube([radius * 2,radius * 2,height],center=true);
	  if ($fn == 0 && (radius == 2 || radius == 3 || radius == 4)) {
            translate([-radius,-radius,0]) cylinder(r=radius, h=height + 0.04, $fn=4 * radius,center=true);
        } else {
            translate([-radius,-radius,0]) cylinder(r=radius, h=height + 0.04, $fn=$fn,center=true);
        }
	
	}
}

// Mrizka honeycomb
module hc_hexagon(size, height) {
	box_width = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) cube([box_width, size, height],
true);
}

module hc_column(length, height, cell_size, wall_thickness) {
   no_of_cells = floor(1 + length / (cell_size + wall_thickness)) ;

        for (i = [0 : no_of_cells]) {
                translate([0,(i * (cell_size + wall_thickness)),0])
                        hc_hexagon(cell_size, height + 1);
        }
}

module honeycomb (length, width, height, cell_size, wall_thickness) {
   no_of_rows = floor(1.75 * length / (cell_size + wall_thickness)) ;

   tr_mod = cell_size + wall_thickness;
   tr_x = sqrt(3)/2 * tr_mod;
   tr_y = tr_mod / 2;
        off_x = -1 * wall_thickness / 2;
        off_y = wall_thickness / 2;
        difference(){
                cube([length, width, height]);
                for (i = [0 : no_of_rows]) {
                        translate([i * tr_x + off_x, (i % 2) * tr_y + off_y, (height) / 2])
                                hc_column(width, height, cell_size, wall_thickness);
                }
        }
}
