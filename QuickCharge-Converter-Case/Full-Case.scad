
// Length of PCB
L_PCB = 49.5;

// Width of PCB
B_PCB = 18;

// Height of PCB + Components on the Bottom Side
H_PCB_COMP = 5.5;

// Depth
D = 1.2;

// Height of the Top components
H_TOP_COMP = 9;

// Height of the USB-A Port measured from PCB
H_USBA = 6;

H_CLIP = H_PCB_COMP+2*D+H_TOP_COMP;
L_CLIP = 2;

translate([0,-B_PCB/2,0]) {
	difference() {
		cube([L_PCB, B_PCB, D]);
		for(i= [0:7]){
			for(j = [1:18]){
				translate([D+2*D*j, D+2*D*i, -D])
				cube([D,D,3*D]);
			}
		}

	}
		
	// Front with holes for USB
	translate([-D,0,0])
		cube([D, 4, H_PCB_COMP+D]);
	
	translate([-D,B_PCB-4,0])
		cube([D, 4, H_PCB_COMP+D]);

	
	// Back
	translate([L_PCB,0,0]){
		cube([D, B_PCB, H_PCB_COMP+D]);
		translate([0, 3, H_PCB_COMP+D])
			cube([D, B_PCB-6, 4]);
	}
	// Sides
	translate([-D,-D,0])
		difference() {
			cube([L_PCB+2*D, D, H_PCB_COMP+D]);
			translate([2,0,0])
				cube([L_CLIP,1,1]);
			translate([L_PCB-L_CLIP+0.4,0,0])
				cube([L_CLIP,1,1]);
		}


	translate([-D, B_PCB, 0])
		difference() {
			cube([L_PCB+2*D, D, H_PCB_COMP+D]);
			translate([2,0.2,0])
				cube([L_CLIP,1,1]);
			translate([L_PCB-L_CLIP+0.4,0.2,0])
				cube([L_CLIP,1,1]);

		}
}

module clip(l,w,d) {
	translate([w,0,0])
	rotate([-90,0,90])
	linear_extrude(height=w)
	polygon([[0,0], [0,-(l-1)], [1,-(l-1)], [0,-l], [-d, -l], [-d,0]]);
}

translate([-D,30-(B_PCB+2*D)/2,0]) {
	
	difference() {
		cube([L_PCB+2*D,B_PCB+2*D,D]);
		
		for(i= [1:6]){
			translate([D*2, D+2*D*i, -D])
			cube([L_PCB-2*D,D,3*D]);
		}
	}
	
	
	translate([0,D,0])
		cube([D,2,H_TOP_COMP+D]);
	translate([0,B_PCB+D-2,0])
		cube([D,2,H_TOP_COMP+D]);
	cube([D,B_PCB,H_TOP_COMP-H_USBA+D]);
	
	clip_start_z = H_TOP_COMP+D-4;
	//clip_start_z=0;
	
	translate([2,0,clip_start_z])
		clip(H_CLIP-clip_start_z,L_CLIP,0.8);
	translate([L_PCB+2*D-L_CLIP-2,0,clip_start_z])
		clip(H_CLIP-clip_start_z,L_CLIP,0.8);
	

	translate([2+L_CLIP,B_PCB+2*D,clip_start_z])
	rotate([0,0,180])
		clip(H_CLIP-clip_start_z,L_CLIP,0.8);
	translate([L_PCB+2*D-2,B_PCB+2*D,clip_start_z])
	rotate([0,0,180])
		clip(H_CLIP-clip_start_z,L_CLIP,0.8);


	// Sides
	translate([0,-0,0])
		cube([L_PCB+2*D, D, H_TOP_COMP+D]);
	translate([0, B_PCB+D, 0])
		cube([L_PCB+2*D, D, H_TOP_COMP+D]);

}