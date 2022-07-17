
H = 8;
OUTLINE_W = 4;
hollow = true;

module flat(hollow_support) {
	translate([30,15])
	rotate(30)
		square([20,8]);

	translate([80,15])
	rotate(30)
		square([20,8]);
	
	translate([120,20])
		square([40,8]);

	difference() {
		text("Top 6", font="Chau Philomene One", size=70);
		if (hollow_support) {
			translate([60,-6]) square([3,20]);
			translate([104,-6]) square([3,20]);
			translate([173,-6]) square([3,20]);
		}
	}
}

module top6_hollow(H,OUTLINE_W) {
	linear_extrude(height=H) {
		difference() {
			flat(true);
			offset(delta=-OUTLINE_W) flat(true);
		}
	}
}

module top6(H) {
	linear_extrude(height=H) flat(false);
}

if (hollow)
	top6_hollow(H,OUTLINE_W);
else
	top6(H);