// LCD case parameters
// Author: Gerhard Gappmeier <gappy1502@gmx.net>

/* 
   === RebeliX BoX ===

   LCD case
   GNU GPL v3
   Martin Neruda <neruda@RebeliX.cz>
   http://www.RebeliX.cz
*/

use <../../inc/text_RebeliX.scad>
use <../../inc/text_EXP12.scad>

// Layer height
layer_height = 0.3; 

// screws: M3
screw_diam=3.2;
nut_diam=5.6;
nut_height=3;
delta=0.1; // make it a little bigger
// case size
WIDTH=158; // x-dir
HEIGHT=82 - 10; // y-dir
DEPTH=22;  // z-dir
BOTTOM_WALL_THICKNESS=2;
TOP_WALL_THICKNESS=2;
BOTTOM_HEIGHT=10 ;
PCB_MOUNT_HEIGHT=5; // + BOTTOM_WALL_THICKNESS
TOP_HEIGHT=DEPTH-BOTTOM_HEIGHT;
ETA=0.05;
$fn=40;
// radius for rounded corners
ROUNDED_RADIUS=3;
border_height=2 - 0.5;
// SDCARD HOLDER
SD_HOLDER_WIDTH=26;
SD_HOLDER_HEIGHT=26.5;
SD_HOLDER_DEPTH=3.2;
// MAIN PCB
PCB_WIDTH=150;
PCB_HEIGHT=54.8;
PCB_OFFSET_Y=0 + 4;
PCB_THICKNESS=1.6;
PCB_HOLE_RAD=1.5;
PCB_HOLE_OFFSET=2.54;
// LCD PCB
LCD_PCB_WIDTH=98.4;
LCD_PCB_HEIGHT=60;
LCD_PCB_HOLE_RAD=1.8;
LCD_PCB_HOLE_OFFSET=2.7;
LCD_PCB_OFFSET_X=13.4;
LCD_PCB_OFFSET_Y=3.3;

// LCD cutout size and offset
LCD_WIDTH=97.2;
LCD_HEIGHT=39.9;
LCD_THICKNESS=10;
LCD_OFFSET_X=0.8;
LCD_OFFSET_Y=10.2;

// set to 1 for explode view, 0 otherwise
explode=1;
show_top=1;
show_bottom=1;
// set to 1 to display LCD and PCB, 0 otherwise
show_lcd=1;

// note: The case and the main PCB are centered.
// the LCD PCB and LCD are relative to the main PCB

// rounded cube: x/y centered, z_bottom=0
module rounded_cube(w, h, d) {
    hull() {
        translate([-w/2+ROUNDED_RADIUS, -h/2+ROUNDED_RADIUS, 0]) cylinder(d, r=ROUNDED_RADIUS, center=false);
        translate([w/2-ROUNDED_RADIUS, -h/2+ROUNDED_RADIUS, 0]) cylinder(d, r=ROUNDED_RADIUS, center=false);
        translate([-w/2+ROUNDED_RADIUS, h/2-ROUNDED_RADIUS, 0]) cylinder(d, r=ROUNDED_RADIUS, center=false);
        translate([w/2-ROUNDED_RADIUS, h/2-ROUNDED_RADIUS, 0]) cylinder(d, r=ROUNDED_RADIUS, center=false);
    }
}

// rounded cube: x/y/z centered
module nut_trap(w = 5.6, h = 3) {
    cylinder(r = w / 2 / cos(180 / 6) + delta, h=h+2*delta, $fn=6, center=true);
}
// x/y centered, z=0
module nut_trap_phase(w=5.5, h=0.5) {
    w2=w+2*h;
    translate([0,0,h]) rotate([180,0,0]) linear_extrude(height=h, center=false, scale=w2/w)
        circle(r = w / 2 / cos(180 / 6) + delta, $fn=6);
}

