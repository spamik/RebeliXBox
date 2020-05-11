sensor_pcb_w = 27;
sensor_pcb_h = 23;
sensor_pcb_connector_h = 8;
sensor_pcb_connector_d = 3;
sensor_pcb_connector_offset = 4;

sensor_w = sensor_pcb_w +8;
sensor_h = sensor_pcb_h + 50;
sensor_d = 28;

wall_thickness = 2.5;
wall_tolerance = 0.4;

sensor_cover_d = wall_thickness+3.2;

module insert_nut_cover() {
	inner_d = 4.5;
	outer_d = 7.7;
	cover_h = 3;
	difference() {
		cylinder(d=outer_d, h=cover_h+wall_thickness, $fn=100);
		translate([0, 0, -1]) cylinder(d=inner_d, h=cover_h*2+wall_thickness, $fn=100);
	}
}
module magnet_holder(h, hfill, outdsize=4) {
	inner_d = 5.5;
	outer_d = inner_d+outdsize;
	difference() {
		cylinder(d=outer_d, h=h, $fn=100);
		translate([0, 0, hfill]) cylinder(d=inner_d, h=h, $fn=100);
	}
}

module filament_cleaner_side() {
    wall_t = 2;
    filament_d = 2.5;
    difference() {
        cube(size=[sensor_w+2*wall_thickness, wall_t, sensor_d-wall_thickness], center=true);
        translate([sensor_w/-2+7, 0, wall_thickness]) cube(size=[filament_d, wall_t*3, sensor_d-wall_thickness], center=true);
        translate([sensor_w/-2+7+15, 0, wall_thickness]) cube(size=[filament_d, wall_t*3, sensor_d-wall_thickness], center=true);
    }
}

base_w = sensor_w+2*wall_thickness;
base_h = sensor_h+2*wall_thickness;

pcb_y_offset = 7;

module sensor_base() {
	

	difference() {
		cube(size=[base_w, base_h, sensor_d], center=true);
		translate([0, 0, wall_thickness]) cube(size=[sensor_w, sensor_h-4*wall_thickness-2*wall_tolerance, sensor_d], center=true);
        // top/bottom sides
        translate([0, 0, wall_thickness]) cube(size=[sensor_w-2*wall_thickness, sensor_h*2, sensor_d], center=true);
        tray_h = wall_thickness+wall_tolerance;
        translate([0, base_h/-2+tray_h/2+wall_thickness, wall_thickness-0.5]) cube(size=[sensor_w, tray_h, sensor_d], center=true);
        translate([0, base_h/2-tray_h/2-wall_thickness, wall_thickness-0.5]) cube(size=[sensor_w, tray_h, sensor_d], center=true);
		// connector cutout
        translate([sensor_w/-2-1, sensor_h/-2+pcb_y_offset+sensor_pcb_h/2, sensor_d/-2+wall_thickness+3+sensor_pcb_connector_offset]) cube(size=[wall_thickness*3, sensor_pcb_connector_h, sensor_pcb_connector_d], center=true);
        // mount holes
        translate([sensor_w/-2+3.2, 3.8, sensor_d/-2-1]) cylinder(d=3.6, h=sensor_d, $fn=100);
        translate([sensor_w/2-3.2, 3.8, sensor_d/-2-1]) cylinder(d=3.6, h=sensor_d, $fn=100);
        // larger nuts
        translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3, sensor_d/-2+1]) cylinder(d=4.5, h=sensor_d, $fn=100);
        translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3+16.5, sensor_d/-2+1]) cylinder(d=4.5, h=sensor_d, $fn=100);
        translate([sensor_w/-2+7, sensor_h/-2+pcb_y_offset+sensor_pcb_h+4, sensor_d/-2+1]) cylinder(d=4.5, h=sensor_d, $fn=100);
        translate([sensor_w/-2+7+15, sensor_h/-2+pcb_y_offset+sensor_pcb_h+4, sensor_d/-2+1]) cylinder(d=4.5, h=sensor_d, $fn=100);
	}
	// pcb holders
	translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3, sensor_d/-2]) insert_nut_cover();
	translate([sensor_w/-2+15, sensor_h/-2+pcb_y_offset+3+16.5, sensor_d/-2]) insert_nut_cover();
    // filament pressure holders
    translate([sensor_w/-2+7, sensor_h/-2+pcb_y_offset+sensor_pcb_h+4, sensor_d/-2]) insert_nut_cover();
    translate([sensor_w/-2+7+15, sensor_h/-2+pcb_y_offset+sensor_pcb_h+4, sensor_d/-2]) insert_nut_cover();
    // magnet holder
    translate([sensor_w/-2-wall_thickness-5.5/2, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_d/-2]) magnet_holder(h=sensor_d, hfill=sensor_d-3.2);
    translate([sensor_w/2+wall_thickness+5.5/2, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_d/-2]) magnet_holder(h=sensor_d, hfill=sensor_d-3.2);
    translate([sensor_w/-2-wall_thickness-5.5/2, sensor_h/-2+pcb_y_offset, sensor_d/-2]) magnet_holder(h=sensor_d, hfill=sensor_d-3.2);
    translate([sensor_w/2+wall_thickness+5.5/2, sensor_h/-2+pcb_y_offset, sensor_d/-2]) magnet_holder(h=sensor_d, hfill=sensor_d-3.2);
    // inside filter
    translate([-1.3, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_d/-2]) magnet_holder(h=sensor_d-3, hfill=sensor_d-3-3.2);
    // filament cleaner part
    translate([0, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14, 0]) filament_cleaner_side();
    translate([0, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+20, 0]) filament_cleaner_side();
    // infill for filter
    infill_h = 12;
    translate([0, sensor_h/-2+pcb_y_offset+sensor_pcb_h+12+12, sensor_d/-2+infill_h/2]) cube(size=[base_w, 22, infill_h], center=true);
	// tmp pcb
	//translate([sensor_w/-2, sensor_h/-2+pcb_y_offset, sensor_d/-2+wall_thickness+3]) cube(size=[sensor_pcb_w, sensor_pcb_h, 1.6]);
    

}

