
// Length of PCB
L_PCB = 49.5;

// Width of PCB
B_PCB = 18;

// Height of PCB + Components on the Bottom Side
H_PCB_COMP = 5.5;

// Depth
D = 1.2;

L_BRIDGE = 7;

H_CLIP = H_PCB_COMP+D;
L_CLIP = 2;

translate([0,-B_PCB/2,0]) {	
	cube([L_PCB, B_PCB, D]);
	
	// Front with holes for USB
	translate([-D,0,0])
		cube([D, 4, H_PCB_COMP]);
	translate([-D,-D,H_PCB_COMP])
		cube([D, 2+D, 6]);
	
	translate([-D,B_PCB-4,0])
		cube([D, 4, H_PCB_COMP]);
	translate([-D,B_PCB-2,H_PCB_COMP])
		cube([D, 2+D, 6]);
	
	translate([-D,-D,H_PCB_COMP+6])
		cube([D, B_PCB+2*D, D]);
	
	// Back
	translate([L_PCB,0,0]){
		cube([D, B_PCB, H_PCB_COMP]);
		translate([0, 3, H_PCB_COMP])
			cube([D, B_PCB-6, 4]);
	}
	// Sides
	translate([-D,-D,0])
		difference() {
			cube([L_PCB+2*D, D, H_PCB_COMP]);
			translate([12,-1,-1])
				cube([L_CLIP, 2, 2]);
			translate([12+L_BRIDGE-L_CLIP,-1,-1])
				cube([L_CLIP, 2, 2]);

		}


	translate([-D, B_PCB, 0])
		difference() {
			cube([L_PCB+2*D, D, H_PCB_COMP]);
			translate([12,-1+D,-1])
				cube([L_CLIP, 2, 2]);
			translate([12+L_BRIDGE-L_CLIP,-1+D,-1])
				cube([L_CLIP, 2, 2]);

		}

}

module clip(l,w,d) {
	translate([w,0,0])
	rotate([-90,0,90])
	linear_extrude(height=w)
	polygon([[0,0], [0,-(l-1)], [1,-(l-1)], [0,-l], [-d, -l], [-d,0]]);
}

translate([-B_PCB,-(B_PCB+2*D)/2,0]) {
	
	difference() {
		cube([L_BRIDGE,B_PCB+2*D,D]);
		translate([(L_BRIDGE-1)/2, (B_PCB+2*D)/4, -D])
			cube([1, (B_PCB+2*D)/2, 3*D]);
	}
		
	clip(H_CLIP,2,0.8);
	translate([L_BRIDGE-2,0,0])
		clip(H_CLIP,2,0.8);
	
	translate([L_BRIDGE,B_PCB+2*D,0]){
		rotate([0,0,180]){
			clip(H_CLIP,2,0.8);
			translate([L_BRIDGE-2,0,0])
				clip(H_CLIP,2,0.8);
		}
	}

	
}