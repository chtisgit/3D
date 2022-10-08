
fn = 80;
R = 25.5 / 2;
L = 90;

SCREW_HOLE_R = 4.4/2;

difference() {
	linear_extrude(L) {
		polygon([
			[0,0], [0,2*(3+R)], [9,2*(R+3)-3],
			[14,2*R-2], [16,3+R], [17,8], [19,6], [26,5],
			[30, 0]
		]);
	}

	translate([0,3+R,-5])
	cylinder(h=L+10, r=R, $fn=fn);


	translate([23,-10,15])
	rotate([-90,0,0])
	cylinder(h=20, r=SCREW_HOLE_R, $fn=fn);

	translate([23,-10,L-15])
	rotate([-90,0,0])
	cylinder(h=20, r=SCREW_HOLE_R, $fn=fn);

	translate([18,3,3])
	cube([30, 10, L-6]);	
}