module sensor_cover() {
    difference() {
        union() {
            cube(size=[base_w, base_h, sensor_cover_d], center=true);
            // magnet holders
            translate([sensor_w/-2-wall_thickness-5.5/2, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_cover_d/-2]) magnet_holder(h=sensor_cover_d, hfill=sensor_cover_d-3.2, outdsize=6);
            translate([sensor_w/2+wall_thickness+5.5/2, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_cover_d/-2]) magnet_holder(h=sensor_cover_d, hfill=sensor_cover_d-3.2, , outdsize=6);
            translate([sensor_w/-2-wall_thickness-5.5/2, sensor_h/-2+pcb_y_offset, sensor_cover_d/-2]) magnet_holder(h=sensor_cover_d, hfill=sensor_cover_d-3.2, , outdsize=6);
            translate([sensor_w/2+wall_thickness+5.5/2, sensor_h/-2+pcb_y_offset, sensor_cover_d/-2]) magnet_holder(h=sensor_cover_d, hfill=sensor_cover_d-3.2, outdsize=6);
            // filter press
            infill_h = 3+sensor_cover_d;
            translate([0, sensor_h/-2+pcb_y_offset+sensor_pcb_h+12+12, sensor_cover_d/-2+infill_h/2]) cube(size=[sensor_w-2, 17, infill_h], center=true);
        }
        
        translate([1.3, sensor_h/-2+pcb_y_offset+sensor_pcb_h+14+10, sensor_cover_d/2+3-3.2]) cylinder(d=5.5, h=2*sensor_cover_d, $fn=100);
        
        // gates
        tray_h = wall_thickness+wall_tolerance;
        translate([0, base_h/2-tray_h/2-wall_thickness, wall_thickness-0.5]) cube(size=[sensor_w, tray_h, sensor_cover_d], center=true);
        translate([0, base_h/-2+tray_h/2+wall_thickness, wall_thickness-0.5]) cube(size=[sensor_w, tray_h, sensor_cover_d], center=true);
        // inner space
        translate([0, base_h/-2+(sensor_pcb_h+16)/2+3*wall_thickness, wall_thickness]) cube(size=[sensor_w, sensor_pcb_h+16, sensor_cover_d], center=true);
        translate([0, base_h/2-(5)/2-3*wall_thickness, wall_thickness]) cube(size=[sensor_w, 5, sensor_cover_d], center=true);
    }
    
    
    
}

module side_plate() {
    plate_h = sensor_d+sensor_cover_d-2*wall_thickness;
    difference() {
        cube(size=[sensor_w-2*wall_tolerance, wall_thickness, plate_h], center=true);
        hose_d = 5;
        translate([sensor_w/-2+7, wall_thickness, plate_h/-2+12]) rotate(a=[90, 0, 0]) cylinder(d=hose_d, h=wall_thickness*3, $fn=100);
        translate([sensor_w/-2+7+15, wall_thickness, plate_h/-2+12]) rotate(a=[90, 0, 0]) cylinder(d=hose_d, h=wall_thickness*3, $fn=100);
    }
}

module filament_pressure() {
    wide = 8;
    length = 11;
    length2 = 5;
    height1 = 4;
    height2 = 15;
    
    difference() {
        union() {
            cube(size=[wide, length, height1]);
            translate([0, length-length2, 0]) cube(size=[wide, length2, height2]);            
        }
        translate([wide/2, (length-length2)/2-0.5, -1]) cylinder(d=3.7, h=height1*2, $fn=100);
        translate([wide/2, 1, height2-3.5]) rotate(a=[-90, 0, 0]) cylinder(d=4.8, h=length, $fn=100);
    }
}

translate([30, 0, 0]) filament_pressure();
//sensor_base();
//translate([60, 0, 0]) sensor_cover();
//translate([0, -45, 3]) side_plate();
//translate([40, -45, 3]) mirror([1, 0, 0]) side_plate();