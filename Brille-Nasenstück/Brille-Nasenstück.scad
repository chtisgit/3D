
R1 = 5 / 2;
R2 = 7 / 2;
H = 2;
L = 14;
CIRCLE_FN = 32;

OFF = 5;


module surf(R1,R2,L,CIRCLE_FN) {
	translate([0,R2,0]){
		M = L-(R1+R2);
		circle(r=R2, $fn=CIRCLE_FN);
		translate([0,L-R2-R1])
			circle(r=R1, $fn=CIRCLE_FN);
		
		translate([-R1,0])
			square([2*R1,M]);
		
		// these are actually not perfect... :(
		polygon([[-R1,0],[-R2,0],[-R1,M]]);
		polygon([[R1,0],[R2,0],[R1,M]]);
	}
}

module base(R1,R2,H,L,CIRCLE_FN) {
	linear_extrude(height=H){
		surf(R1,R2,L,CIRCLE_FN);
	}
}

module rounded_base(R1,R2,H,L,CIRCLE_FN) {
	hull() {
		translate([0,0,H*.1])
			linear_extrude(height=H*.9){
				surf(R1,R2,L,CIRCLE_FN);
			}
		linear_extrude(height=H*.1){
			translate([0,L*.1,0])
			surf(R1*.5,R2*.5,L*.8,CIRCLE_FN);
		}
	}
	
}

rounded_base(R1,R2,H,L,CIRCLE_FN);


translate([-0.5,OFF,2]) {

	difference() {
		union() {
			cube([1,2,2]);
			
			translate([0,1,2])
			rotate([0,90,0])
				cylinder(h=1,r1=1,r2=1,$fn=CIRCLE_FN);
		}
		translate([-1,1,2])
		rotate([0,90,0])
			cylinder(h=3,r1=0.6,r2=0.6,$fn=CIRCLE_FN);
	}
}
