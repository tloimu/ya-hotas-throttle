// Throttle case

include <throttle-base.scad>;

// Case parameters

case_bottom = 9.5;
case_thickness = 3;
case_depth = 24; // outer measurement
case_outside = 175.5;
case_inside = case_outside - 2 * case_thickness;

case_cover_support_offset = [(case_outside/2 - 10.7 + 3),(case_outside/2 - 13.2 + 3)];
case_cover_supports = [
    [-case_cover_support_offset.x, -case_cover_support_offset.y],
    [-case_cover_support_offset.x, case_cover_support_offset.y],
    [case_cover_support_offset.x, -case_cover_support_offset.y],
    [case_cover_support_offset.x, case_cover_support_offset.y]
    ];
case_cover_support_height = 31.5;

// Case cover parameters

case_cover_height = 23;
grooveClearance = 2;
grooveDiameter = 20 + grooveClearance;
grooveLength = 100 + grooveClearance;
grooveOffset = -(36-14)/2;


module CaseBottom()
{
    module CaseNut()
    {
        difference ()
        {
            cylinder (r1=2.5, r2=2.5, h=6);
            cylinder (r1=1.5, r2=1.5, h=7);
        }
    }
    
    translate ([-case_outside/2,-case_outside/2,0]) difference ()
    {
        cube ([case_outside, case_outside, case_depth]);
        translate ([case_thickness, case_thickness, case_thickness]) cube ([case_outside-2*case_thickness, case_outside-2*case_thickness, case_depth]);
    }

    // Main slider nuts
    translate ([65.5/2,case_inside/2 - 15,case_thickness]) CaseNut();
    translate ([-65.5/2,case_inside/2 - 15,case_thickness]) CaseNut();

    // Backstop nuts
    translate ([case_inside/2 - 15,32,case_thickness]) CaseNut();
    translate ([case_inside/2 - 15,-32,case_thickness]) CaseNut();
    
    // Legs
    translate ([case_inside/2 - 30 + 11.5,case_inside/2-44+11.5,case_thickness]) cylinder (r1=11.5, r2=11.5, h=9);
    translate ([-case_inside/2 + 30 - 11.5,case_inside/2-44+11.5,case_thickness]) cylinder (r1=11.5, r2=11.5, h=9);
    translate ([case_inside/2 - 30 + 11.5,-case_inside/2+44-11.5,case_thickness]) cylinder (r1=11.5, r2=11.5, h=9);
    translate ([-case_inside/2 + 30 - 11.5,-case_inside/2+44-11.5,case_thickness]) cylinder (r1=11.5, r2=11.5, h=9);

    // Cover supports
    for (s = case_cover_supports)
        translate ([s.x, s.y, case_thickness]) cylinder (d=6, h=case_cover_support_height);
}

backstop_offset_z = 12 + 2;
module Backstop()
{
    difference ()
    {
        union ()
        {
        // Back stopper
        translate ([12,0,-7.5]) cube ([2,80,23]);
        translate ([3,0,0]) cube ([11,80,2]);
        translate ([3,51.5,2]) cube ([4,6,2]);
        translate ([3,22,2]) cube ([4,6,2]);
        }

        // Nut holes
        translate ([8,40 + 32,-0.5]) cylinder(r1=1.7,r2=1.7,h=3);
        translate ([8,40 - 32,-0.5]) cylinder(r1=1.7,r2=1.7,h=3);
        
        // Rod holes
        translate ([11.5,40 + bearing_offset,12-3.5])
        rotate (a=90, v=[0,1,0])
        cylinder(r1=4.5,r2=4.0,h=1);
        translate ([11.5,40 + bearing_offset,12-3.5])
        rotate (a=90, v=[0,1,0])
        cylinder(r1=4.0,r2=4.0,h=3);
        
        translate ([11.5,40 - bearing_offset,12-3.5])
        rotate (a=90, v=[0,1,0])
        cylinder(r1=4.5,r2=4.0,h=1);
        translate ([11.5,40 - bearing_offset,12-3.5])
        rotate (a=90, v=[0,1,0])
        cylinder(r1=4.0,r2=4.0,h=3);
    }
}

module Tracks()
{
    module Bearing()
    {
        color("Snow") difference()
        {
            translate ([0,0,7.5]) rotate (a=90, v=[0,1,0])
                cylinder (r1=7.5, r2=7.5, h=45);
            translate ([-1,0,7.5]) rotate (a=90, v=[0,1,0])
                cylinder (r1=4.2, r2=4.2, h=47);
        }
    }

    module Rod()
    {
        color("Snow") translate ([0,0,4]) rotate (a=90, v=[0,1,0])
            cylinder (r1=4, r2=4, h=168);
    }

    // Bearings and rods
    translate ([-base_length/2 + bearing_margin_frontback, bearing_offset,0]) Bearing();

    translate ([-base_length/2 + bearing_margin_frontback, -bearing_offset,0]) Bearing();

    translate ([-168/2, bearing_offset,3.5]) Rod();
    translate ([-168/2, -bearing_offset,3.5]) Rod();
}

