/*
	Konfiguracni soubor 3D tiskarny RebeliX BoX
	
	Sledujte nas na:		  
			www.RebeliX.cz
			www.facebook.com/RebeliX.cz
			https://twitter.com/reprap4u
			https://plus.google.com/+Reprap4uCz-3Dtiskarna-RebeliX
			
	License: GNU GPL v3
*/


/* ========================== Z probe ======================= */

// Prumer Z probe
Z_probe_D = 12.2;
// Delka Z probe
Z_probe_H = 62;
// Delka zavitu
Z_probe_screw_H = 42;
// Prumer matky k sonde
Z_probe_nut_D = 19;
// Vyska matky
Z_probe_nut_H = 3.8;
// Prumer podlozky k sonde
Z_probe_washer_D = 22;


/* ================ Parametry energo retezu ================= */

// Sirka zarazek retezu
mantinel_W = 1.4; 

// Sirka prichytu retezu (v miste, kde jsou otvory na pridelani)
chain_mount_W = 18;

// Vyska retezu 
chain_H = 15.4;
//chain_H = 14.8;

// Sirka retezu
chain_W = chain_mount_W + 0.9;

//Vzdalenost od profilu
chain_x_offset = 1.5;


/* =================== Nastaveni pro osu Z ================== */

// Prumer hlazene tyce
//rod_D = 8.1; // 8 mm
rod_D = 10.1; // 10 mm
//rod_D = 12.2; // 12 mm

// Vzdalenost stredu hlazene tyce od hrany profilu
rod_offset = 20;

// Prostor kolem maticky pro pridelani heatbed
mount_dia = 20;


/* ============== Parametry kolejnice a voziku ============== */

// Sirka kolejnice
rail_W = 12;

// Tloustka kolejnice
rail_H = 8;

// Jak daleko od rezu je prvni otvor v kolejnici
rail_first_hole = 11;

// Vzdalenost otvoru v kolejnici
rail_hole_distance = 25;

// Otvory pro pridelani na voziku MGN12
MGN12_holes = [
  [10, 10, 0],
  [10, -10, 0],
  [-10, -10, 0],
  [-10, 10, 0]
];

// Vyska pojezdu MGN12_H i s kolejnici
MGN12_H = 13;

// Sirka voziku MGN12
MGN12_W = 27;


/* ======================= Obecne =========================== */

// Sirka hlinikoveho profilu
profile_width = 30;

// Radius zakulacenych rohu
corner_rad = 6; 


/* ================== Spojovaci material ==================== */

// --------------- M3 ----------------
// Prumer hlavy M3 sroubu
M3_head_D = 6.5;

// Prumer M3 sroubu
M3_screw_D = 3.3;

// Vyska hlavy M3 sroubu
M3_head_H = 2;

// Prumer M3 podlozek
M3_washer_D = 6.8;

// Tloustka M3 podlozky
M3_washer_H = 0.5;

// Prumer M3 matky
M3_nut_D=6.6;

// Vyska M3 matky
M3_nut_H = 3;

M3x10_offset = 6; // Sroub M3x10;

// --------------- M4 ----------------

// Prumer hlavy M4 sroubu
M4_head_D = 7.6;

// Prumer M4 sroubu
M4_screw_D = 4.3;

// Vyska hlavy M4 sroubu
M4_head_H = 4;

// Tloustka M4 podlozky
M4_washer_H = 0.8;

// Prumer M4 matky
M4_nut_D=8.4;

// Vyska M4 matky
M4_nut_H=3.5;

// --------------- M6 ----------------

// Prumer hlavy M6 sroubu
M6_head_D = 11.6;

// Prumer M6 sroubu
M6_screw_D = 6.3;

// Vyska hlavy M6 sroubu
M6_head_H = 3.6;
//M6_head_H = 4.5;

// Prumer M6 podlozek
M6_washer_D = 18;

// Tloustka M6 podlozky
M6_washer_H = 2;

M6x14_offset = 7; // Sroub M6x14;

// Sirka matky do profilu (pokud neni pouzita, tak 0)
//profile_nut_W = 12.1;
profile_nut_W = 9.5;
//profile_nut_W = 0;

/* ======================== Remenice ======================== */

// ------------- GT2/20 --------------

// Vyska ozubeneho kolecka
GT2_pulley_H = 16;
// Prumer v miste zubu na ozubenem kolecku
GT2_pulley_gear_D = 12.2;
// Vydalenost zubu na ozubenem kole od hrany s cervikem
GT2_pulley_teeth_offset = 7;

// Vyska ozubeneho kolecka 
pulley_H = GT2_pulley_H;
// Prumer v miste zubu na ozubenem kolecku
pulley_gear_D = GT2_pulley_gear_D;
// Vydalenost zubu na ozubenem kole od hrany s cervikem
pulley_teeth_offset = GT2_pulley_teeth_offset;


/* ========================== Remen ========================= */

// -------------- GT2 ----------------
 
belt_tooth_distance = 2;
belt_tooth_ratio = 0.5;

// Tloustka remenu
//belt_thick = 2.5;
belt_thick = 1.6; //1.4

// Sirka remenu
belt_width = 6;

// Tloustka dvou remenu "zakousnutych" do sebe
belt_lock_thickness = 2*belt_thick;

belt_core_thickness = 0.75;
belt_tooth_height = 1.7;

