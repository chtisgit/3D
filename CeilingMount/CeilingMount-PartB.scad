include <Parameters.scad>

module knob(h1, h2, r1, r2, fn = 24) {
    cylinder(h=h2, r = r1, $fn = fn);
    translate([0,0,h2])
    cylinder(h=h1, r = r2, $fn = fn);

}

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

