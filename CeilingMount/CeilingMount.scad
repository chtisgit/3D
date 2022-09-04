TOP_H = 15; // mm
TOP_R = 75; // mm
TOP_ANGLE = 90; // degrees
TOP_FINAL_POS_INDENT = 3; // mm
TOP_CENTER_SCREW = false; // true/false
TOP_OUTER_SCREWS = 2; // #
TOP_SCREW_INDENT_H = 5; // mm

SCREW_HOLE_D = 6.4; // mm
SCREW_HOLE_R = SCREW_HOLE_D/2;
SCREW_TOP_D = 11; // mm
SCREW_TOP_R = SCREW_TOP_D/2;

TOP_OUTER_SCREW_DIST = TOP_R - 20 - SCREW_HOLE_R;

KNOB_R1 = 10; // mm
KNOB_R2 = 15; // mm
KNOB_DIST = TOP_R;
KNOB_H1 = 4; // mm
KNOB_H2 = TOP_H;
KNOB_SCREW_INDENT_H = 3; // mm
KNOB_CONNECTOR_H = 2; // mm

KNOB_R1_HOLE = KNOB_R1+1;
KNOB_R2_HOLE = KNOB_R2+1;

fn = 90;

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
        arc(KNOB_DIST/2 - KNOB_R1_HOLE, [0, TOP_ANGLE], KNOB_R1_HOLE*2);
      
    translate([0,0,-TOP_H])
    linear_extrude(TOP_H*3)
        arc(KNOB_DIST/2 - KNOB_R1_HOLE, [180, 180+TOP_ANGLE], KNOB_R1_HOLE*2);


    translate([0,0,TOP_H-KNOB_H1-1])
    linear_extrude(KNOB_H1+5)
        arc(KNOB_DIST/2 - KNOB_R2_HOLE, [0, TOP_ANGLE], KNOB_R2_HOLE*2);

        
    translate([0,0,TOP_H-KNOB_H1-1])
    linear_extrude(KNOB_H1+5)
        arc(KNOB_DIST/2 - KNOB_R2_HOLE, [180, 180+TOP_ANGLE], KNOB_R2_HOLE*2);
        
    
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
        
    if (TOP_CENTER_SCREW) {
        translate([0,0,-TOP_H])
            cylinder(h = TOP_H*3, r = SCREW_HOLE_R, $fn = fn);
        translate([0,0,TOP_H - TOP_SCREW_INDENT_H])
            cylinder(h = TOP_H, r = SCREW_TOP_R , $fn = fn);
    }
    
    if (TOP_OUTER_SCREWS > 0)
        for ( i = [0 : 360 / TOP_OUTER_SCREWS : 360] ) {
            rotate([0, 0, i-45])
            translate([TOP_OUTER_SCREW_DIST,0,-TOP_H])
            cylinder(h = TOP_H*3, r = SCREW_HOLE_R, $fn = fn);
            
            rotate([0, 0, i-45])
            translate([TOP_OUTER_SCREW_DIST,0,TOP_H - TOP_SCREW_INDENT_H])
            cylinder(h = TOP_H, r = SCREW_TOP_R, $fn = fn);
        }
}

module knob(h1, h2, r1, r2, fn = 24) {
    cylinder(h=h2, r = r1, $fn = fn);
    translate([0,0,h2])
    cylinder(h=h1, r = r2, $fn = fn);

}


translate([0,TOP_R+KNOB_R2+20 ,0])
difference() {

    union() {
        translate([-KNOB_DIST/2, 0, KNOB_CONNECTOR_H])
            knob(KNOB_H1, KNOB_H2, KNOB_R1, KNOB_R2, fn);
        translate([KNOB_DIST/2, 0, KNOB_CONNECTOR_H])
            knob(KNOB_H1, KNOB_H2, KNOB_R1, KNOB_R2, fn);
        
        translate([-KNOB_DIST/2,0,0])
            union() {
                translate([0,-KNOB_R1,0])
                    cube([KNOB_DIST,KNOB_R1*2, KNOB_CONNECTOR_H]);
                translate([0, 0, 0])
                    cylinder(h=KNOB_CONNECTOR_H, r=KNOB_R1, $fn=fn);
                translate([KNOB_DIST, 0, 0])
                    cylinder(h=KNOB_CONNECTOR_H, r=KNOB_R1, $fn=fn);
            }
    }
    
    translate([-KNOB_DIST/2, 0, -50])
        cylinder(h = 100, r = SCREW_HOLE_R, $fn = fn);
    translate([KNOB_DIST/2, 0, -50])
        cylinder(h = 100, r = SCREW_HOLE_R, $fn = fn);


    translate([-KNOB_DIST/2, 0, KNOB_H2+KNOB_H1 - KNOB_SCREW_INDENT_H])
        cylinder(h = 100, r = SCREW_TOP_R, $fn = fn);
    translate([KNOB_DIST/2, 0, KNOB_H2+KNOB_H1 - KNOB_SCREW_INDENT_H])
        cylinder(h = 100, r = SCREW_TOP_R, $fn = fn);
}

