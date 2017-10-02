/* 
   === RebeliX BoX ===

   z bearing top holder
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/
//include <../configuration.scad>
include <../inc/functions.scad>

part_width = profile_width;
holder_height = 9;

corner_rad = 4;

module Z_bearing_holder_base()
{
  hull()
  {
  translate([-profile_width/2 + corner_rad/2,0,0]) rounded_box(profile_width + corner_rad,part_width,coupler_thickness,corner_rad,1,1,1,1);
  
  translate([(big_bearing_OUT_D + 10)/2,0,0]) cylinder(d=big_bearing_OUT_D + 8,h=coupler_thickness,$fn=64,center=true);
  }	  
  translate([(big_bearing_OUT_D + 10)/2,0,-coupler_thickness/2 + holder_height/2]) cylinder(d=big_bearing_OUT_D + 8,h=holder_height,$fn=64,center=true);
}

module Z_bearing_holder_cuts()
{ 
  // Otvory pro sroub
  translate([-profile_width/2,0,0])cylinder(d=M6_screw_D,h=20,$fn=32,center=true);
  
  // Otvor pro lozisko
  translate([(big_bearing_OUT_D + 10)/2,0,-coupler_thickness/2 + holder_height]) cylinder(d=big_bearing_OUT_D + 0.1,h=2*bearing_608_H,$fn=64,center=true);
  
  translate([(big_bearing_OUT_D + 10)/2,0,0]) cylinder(d=17,h=40,$fn=64,center=true);
}

module Z_bearing_holder()
{
  difference()
  {
	Z_bearing_holder_base();
	Z_bearing_holder_cuts();
  }
}

Z_bearing_holder();

