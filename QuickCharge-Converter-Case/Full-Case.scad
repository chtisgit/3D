
// Length of PCB
L_PCB = 49.5;

// Width of PCB
B_PCB = 19;

// Height of PCB + Components on the Bottom Side
H_PCB_COMP = 5.5;

// Thickness of shell.
D = 1.6;

// Width of Holes
B_HOLE = 1.2;

// Hole spacing 
B_HOLE_SPACE = 2;

BB = B_HOLE+B_HOLE_SPACE;

// Height of the Top components
H_TOP_COMP = 9;

// Height of the USB-A Port measured from PCB
H_USBA = 6;


translate([0,-B_PCB/2,0]) {
	difference() {
		cube([L_PCB, B_PCB, D]);
		for(i= [0:4]){
			for(j = [0:13]){
				translate([2*D+BB*j, 1.5*D+BB*i, -D])
				cube([B_HOLE,B_HOLE,3*D]);
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
		cube([L_PCB+2*D, D, H_PCB_COMP+D]);


	translate([-D, B_PCB, 0])
		cube([L_PCB+2*D, D, H_PCB_COMP+D]);
}


translate([-D,30-(B_PCB+2*D)/2,0]) {
	
	difference() {
		cube([L_PCB+2*D,B_PCB+2*D,D]);
		
		for(i= [1:5]){
			translate([D*2, D*.5+BB*i, -D])
			cube([L_PCB-2*D,B_HOLE,3*D]);
		}
	}
	
	translate([L_PCB/3-B_HOLE_SPACE/2,0,0])
		cube([B_HOLE_SPACE,B_PCB+2*D,D]);
	translate([L_PCB*2/3-B_HOLE_SPACE/2,0,0])
		cube([B_HOLE_SPACE,B_PCB+2*D,D]);
	
	
	translate([0,D,0])
		cube([D,2,H_TOP_COMP+D]);
	translate([0,B_PCB+D-2,0])
		cube([D,2,H_TOP_COMP+D]);
	cube([D,B_PCB,H_TOP_COMP-H_USBA+D]);
	


	// Sides
	translate([0,-0,0])
		cube([L_PCB+2*D, D, H_TOP_COMP+D]);
	translate([0, B_PCB+D, 0])
		cube([L_PCB+2*D, D, H_TOP_COMP+D]);

}