// Vyska zubu na remenu
//belt_tooth_height = 0.8;

//belt_core_thickness = 0.75;
//belt_tooth_height = 1.7;

// -------------- T2.5 ----------------

//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.68;


/* ======================= Loziska ========================== */

// ----------- Lozisko 608 ----------- 

// Vnejsi prumer loziska
bearing_608_OUT_D = 22.1;
// Vnitrni prumer loziska
bearing_608_IN_D = 8;
// Vnejsi prumer otocneho stredu loziska
bearing_608_CENTER_D = 13;
// Vyska loziska
bearing_608_H = 7;

// ----------- Lozisko F624 ----------

// Vnejsi prumer loziska
bearing_F624_OUT_D1 = 16;
// Vnejsi prumer zuzene casti loziska
bearing_F624_OUT_D2 = 13;
// Vnitrni prumer loziska
bearing_F624_IN_D = 4;
// Vnejsi prumer otocneho stredu loziska
bearing_F624_CENTER_D = 0;
// Vyska loziska
bearing_F624_H = 5;
// Vyska okraje na lozisku
bearing_F624_Flange_H = 1;

// ----------- Lozisko F623 ----------

// Vnejsi prumer loziska
bearing_F623_OUT_D = 10;
// Vnitrni prumer loziska
bearing_F623_IN_D = 3;
// Vyska loziska
bearing_F623_H = 4;

// --------- Axialni lozisko ---------

// Prumer loziska
axial_bearing_D = 16 + 0.8;
// Vyska spodni casti
axial_bearing_H1 = 1;
// Vyska casti s kulickami
axial_bearing_H2 = 4;


/* ==================== Idler X,Y,Z ========================= */

// ---------- Idler 2x F624 ----------
///*
idler_OUT_D1 = bearing_F624_OUT_D1;
idler_OUT_D2 = bearing_F624_OUT_D2;
idler_IN_D = bearing_F624_IN_D;
idler_CENTER_D = bearing_F624_CENTER_D;
idler_H = 2*bearing_F624_H;
idler_Flange_H = bearing_F624_Flange_H;
idler_Flange_Deep = 0; 

// -------- Idler M4 - sroub ---------
// Prumer sroubu
idler_screw_D = M4_screw_D;
// Prumer hlavy sroubu
idler_screw_head_D = M4_head_D;
// Vyska hlavy sroubu
idler_screw_head_H = M4_head_H;
// Prumer matky
idler_nut_D = M4_nut_D;
// Vyska matky
idler_nut_H = M4_nut_H;
// Tloustka podlozky
idler_washer_H = M4_washer_H;
//*/


// ---------- Idler pulley (20T W6 Bore 3mm without T) ----------
/*
idler_OUT_D1 = 18;
idler_OUT_D2 = GT2_pulley_gear_D;
idler_IN_D = 3;
idler_CENTER_D = 4;
idler_H = 8.5;
idler_Flange_H = (idler_H - 6.5)/2;
idler_Flange_Deep = 0; 

// ---===== M3 - sroub =====--- 
// Prumer sroubu
idler_screw_D = M3_screw_D;
// Prumer hlavy sroubu
idler_screw_head_D = M3_head_D;
// Vyska hlavy sroubu
idler_screw_head_H = M3_head_H;
// Prumer matky
idler_nut_D = M3_nut_D;
// Vyska matky
idler_nut_H = M3_nut_H;
// Tloustka podlozky
idler_washer_H = M3_washer_H;
*/


/* ===================== Lozisko osa Z ========================= */

big_bearing_OUT_D = bearing_608_OUT_D;
big_bearing_IN_D = bearing_608_IN_D;
big_bearing_CENTER_D = bearing_608_CENTER_D;
big_bearing_H = bearing_608_H;


/* ==================== Idler extruder ========================= */

// ---------- Idler 1x 623 ----------

ext_idler_OUT_D = bearing_F623_OUT_D;
ext_idler_IN_D = bearing_F623_IN_D;
ext_idler_H = bearing_F623_H + 4*M3_washer_H;

ext_idler_screw_D = M3_screw_D;
ext_idler_nut_D = M3_nut_D;
ext_idler_nut_H = M3_nut_H;
ext_idler_washer_H = M3_washer_H;


/* ================ Slic3r nastaveni ======================== */

// Vyska vrstvy pro tisknuti dilu [mm]
layer_height = 0.3;

// Sirka vytlacovaneho materialu [mm]
extrusion_width = 0.66; //Slic3r->Print Settings->Advanced->Default extrusion width


/*=================== Nastaveni dilu =========================*/

// Tloustka rohovych spojek
// 5 mm => sroub M6x14 s podlozkou
// 3 mm => sroub M6x12 s podlozkou
coupler_thickness = 5;


/* ======================= Motory =========================== */

// Montazni otvory motoru
motor_mount_holes = [
  [-31/2,-31/2,0],
  [31/2,-31/2,0],
  [31/2,31/2,0],
  [-31/2,31/2,0]
];

// Sirka motoru NEMA17
motor_width = 42.3;

// Delka motoru
//SX17-1003LQFE
motor_length = 29.5;
//SX17-1003, SX17-0503LQEF
//motor_length = 34;
//SX17-1005
//motor_length = 40;
//SX17-0905
//motor_length = 48;