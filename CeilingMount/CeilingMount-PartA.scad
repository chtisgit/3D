include <Parameters.scad>

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
}

difference() {
    
    cylinder(h = TOP_H, r = TOP_R, $fn=fn);

    translate([-KNOB_DIST/2, 0, -TOP_H])
        cylinder(h = TOP_H*3, r = KNOB_R2_HOLE, $fn=fn);
    translate([+KNOB_DIST/2, 0, -TOP_H])
        cylinder(h = TOP_H*3, r = KNOB_R2_HOLE, $fn=fn);

    translate([0,0,-TOP_H])
    linear_extrude(TOP_H*3)
        arc(KNOB_DIST/2 - KNOB_R1_HOLE, [0, TOP_ANGLE], KNOB_R1_HOLE*2, fn);
      
    translate([0,0,-TOP_H])
    linear_extrude(TOP_H*3)
        arc(KNOB_DIST/2 - KNOB_R1_HOLE, [180, 180+TOP_ANGLE], KNOB_R1_HOLE*2, fn);


    translate([0,0,TOP_H-KNOB_H1-1])
    linear_extrude(KNOB_H1+5)
        arc(KNOB_DIST/2 - KNOB_R2_HOLE, [0, TOP_ANGLE], KNOB_R2_HOLE*2, fn);

        
    translate([0,0,TOP_H-KNOB_H1-1])
    linear_extrude(KNOB_H1+5)
        arc(KNOB_DIST/2 - KNOB_R2_HOLE, [180, 180+TOP_ANGLE], KNOB_R2_HOLE*2, fn);
        
    
    rotate([0,0,TOP_ANGLE])
        union() {
            
            translate([-KNOB_DIST/2, 0, TOP_H-KNOB_H1-1-TOP_FINAL_POS_INDENT])
                cylinder(h = TOP_H, r = KNOB_R2_HOLE, $fn=fn);
            translate([+KNOB_DIST/2, 0, TOP_H-KNOB_H1-1-TOP_FINAL_POS_INDENT])
                cylinder(h = TOP_H, r = KNOB_R2_HOLE, $fn=fn);
            
            translate([-KNOB_DIST/2, 0, -TOP_H])
                cylinder(h = TOP_H*3, r = KNOB_R1_HOLE, $fn=fn);
            translate([+KNOB_DIST/2, 0, -TOP_H])
                cylinder(h = TOP_H*3, r = KNOB_R1_HOLE, $fn=fn);

        };
        
    rotate([0, 0, -50])
    translate([TOP_OUTER_SCREW_DIST,0,-1])
    union() {
        translate([0,0,-(TOP_H-1)])
	    cylinder(h = TOP_H*3, r = SCREW_HOLE_R, $fn = fn);
        cylinder(h = 1+TOP_SCREW_INDENT_H, r = SCREW_TOP_R, $fn = fn);

    }
    
    rotate([0, 0, 130])
    translate([TOP_OUTER_SCREW_DIST-ELONGATED_SCREW_HOLE_EXTRA_L/2,0,-1])
    union() {
        translate([0,0,-(TOP_H-1)])
	    cylinder(h = TOP_H*3, r = SCREW_HOLE_R, $fn = fn);
        cylinder(h = 1+TOP_SCREW_INDENT_H, r = SCREW_TOP_R, $fn = fn);

	translate([0,-SCREW_TOP_R,0])
	cube([ELONGATED_SCREW_HOLE_EXTRA_L, SCREW_TOP_R*2, TOP_SCREW_INDENT_H+1]);
	translate([0,-SCREW_HOLE_R,0])
	cube([ELONGATED_SCREW_HOLE_EXTRA_L, SCREW_HOLE_R*2, 100]);


	translate([ELONGATED_SCREW_HOLE_EXTRA_L,0,0])
	union() {	
            translate([0,0,-(TOP_H-1)])
	        cylinder(h = TOP_H*3, r = SCREW_HOLE_R, $fn = fn);
            cylinder(h = 1+TOP_SCREW_INDENT_H, r = SCREW_TOP_R, $fn = fn);
        }

    }

  

}

