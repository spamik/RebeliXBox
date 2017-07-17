
// Module names are of the form poly_<inkscape-path-id>().
// As a result you can associate a polygon in this OpenSCAD program with the
//  corresponding SVG element in the Inkscape document by looking for 
//  the XML element with the attribute id="inkscape-path-id".

// Paths have their own variables so they can be imported and used 
//  in polygon(points) structures in other programs.
// The NN_points is the list of all polygon XY vertices. 
// There may be an NN_paths variable as well. If it exists then it 
//  defines the nested paths. Both must be used in the 
//  polygon(points, paths) variant of the command.

profile_scale = 25.4/90; //made in inkscape in mm

// helper functions to determine the X,Y dimensions of the profiles
function min_x(shape_points) = min([ for (x = shape_points) min(x[0])]);
function max_x(shape_points) = max([ for (x = shape_points) max(x[0])]);
function min_y(shape_points) = min([ for (x = shape_points) min(x[1])]);
function max_y(shape_points) = max([ for (x = shape_points) max(x[1])]);

height = 1;
width = 1.0;


E_pisemno_points = [[-59.873045,14.375000],[-59.873045,-14.257820],[-38.642575,-14.257820],[-38.642575,-9.414070],[-54.091795,-9.414070],[-54.091795,-3.066410],[-39.716795,-3.066410],[-39.716795,1.757810],[-54.091795,1.757810],[-54.091795,9.550780],[-38.095705,9.550780],[-38.095705,14.375000],[-59.873045,14.375000],[-59.873045,14.375000]];

module E_pisemno(h, w, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    linear_extrude(height=h)
      polygon(E_pisemno_points);
  }
}

X_pisemno_points = [[-36.064455,14.375000],[-26.279295,-0.566410],[-35.146485,-14.257820],[-28.388675,-14.257820],[-22.646485,-5.058600],[-17.021485,-14.257820],[-10.322265,-14.257820],[-19.228515,-0.351570],[-9.443355,14.375000],[-16.416015,14.375000],[-22.763675,4.472650],[-29.130855,14.375000],[-36.064455,14.375000],[-36.064455,14.375000]];

module X_pisemno(h, w, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    linear_extrude(height=h)
      polygon(X_pisemno_points);
  }
}

P_pisemno_points = [[-6.435545,14.375000],[-6.435545,-14.257820],[2.841795,-14.257820],[7.197265,-14.150398],[9.716795,-13.828130],[11.977540,-12.802740],[13.837895,-11.015630],[15.083007,-8.549808],[15.498045,-5.449220],[15.258787,-3.022463],[14.541015,-1.015630],[13.452147,0.590817],[12.099605,1.816400],[10.620115,2.661130],[9.111325,3.164060],[3.115235,3.574220],[-0.654295,3.574220],[-0.654295,14.375000],[-6.435545,14.375000],[-6.435545,14.375000],[-0.654295,-9.414070],[-0.654295,-1.289070],[2.509765,-1.289070],[5.361327,-1.401373],[7.080075,-1.738280],[8.105470,-2.314453],[8.876955,-3.144530],[9.375000,-4.179693],[9.541015,-5.371100],[9.311522,-6.796880],[8.623045,-7.949220],[7.583005,-8.774418],[6.298825,-9.218750],[2.138675,-9.414070],[-0.654295,-9.414070],[-0.654295,-9.414070]];
P_pisemno_paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19],
				[20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35]];

module P_pisemno(h, w, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    linear_extrude(height=h)
      polygon(P_pisemno_points, P_pisemno_paths);
  }
}

cislo_1_points = [[33.115235,14.375000],[27.626955,14.375000],[27.626955,-6.308600],[24.350587,-3.862310],[20.537105,-2.148440],[20.537105,-7.128910],[22.778317,-8.144533],[25.205075,-9.785160],[27.329098,-11.918950],[28.662105,-14.375000],[33.115235,-14.375000],[33.115235,14.375000],[33.115235,14.375000]];

module cislo_1(h, w, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    linear_extrude(height=h)
      polygon(cislo_1_points);
  }
}

cislo_2_points = [[59.873045,9.277340],[59.873045,14.375000],[40.634765,14.375000],[41.259765,11.562497],[42.509765,8.906250],[44.833985,5.888670],[48.681645,2.031250],[53.232425,-2.656250],[54.082032,-4.345705],[54.365235,-6.015630],[54.116212,-7.636725],[53.369145,-8.828130],[52.202147,-9.575198],[50.654295,-9.824220],[49.111327,-9.565433],[47.919925,-8.789070],[47.119140,-7.412115],[46.748045,-5.351570],[41.279295,-5.898440],[41.654051,-8.004153],[42.290037,-9.790043],[43.187256,-11.256108],[44.345705,-12.402350],[47.246093,-13.881838],[50.791015,-14.375000],[52.796630,-14.232178],[54.575195,-13.803713],[56.126710,-13.089603],[57.451175,-12.089850],[58.510743,-10.877690],[59.267577,-9.526370],[59.721678,-8.035890],[59.873045,-6.406250],[59.697265,-4.516605],[59.169925,-2.714850],[58.281250,-0.932623],[56.982425,0.937500],[53.388675,4.589840],[50.087895,7.753900],[48.974605,9.277340],[59.873045,9.277340],[59.873045,9.277340]];

module cislo_2(h, w, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    linear_extrude(height=h)
      polygon(cislo_2_points);
  }
}

// The shapes
E_pisemno(height, width);
X_pisemno(height, width);
P_pisemno(height, width);
cislo_1(height, width);
cislo_2(height, width);
