DP1 = 11;
DP2 = 36;

DP_WIDTH = 6;
DP_HEIGHT = 18;
DP_KW = 2;
DP_KH = 1;


module DP(w,h,kw,kh) {
	dp_p = [[0,0],[w,0],[w,h],[kw,h],[0,h-kh]];
	dp = [[0,1,2,3,4]];
	polygon(dp_p, dp);
}

module Top() {
	difference() {
		union() {
			translate([2,2])
				square([14,8]);

			square([16,2]);
			square([2,10]);
			
			translate([2,10])
				square([14,2]);
			
			translate([2,10])
				circle(r=2, $fn=12);
			
			translate([16,2]){
				circle(r=2, $fn=12);
				square([2,3]);
			}
			
			translate([16,10])
				circle(r=2, $fn=12);
			
			translate([16,8])
				square([2,2]);

		}

		translate([15,5])
		union() {
			square([3,4]);
			
			translate([0,2])
				circle(d=4, $fn=12);

		}
	}
}

bracket_form_p = [[6,0],[12,0],[14,2],[14,8],[18,12],[18,80],[0,80],[0,12],[4,8],[4,2]];
bracket_form = [[0,1,2,3,4,5,6,7,8,9]];

rotate([0,-90,0])
union() {
	
	difference() {
		linear_extrude(height=1){
			difference() {
				polygon(bracket_form_p, bracket_form);
			
				translate([4,80-DP1-DP_HEIGHT]) DP(DP_WIDTH, DP_HEIGHT, DP_KW, DP_KH);
				translate([4,80-DP2-DP_HEIGHT]) DP(DP_WIDTH, DP_HEIGHT, DP_KW, DP_KH);
			}
			
			translate([6,2])
				circle(r=2, $fn=12);
			
			translate([12,2])
				circle(r=2, $fn=12);
		}
	}

	// Flügel 1
	translate([0,16,-13]){
		cube([1,7,13]);
		translate([0,0,12.2])
			cube([3,7,.8]);
	}

	// Flügel 2
	translate([0,72,-10]){
		cube([1,7,10]);
		translate([0,0,9.2])
			cube([3,7,.8]);
	}

	translate([3,81,0])
	rotate([90,0,0])
	union () {
		translate([0,1,0])
			linear_extrude(height=1){
				Top();
			}
							
		translate([6,12,0])
			cube([2,1,2]);
		
		translate([-3,0,-1])
			cube([18,2,2]);
			
		translate([0,1,-1])
			cube([15,3,2]);
	}
}