// phased nut trap at the xy plane
// this contains a phased cutout which always makes sense when making nut traps
// on the heat bed
module phased_nut_trap(w=5.4, h=4) {
    translate([0,0,h/2]) nut_trap(w, h);
    //nut_trap_phase(w, 1);
}

// nut trap cube: x/y centered, z_bottom=0
module nut_trap_cube(W=10, H=6) {
    translate([0,0,H/2]) difference() {
        cube([W,W,H], center=true);
        union() {
            translate([0,-W/2,0]) cube([nut_diam+2*delta,W,nut_height+2*delta], center=true);
            rotate([0,0,30]) nut_trap(nut_diam, nut_height);
        }
        cylinder(H+2*ETA,d=screw_diam+delta, center=true);
    }
}

module bottom_border() {
    difference() {
        rounded_cube(WIDTH+ETA, HEIGHT+ETA, border_height);
        translate([0,0,-ETA]) rounded_cube(WIDTH-3, HEIGHT-3, border_height+2*ETA);
    }
}

module bottom() {
    // PCB mounting nut traps
    xoff=PCB_WIDTH/2-PCB_HOLE_OFFSET;
    yoff=PCB_HEIGHT/2-PCB_HOLE_OFFSET;
    // TOP mounting nut traps
    xoff2=WIDTH/2-7;
    yoff2=HEIGHT/2-7;

    difference() {
        union() {
            difference() {
                rounded_cube(WIDTH, HEIGHT, BOTTOM_HEIGHT);
                translate([0,0,BOTTOM_WALL_THICKNESS]) rounded_cube(WIDTH-6, HEIGHT-6, BOTTOM_HEIGHT);
                translate([0,0,BOTTOM_HEIGHT-border_height+ETA]) bottom_border();
                // sd card cutout
                translate([-WIDTH/2-SD_HOLDER_WIDTH/2,8.4-PCB_HEIGHT/2 + PCB_OFFSET_Y,BOTTOM_HEIGHT - SD_HOLDER_DEPTH + ETA]) 
                    cube([SD_HOLDER_WIDTH,SD_HOLDER_HEIGHT,SD_HOLDER_DEPTH], center=false);
            }
            translate([0,PCB_OFFSET_Y,(BOTTOM_HEIGHT - border_height)/2]) {
                translate([-xoff,-yoff,0]) cube([10,10,BOTTOM_HEIGHT - border_height], center=true);
                translate([ xoff,-yoff,0]) cube([10,10,BOTTOM_HEIGHT - border_height], center=true);
                translate([-xoff, yoff,0]) cube([10,10,BOTTOM_HEIGHT - border_height], center=true);
                translate([ xoff, yoff,0]) cube([10,10,BOTTOM_HEIGHT - border_height], center=true);
            }
			// Mount holes
			translate([-WIDTH/2 + 35,-HEIGHT/2,0]) 
			{
			  translate([0,15,0]) cylinder(h=6,d=7, center=false);
			  translate([0,40,0]) cylinder(h=6,d=7, center=false);
			}
		
			translate([WIDTH/2 - 35,-HEIGHT/2,0]) 
			{
			  translate([0,15,0]) cylinder(h=6,d=7, center=false);
			  translate([0,40,0]) cylinder(h=6,d=7, center=false);
			}
        }

        // TOP mount nut traps
        translate([0,PCB_OFFSET_Y,-ETA]) {
            translate([-xoff,-yoff,0]) { phased_nut_trap(); translate([0,0,4 + 2*layer_height]) cylinder(12+ETA,d=screw_diam+delta, center=false); }
            translate([ xoff,-yoff,0]) { phased_nut_trap(); translate([0,0,4 + 2*layer_height]) cylinder(12+ETA,d=screw_diam+delta, center=false); }
            translate([-xoff, yoff,0]) { phased_nut_trap(); translate([0,0,4 + 2*layer_height]) cylinder(12+ETA,d=screw_diam+delta, center=false); }
            translate([ xoff, yoff,0]) { phased_nut_trap(); translate([0,0,4 + 2*layer_height]) cylinder(12+ETA,d=screw_diam+delta, center=false); }
        }
		
		// Mount holes
		translate([-WIDTH/2 + 35,-HEIGHT/2,-2]) 
		{
		  translate([0,15,0]) cylinder(12+ETA,d=2, center=false);
	  	  translate([0,40,0]) cylinder(12+ETA,d=2, center=false);
		}
		
		translate([WIDTH/2 - 35,-HEIGHT/2,-2]) 
		{
		  translate([0,15,0]) cylinder(12+ETA,d=2, center=false);
		  translate([0,40,0]) cylinder(12+ETA,d=2, center=false);
		}
		
		
		// Text EXP1 and EXP2
		translate([1.8,-6,-1 + 0.6]) mirror([1,0,0]) scale([0.7,0.7,1])
		{
		  E_pisemno(1);
		  X_pisemno(1);
		  P_pisemno(1);
		  translate([-15,-10,0]) cislo_1(1);
		}
		
		translate([1.8 - 26,-6,-1 + 0.6]) mirror([1,0,0]) scale([0.7,0.7,1])
		{
		  E_pisemno(1);
		  X_pisemno(1);
		  P_pisemno(1);
		  translate([-6 - 15,-10,0]) cislo_2(1);
		}
		
    }
}

