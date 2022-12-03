TOL = 0.5;
B = 12 + TOL;
H = 18 - TOL;
D = 5;
K_D1 = 10;
K_D2 = 7-TOL;
K_L1 = 2;
K_L2 = 2 + TOL;
K_L3 = 2;
fn = 60;

linear_extrude(10) {
	//polygon([[0,0],[B,0],[B,-H],[B+D,-H],[B+D,D],[-D,D],[-D,-H+D],[0,-H+D]]);
	polygon([[0,0],[B,0],[B,-H+1],[B+1,-H],[B+D-1,-H], [B+D,-H+1],[B+D,D-1],[B+D-1,D],,[-D+1,D], [-D,D-1],[-D,-H+D],[0,-H+D]]);

}

translate([-D-K_L1,-H+D,5])
rotate([0,90,0]) {

	cylinder(h=K_L1+D, r=K_D1/2, $fn = fn);

	intersection() {
		
		translate([-K_D2/2,-K_D1/2,-K_L2])
		cube([K_D2,K_D1,K_L2]);
		
		translate([0,0,-100])
		cylinder(h=200, r=K_D1/2, $fn = fn);
	}
	
	translate([0,0,-K_L1-K_L2])
	cylinder(h=K_L3, r = K_D1/2, $fn=fn);
}