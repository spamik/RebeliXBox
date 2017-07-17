/* 
   === RebeliX BoX ===

   Blower base 50 mm SUNON
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

//include <../configuration.scad>
include <functions.scad>

fan_height = 15.8;
base_thick = 3;

x1 = 20;
x2 = -23;
y1 = -17.1;
y2 = 21.1;

pos_x = x2 + (x1 - x2)/2;
pos_y = y1 + (y2 - y1)/2;

// Prodlouzeni vydechu oproti datasheetu
vydech_extra = 4;
// Uhel vydech
vydech_angle = 30 - 10;
// Tloustku mezery vydechu
space_thick = 4;

vydech_nasunuti = 2;

vydech_width = 35;
vydech_offset = 0;
//vydech_height = fan_height + 2*base_thick;
vydech_length = 12 + vydech_extra;

vydech_delka = 51.6/2;

// Jak je stred trysku vzdaleny od stredu vydechu
nozzle_offset = 30 + 1 - 7;

module blower_fan_base(base_height,cut = 0)
{
  vydech_height = fan_height + base_height + 3;
  
  hull()
  {  
    translate([x1,y1,0]) cylinder(d=8,h=base_height,$fn=32,center=true);
    translate([x2,y2,0]) cylinder(d=8,h=base_height,$fn=32,center=true);
  }	
  translate([pos_x, pos_y,0]) cylinder(d=48.9,h=base_height,$fn=64,center=true);
  
  
  intersection()
  {
    translate([pos_x - 2.8 + 0.5, pos_y-2.8 + 0.5,0]) cylinder(d=48.9,h=base_height,$fn=64,center=true);
    translate([pos_x + 48.9/2 + 20/2 - 51.7,pos_y + 48.9/2 + 51.6/2 - 51.6,0]) cube([20,51.6,base_height],center=true);
  }	
  
  // Vydech
  translate([pos_x + 48.9/2 + 20/2 - 51.7 + 0.5,pos_y + 48.9/2 + vydech_delka/2 - 51.6,0]) cube([20,vydech_delka,base_height],center=true);    
  
  if(!cut)
  {
    translate([pos_x + 48.9/2 + 20 - 51.7 - 2 - 3.5,pos_y + 48.9/2 - 51.6 - vydech_length/2 + 2/2 + 2/2,vydech_height/2 - base_height/2]) rounded_box(nozzle_offset + 6 + 5,vydech_length + 2,vydech_height,4,1,1,1,1);
	
	translate([pos_x - 7 - 3.5, pos_y - 20,0]) cube([48.9 - 20,48.9 - 20,base_height],center=true);
  }
  
  if(cut)
  {  
	// Prodlouzeni vydechu
	translate([pos_x + 48.9/2 + 20/2 - 51.7 + 0.5,pos_y + 48.9/2 + vydech_delka/2 - 51.6 - vydech_extra/2,0]) cube([20,vydech_delka + vydech_extra,base_height],center=true);
  
	//translate([pos_x + 48.9/2 - 51.7 + 6/2 + nozzle_offset/2,pos_y + 48.9/2 + vydech_delka/2 - 51.6 - vydech_delka/2 - vydech_extra,0]) rounded_box(nozzle_offset + 6,6,fan_height,4,1,0,1,0);
	translate([pos_x + 48.9/2 - 51.7 + 6/2 + nozzle_offset/2 + 0.5/2,pos_y + 48.9/2 + vydech_delka/2 - 51.6 - vydech_delka/2 - vydech_extra,layer_height]) rounded_box(nozzle_offset + 6 - 0.5,6,fan_height + 2*layer_height,4,1,0,1,0);

  
	intersection()
	{
	  translate([pos_x + 48.9/2 - 51.7 + 6 + nozzle_offset - 20/2,pos_y + 48.9/2 + vydech_delka/2 - 51.6 - vydech_delka/2 - vydech_extra -20/2,0]) cube([20,20,fan_height],center=true);
	
	  translate([pos_x + 48.9/2 - 51.7 + 6 + nozzle_offset - 20,pos_y + 48.9/2 - 51.6 - vydech_extra - 6/2,base_height/2]) rotate([-90 - vydech_angle,0,0])
      {
	    cube([20,40,20],center=false);
      }	
	}
	
	translate([pos_x + 48.9/2 - 51.7 + 6 + nozzle_offset - 20,pos_y + 48.9/2 - 51.6 - vydech_extra - 6/2,base_height/2]) rotate([-90 - vydech_angle,0,0])
    {
	  cube([20,40,3],center=false);
    }
	
	translate([pos_x + 48.9/2 - 51.7 + 6 + nozzle_offset - 100/2,pos_y + 48.9/2 - 51.6 - vydech_extra - 6/2,base_height/2]) rotate([-90 - vydech_angle,0,0])
    {
	  translate([0,-10,-3 - 2 - 10]) 
	  cube([100,40,3 + 10],center=false);
    }
	
	// Seriznuti vydechu

	// Vyrez pro zasunuti
	translate([pos_x + 48.9/2 - 51.7,pos_y + 48.9/2 + 15/2 - 51.6,-1]) cube([3.5,15,4],center=true);
	
	translate([pos_x + 48.9/2 - 51.7 - 3.5/2,pos_y + 48.9/2 + 15/2 - 51.6 - 15/2,-1 - 4/2 + 4]) rotate([0,40,0]) cube([3.5,15,4],center=false);
  
	translate([pos_x, pos_y - 48.9/2,-1]) cube([15,3.5,4],center=true);
	translate([pos_x - 15/2, pos_y - 48.9/2 - 3.5/2,-1 - 4/2 + 4]) rotate([-40,0,0]) cube([15,3.5,4],center=false);

    // Otvory pro srouby
    translate([x1,y1,0]) cylinder(d=2.4,h=fan_height + 20,$fn=32,center=true);
    translate([x2,y2,0]) cylinder(d=2.4,h=fan_height + 20,$fn=32,center=true);  
  } 
}

module blower_fan_holes(base_height)
{ 
  // Otvory pro srouby
  translate([x1,y1,0]) cylinder(d=2.4,h=base_height + 20,$fn=32,center=true);
  translate([x2,y2,0]) cylinder(d=2.4,h=base_height + 20,$fn=32,center=true);	
  
  // Stred
  //cylinder(d=31.7,h=height + 1,$fn=64,center=true);
}

module blower_fan(base_height = 15,cut = 0)
{
  difference()
  {
	blower_fan_base(base_height,cut);
    blower_fan_holes(base_height,cut);
  } 
}

  //blower_fan(base_thick,0);
  translate([0,0,fan_height/2 + base_thick/2]) blower_fan(fan_height,0);
  //blower_fan_base(3,0);