/* Screw:
 * d1: screw diameter
 * d2: screw head diameter
 * h : head height
 * l : screw length
 */
 
module screw(d1,d2,h,l) {
    translate([0,0,-2*layer_height]) cylinder(h=l+ETA,d=d1+delta, center=false);
    translate([0,0,l]) cylinder(h=h+delta,d=d2+delta, center=false);
}

module top() {
    // PCB mounting nut traps
    xoff=PCB_WIDTH/2-PCB_HOLE_OFFSET;
    yoff=PCB_HEIGHT/2-PCB_HOLE_OFFSET;
	
	// TOP mounting nut traps
    xoff2=WIDTH/2-7;
    yoff2=HEIGHT/2-7;
	
    difference() {
        union() {
            translate([0,0,BOTTOM_HEIGHT]) difference() {
                union() {
                    rounded_cube(WIDTH, HEIGHT, TOP_HEIGHT);
                    translate([0,0,-border_height+ETA]) bottom_border();
                }
                translate([0,0,-BOTTOM_WALL_THICKNESS]) rounded_cube(WIDTH-6, HEIGHT-6, TOP_HEIGHT);
				
				// sd card cutout
                //translate([-WIDTH/2-SD_HOLDER_WIDTH/2,8.4-PCB_HEIGHT/2 + PCB_OFFSET_Y,-TOP_HEIGHT/2 + SD_HOLDER_DEPTH + ETA]) 
                 //   cube([SD_HOLDER_WIDTH,SD_HOLDER_HEIGHT,SD_HOLDER_DEPTH], center=false);
            }
            translate([0,PCB_OFFSET_Y,DEPTH-TOP_WALL_THICKNESS-5+ETA]) {
                translate([-xoff,-yoff,0]) { cube([10,10,10], center=true); }
                translate([ xoff,-yoff,0]) { cube([10,10,10], center=true); }
                translate([-xoff, yoff,0]) { cube([10,10,10], center=true); }
                translate([ xoff, yoff,0]) { cube([8,10,10], center=true); }
            }
			// STOP Button
			translate([0,PCB_OFFSET_Y,DEPTH]) {
			  translate([xoff + PCB_HOLE_OFFSET - 13,yoff + PCB_HOLE_OFFSET - 46.5,-(TOP_WALL_THICKNESS + 4.6)/2]) cylinder(r=3,h=TOP_WALL_THICKNESS + 4.6,center=true);
			} 
        }
        // beeper holes
        translate([PCB_WIDTH/2-13,PCB_HEIGHT/2-10,DEPTH-5]) {
            cylinder(10,d=2,center=false);
            translate([-3,0,0]) cylinder(10,d=2,center=false);
            translate([3,0,0]) cylinder(10,d=2,center=false);
        }

		// TOP PCB mount holes
        translate([0,PCB_OFFSET_Y,DEPTH-22.3+ETA]) {
			translate([-xoff,-yoff,0]) { screw(screw_diam, 6.2, 3, 20); }
            translate([ xoff,-yoff,0]) { screw(screw_diam, 6.2, 3, 20); }
            translate([-xoff, yoff,0]) { screw(screw_diam, 6.2, 3, 20); }
            translate([ xoff, yoff,0]) { screw(screw_diam, 6.2, 3, 20); }
        }
		
		// STOP Button
		translate([0,PCB_OFFSET_Y,DEPTH]) {
		  translate([xoff + PCB_HOLE_OFFSET - 13,yoff + PCB_HOLE_OFFSET - 46.5,0]) 
		  {
		    difference()
			{
			  union()
			  {
			    cylinder(d=11,h=20,center=true);
				translate([-17/2,0,0]) cube([17,8,20],center=true);
			  }
			  cylinder(d=11 - 2,h=20,center=true);
			  translate([-17/2,0,0]) cube([17,8 - 2,20],center=true);
			}					  
			  // STOP symbol
			  rotate([0,0,45]) cube([1,6,1],center=true);
			  rotate([0,0,-45]) cube([1,6,1],center=true);
		  }
		}
		
		// Text RebeliX
		translate([0,HEIGHT/2 - 8,DEPTH - 0.6]) scale([0.6,0.6,1]) text_RebeliX(1);
		
    }
}

