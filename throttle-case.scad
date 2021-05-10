// Throttle case

include <throttle-parameters.scad>;
include <throttle-base.scad>;

// Case parameters

case_bottom = case_bottom_gap + case_thickness;
case_inside = [case_outside.x - 2 * case_thickness, case_outside.y - 2 * case_thickness];

case_cover_support_offset = [(case_outside.x/2 - 10.7 + 3),(case_outside.y/2 - 13.2 + 3)];
case_cover_supports = [
    [-case_cover_support_offset.x, -case_cover_support_offset.y],
    [-case_cover_support_offset.x, case_cover_support_offset.y],
    [case_cover_support_offset.x, -case_cover_support_offset.y],
    [case_cover_support_offset.x, case_cover_support_offset.y]
    ];
case_cover_support_height = case_depth;

// Case cover parameters

grooveDiameter = 2 * shaft_outer_radius + grooveClearance;
grooveLength = throttle_travel + grooveClearance;
grooveOffset = throttle_offset + grooveClearance;

case_fitting_cut_thickness = case_thickness / 2 + 0.2;
case_fitting_cut_height = case_thickness / 2;


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

    moveX(case_inside.x/2 - 40) moveY(-case_inside.y/2 + 10) moveZ(case_thickness) CaseNut();
    moveX(case_inside.x/2 - 40 - 30) moveY(-case_inside.y/2 + 10) moveZ(case_thickness) CaseNut();
    
    translate ([-case_outside.x/2,-case_outside.y/2,0])
    difference ()
    {
        roundCube(d=3, size=[case_outside.x, case_outside.y, 2*case_depth], offset=[0,0,2])
        cube ([case_outside.x, case_outside.y, case_depth + case_fitting_cut_height]);

        case_gap = 0.00;
        translate ([case_fitting_cut_thickness,case_fitting_cut_thickness,case_depth-case_gap])
        cutRectRimZ(case_outside.x - 2*case_fitting_cut_thickness - 0.2, case_outside.y - 2*case_fitting_cut_thickness - 0.2, case_fitting_cut_thickness + 1 + case_gap);

        translate ([case_thickness, case_thickness, case_thickness])
        cube ([case_outside.x-2*case_thickness, case_outside.y-2*case_thickness, case_depth]);

        // Rod screws holes
        translate([-0.1, case_outside.y/2 - bearing_offset, bearing_height/2 + case_bottom]) turnY(90) cylinder(d=3 + 0.2,h=case_thickness + 0.2);
        translate([-0.1, case_outside.y/2 + bearing_offset, bearing_height/2 + case_bottom]) turnY(90) cylinder(d=3 + 0.2,h=case_thickness + 0.2);
    }

    // Backstop
    translate ([-case_outside.x/2 + throttle_offset + throttle_travel + base_length/2, 0, case_thickness])
    Backstop();

    // Frontstop
    translate ([-case_inside.x/2 + throttle_offset - base_length / 2 - 8, 0, case_thickness])
    translate ([0,-base_width/2,0]) cube ([8,base_width, 3 + case_bottom_gap]);

    // Cover supports
    for (s = case_cover_supports)
    {
        translate ([s.x, s.y, case_thickness])
        difference()
        {
            union()
            {
                tubeD (dout=7, din=2.8, h=case_cover_support_height);
                moveY(-8) moveX(-0.5) cube ([1, 16, case_depth - 3]);
                moveX(-5) moveY(-0.5) cube ([10, 1, case_depth - 3]);
            }
            cylinder(d=2.8, h=case_cover_support_height);
        }
    }

    // Throttle slider supports
    moveX(throttle_offset - case_inside.x/2 - throttle_slider_end_length)
    translate ([0, -base_width/2 - throttle_lever_distance, case_thickness])
    {
        ThrottleAxisHolder(basePart=true);
        moveX(throttle_travel + 2*throttle_slider_end_length)
        ThrottleAxisHolder(basePart=true);
    }  
}

module Backstop()
{
    difference ()
    {
        union ()
        {
            // Back stopper
            translate ([4,-40,0]) cube ([2,80,case_bottom + 12]);
            translate ([3,-40,0]) cube ([8,80,3 + case_bottom_gap]);
            /*translate ([3,base_cavity_width/2,2]) cube ([4,5,2]);
            translate ([3,-base_cavity_width/2-5,2]) cube ([4,5,2]);*/
        }
        
        // Rod holes
        translate ([3.9,bearing_offset, bearing_height/2 + case_bottom_gap])
        turnY(90)
        cylinder(r1=4.5,r2=4.0,h=1);
        translate ([3.9,bearing_offset, bearing_height/2 + case_bottom_gap])
        turnY(90)
        cylinder(r1=4.0,r2=4.0,h=3);
        
        translate ([3.9,-bearing_offset, bearing_height/2 + case_bottom_gap])
        turnY(90)
        cylinder(r1=4.5,r2=4.0,h=1);
        translate ([3.9,-bearing_offset, bearing_height/2 + case_bottom_gap])
        turnY(90)
        cylinder(r1=4.0,r2=4.0,h=3);
    }
}

module Tracks(bearingPosition=0)
{
    module Bearing()
    {
        color("Snow") difference()
        {
            translate ([0,0,bearing_height/2]) turnY(90)
                cylinder (d=bearing_height, h=bearing_length);
            translate ([-0.1,0,bearing_height/2]) turnY(90)
                cylinder (r=4.2, h=bearing_length + 0.2);
        }
    }