module CaseCoverFull()
{
    difference()
    {
        translate ([-case_outside/2,-case_outside/2,case_depth])
        difference ()
        {
            union()
            {
                difference()
                {
                    cube ([case_outside, case_outside, case_cover_height]);
                    translate ([case_thickness, case_thickness, -case_thickness])
                    cube ([case_inside, case_inside, case_cover_height]);
                }

                for (s = case_cover_supports)
                {
                    h = case_cover_support_height-case_cover_height;
                    translate([case_outside/2 + s.x, case_outside/2 + s.y, 0])
                    {
                        translate ([0, 0, h+case_thickness]) cylinder (d=8.5+case_thickness, h=h);
                    }
                }
            }

            // Shaft groove
            translate ([case_outside/2 + grooveOffset, case_outside/2, case_cover_height - case_thickness - 1])
            {
                cube ([grooveLength, grooveDiameter, case_thickness + 6], center = true);
                translate ([grooveLength/2,0,0])
                cylinder(d=grooveDiameter, h=case_thickness + 2);
                translate ([-grooveLength/2,0,0])
                cylinder(d=grooveDiameter, h=case_thickness + 2);

                translate ([-(60),-28,1])
                cube([120,28, 1]);
            }

            // Fitting cuts
            case_fitting_cut_thickness = 1;
            case_fitting_cut_height = 1.5;
            translate ([case_thickness - case_fitting_cut_thickness, case_thickness - case_fitting_cut_thickness, - 0.01])
            cube ([case_inside + case_fitting_cut_thickness*2, case_inside + 2*case_fitting_cut_thickness, case_fitting_cut_height]);
        }
        for (s = case_cover_supports)
        {
            translate([s.x, s.y, case_cover_support_height + case_thickness])
            {
                translate ([0, 0, 0]) cylinder (d=3.8, h=case_cover_height+case_thickness);
                translate ([0, 0, case_thickness]) cylinder (d=8.5, h=case_cover_height);
            }
        }
    }
}

module CaseCover(left = true, right = true)
{
    // Left half
    translate([0,-2,0])
    if (left == true)
    {
        difference()
        {
            intersection()
            {
                CaseCoverFull();
                scale([0.965, 0.965, 0.96])
                minkowski()
                {
                    translate ([-case_outside/2,-case_outside/2,case_depth])
                    cube ([case_outside, case_outside, case_cover_height]);
                    sphere(2.8, $fn=50);
                }
            }
            translate([-100,0,0])
            cube([200, 200, 200]);
        }
        // Connector supports
        translate ([-case_inside/2,-3, case_depth + case_cover_height - 2*case_thickness])
        {
            translate ([0, 0, 1.5])
            cube ([10, 5, 1.5]);
            translate ([case_inside-10, 0, 1.5])
            cube ([10, 5, 1.5]);
        }
        translate ([case_inside/2-1.5, -10, case_cover_height-1])
        cube ([1.5, 10, 7]);
        translate ([-case_inside/2, -5-35, case_cover_height-3])
        cube ([1.5, 5, 9]);
    }

    // Right half
    translate([0,2,0])
    if (right == true)
    {
        difference()
        {
            intersection()
            {
                CaseCoverFull();
                scale([0.965, 0.965, 0.965])
                minkowski()
                {
                    translate ([-case_outside/2,-case_outside/2,case_depth])
                    cube ([case_outside, case_outside, case_cover_height]);
                    sphere(3, $fn=50);
                }
            }
            translate([-100,-200,0])
            cube([200, 200, 200]);

            // Center detent
            translate([grooveOffset,grooveDiameter/2 + 28,case_depth + case_cover_height - case_thickness -0.1])
            cylinder(d=4.5, h=case_thickness + 0.2);
        }

        // Connector supports
        translate ([-case_inside/2,0, case_depth + case_cover_height - 2*case_thickness])
        {
            translate ([case_inside-30, -2, 1.5])
            cube ([10, 5, 1.5]);
        }
        translate ([case_inside/2-1.5, 0, case_cover_height-1])
        cube ([1.5, 10, 7]);
        translate ([-case_inside/2, 35, case_cover_height-3])
        cube ([1.5, 5, 9]);
    }
}

module CaseCircuitSupport()
{
    difference()
    {
        translate ([0, 0, 0])
        cube ([15-4+5.3*2, 80, 3]);

        translate ([3 + 16 - 4, 3 + 4, -0.5])
        cylinder(d=6, h=4);

        translate ([3 + 16 - 4, 3 + 4 + 65.5, -0.5])
        cylinder(d=6, h=4);

        translate ([-0.1, 31, -0.1])
        cube ([9, 80, 4]);
    }

    ziptie_thickness = 2;
    ziptie_width = 3.5;
    difference()
    {
        translate ([0, 0, 3])
        cube ([2, 31, 13]);

        translate ([4, 26, 9])
        rotate([0,-10,90])
        {
        cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([0,0,5])
        cube ([ziptie_width, 22, ziptie_thickness]);

        translate([-8,0,0])
            {
            cube ([ziptie_width, 22, ziptie_thickness]);
            translate ([0,0,5])
            cube ([ziptie_width, 22, ziptie_thickness]);
            }
        }
    }

    translate([10,15,3])
    tube(3, 8, 1.5);

    translate([-3.5,11,5])
    cube([3.5, 20, 2]);

    translate([-2,11,5])
    rotate([0,45,0])
    cube([3.5, 20, 2]);
}