// same as cube, but x/y centered, z_bottom=0
module pcb(w,h,d) {
    translate([0,0,d/2]) cube([w,h,d], center=true);
}

function main_pcb_z_offset() = BOTTOM_WALL_THICKNESS+PCB_MOUNT_HEIGHT+ETA;

module main_pcb(cutout=0) {
    xoff=PCB_WIDTH/2-PCB_HOLE_OFFSET;
    yoff=PCB_HEIGHT/2-PCB_HOLE_OFFSET;
    zoff=main_pcb_z_offset();
    color("red") translate([0,0,zoff]) difference() {
        pcb(PCB_WIDTH, PCB_HEIGHT, PCB_THICKNESS);
        // drill holes
        translate([-xoff, -yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=PCB_HOLE_RAD, center=false);
        translate([xoff, -yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=PCB_HOLE_RAD, center=false);
        translate([-xoff, yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=PCB_HOLE_RAD, center=false);
        translate([xoff, yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=PCB_HOLE_RAD, center=false);
    }
    // beeper
    color("gray") translate([PCB_WIDTH/2-12,PCB_HEIGHT/2-10,zoff+PCB_THICKNESS]) cylinder(9.3,r=6,center=false);
    // front knob
    color("gray") translate([PCB_WIDTH/2-12.9,PCB_HEIGHT/2-29.5,zoff+PCB_THICKNESS]) {
        pcb(12,12,4.2);
        translate([0,0,4.2]) cylinder(25,d=6.1+cutout,center=false);
    }
    // reset button
    color("gray") translate([PCB_WIDTH/2-12,PCB_HEIGHT/2-47,zoff+PCB_THICKNESS]) {
        pcb(6,6,4);
        translate([0,0,4]) cylinder(1.5,d=3.5,center=false);
    }
    // sd card holder
    color("gray") translate([-PCB_WIDTH/2 - 10,8.4-PCB_HEIGHT/2,zoff-SD_HOLDER_DEPTH]) {
        cube([SD_HOLDER_WIDTH + 10,SD_HOLDER_HEIGHT,SD_HOLDER_DEPTH], center=false);
    }
	
    // connectors
    cw=20.3+cutout; // connector width
    ch=9+cutout;   // connector height
    cd=9+cutout;    // connector depth
    cx1=46-cutout/2; // connector1 x offset
    cx2=69.3-cutout/2; // connector2 x offset
    cy=22.2-cutout/2; // connector y offset
    translate([-PCB_WIDTH/2+cx1,PCB_HEIGHT/2-ch-cy,zoff-cd]) {
        color("gray") cube([cw,ch,cd], center=false);
    }
    translate([-PCB_WIDTH/2+cx2,PCB_HEIGHT/2-ch-cy,zoff-cd]) {
        color("gray") cube([cw,ch,cd], center=false);
    }
    // rear poti
	color("gray") translate([-PCB_WIDTH/2 + 13.2,PCB_HEIGHT/2-11.5,zoff-8-cutout]) {
        cylinder(8+cutout,d=8.2+cutout,center=false);
    }
}

function lcd_pcb_z_offset() = main_pcb_z_offset() + PCB_THICKNESS + 2.5 + ETA;

module lcd_pcb(cutout) {
    xoff=(LCD_PCB_WIDTH-PCB_WIDTH)/2+LCD_PCB_OFFSET_X;
    yoff=(PCB_HEIGHT-LCD_PCB_HEIGHT)/2-LCD_PCB_OFFSET_Y;
    zoff=lcd_pcb_z_offset();
    hole_xoff=LCD_PCB_WIDTH/2-LCD_PCB_HOLE_OFFSET;
    hole_yoff=LCD_PCB_HEIGHT/2-LCD_PCB_HOLE_OFFSET;

    color("green") translate([xoff,yoff,zoff]) difference() {
        pcb(LCD_PCB_WIDTH, LCD_PCB_HEIGHT, PCB_THICKNESS);
        translate([-hole_xoff, -hole_yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=LCD_PCB_HOLE_RAD, center=false);
        translate([ hole_xoff, -hole_yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=LCD_PCB_HOLE_RAD, center=false);
        translate([-hole_xoff,  hole_yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=LCD_PCB_HOLE_RAD, center=false);
        translate([ hole_xoff,  hole_yoff, -ETA]) cylinder(PCB_THICKNESS+2*ETA, r=LCD_PCB_HOLE_RAD, center=false);
    }

    color("black") translate([-30,21.25,zoff-2.5]) pcb(40.6,2.5,2.5);
}

// the LCD module
function lcd_z_offset() = lcd_pcb_z_offset() + PCB_THICKNESS + ETA;
module lcd(cutout) {
    xoff=(LCD_WIDTH-PCB_WIDTH)/2+LCD_PCB_OFFSET_X+LCD_OFFSET_X;
    yoff=(PCB_HEIGHT-LCD_HEIGHT)/2-LCD_PCB_OFFSET_Y-LCD_OFFSET_Y;
    zoff=lcd_z_offset();
    color("gray") translate([xoff,yoff,zoff]) pcb(LCD_WIDTH+cutout, LCD_HEIGHT+cutout, LCD_THICKNESS);
}

// complete LCD display including PCB
module lcd_display(cutout=0) {
    main_pcb(cutout);
    lcd_pcb(cutout);
    lcd(cutout);
}

// bottom part
module bottom_stl() {
    difference() {
        bottom();
        translate([0,PCB_OFFSET_Y,border_height]) lcd_display(1);
    }
}
if (show_bottom) {
    translate([0,0,-explode*30]) bottom_stl();
}

// top part
module top_stl() {
    difference() {
        top();
        translate([0,PCB_OFFSET_Y,0]) lcd_display(1);
    }
}
if (show_top) {
    translate([0,0,explode*30]) top_stl();
}

// LCD display
if (show_lcd) {
    translate([0,PCB_OFFSET_Y,0]) lcd_display();
}