    module Rod()
    {
        color("Snow") turnY(90) cylinder (r1=4, r2=4, h=168);
    }

    // Bearings and rods
    moveX(bearingPosition - bearing_length/2)
    {
        translate ([0, bearing_offset,0]) Bearing();
        translate ([0, -bearing_offset,0]) Bearing();
    }

    translate ([-case_inside.x/2, bearing_offset, bearing_height/2]) Rod();
    translate ([-case_inside.x/2, -bearing_offset, bearing_height/2]) Rod();
}

module CaseCoverFull()
{
    difference()
    {
        translate ([-case_outside.x/2,-case_outside.y/2,case_depth])
        difference ()
        {
            union()
            {
                // Main case body
                roundCube(d=3,
                    size=[case_outside.x, case_outside.y, case_cover_height + 0.15],
                    offset=[0,0,3])
                difference()
                {
                    cube ([case_outside.x, case_outside.y, case_cover_height]);
                    translate ([case_thickness, case_thickness, 0])
                    cube ([case_inside.x, case_inside.y, case_cover_height - case_thickness]);
                }

                // Screw supports
                for (s = case_cover_supports)
                {
                    h = case_cover_height - case_thickness;
                    translate([case_outside.x/2 + s.x, case_outside.y/2 + s.y, case_thickness])
                    cylinder (d=8.5+case_thickness, h=h);
                }
            }

            // Shaft groove
            translate ([0 + grooveOffset, case_outside.y/2 - grooveDiameter/2, case_cover_height - case_thickness - 0.1])
            {
                cube ([grooveLength, grooveDiameter, case_thickness + 0.2]);
                translate ([grooveLength,grooveDiameter/2,0])
                cylinder(d=grooveDiameter, h=case_thickness + 0.2);
                translate ([0,grooveDiameter/2,0])
                cylinder(d=grooveDiameter, h=case_thickness + 0.2);
            }

            // Fitting cuts
            translate ([case_thickness - case_fitting_cut_thickness, case_thickness - case_fitting_cut_thickness, - 0.01])
            cube ([case_inside.x + case_fitting_cut_thickness*2, case_inside.y + 2*case_fitting_cut_thickness, case_fitting_cut_height]);
        }

        // Detents
        for (s = detent_values)
        {
            translate([-case_inside.x/2 + throttle_offset + (1 - s.x) * throttle_travel, 36 + detent_ball_offset, case_depth + case_cover_height - case_thickness -0.1])
            cylinder(d=s.y, h=case_thickness + 0.2);
        }

        // Support cavities
        for (s = case_cover_supports)
        {
            translate([s.x, s.y, case_cover_support_height + case_thickness])
            {
                translate ([0, 0, 0]) cylinder (d=3.8, h=case_cover_height+case_thickness);
                translate ([0, 0, case_thickness + 1]) cylinder (d=8.5, h=case_cover_height);
            }
        }
    }
}

module CaseCover(left = true, right = true)
{
    // Left half
    if (left == true)
    {
        difference()
        {
            CaseCoverFull();

            translate([-100,0,0])
            cube([200, 200, 200]);
        }
        // Connector supports
        translate ([-case_inside.x/2,-3, case_depth + case_cover_height - 2*case_thickness])
        {
            translate ([0, 0, 1.5])
            cube ([10, 5, 1.5]);
            translate ([case_inside.x - 10, 0, 1.5])
            cube ([10, 5, 1.5]);
        }

        // Edge supports
        translate([case_inside.x/2 - 1, -7, case_depth]) cube([1, 7, 6]);
        translate([-case_inside.x/2, -7, case_depth]) cube([1, 7, 6]);
        translate([0, -case_inside.y/2, case_depth]) cube([7, 1, 6]); // side wall
    }

    // Right half
    if (right == true)
    {
        difference()
        {
            CaseCoverFull();

            translate([-100,-200,0])
            cube([200, 200, 200]);
        }

        // Connector supports
        translate ([-case_inside.x/2,0, case_depth + case_cover_height - 2*case_thickness])
        {
            translate ([case_inside.x - 21, -2, 1.5])
            cube ([10, 5, 1.5]);
            translate ([11, -2, 1.5])
            cube ([10, 5, 1.5]);
        }

        // Edge supports
        translate([case_inside.x/2 - 1, 0, case_depth]) cube([1, 7, 6]); // front wall
        translate([-case_inside.x/2, 0, case_depth]) cube([1, 7, 6]); // back wall
        translate([0, case_inside.y/2 - 1, case_depth]) cube([7, 1, 6]); // side wall
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


module ThrottleAxisHolder(center = true, basePart=false, sliderPart=false)
{
    l = 16;
    difference()
    {
        union()
        {
            if (sliderPart == true)
            {
                difference()
                {
                    translate([-4, -4 - l + 8, 8 + throttle_slider_height]) cube([8, l, 2]);
                    moveZ(8 + throttle_slider_height - 0.1)
                    cylinder(d=3.5, h=2.2);
                }
            }

            if (basePart == true)
            {
                moveY(-4 - l + 8)
                difference()
                {
                    moveX(-6) cube([12, 7, case_thickness + throttle_slider_height + 5 + 2]);
                    translate([-4, -0.1, 8 + throttle_slider_height]) cube([8, l, 2.1]);
                }
            }
        }

        moveY(-l + 8)
        moveZ(case_thickness + throttle_slider_height)
        cylinder(d=2.5, h=10);
    }
}
