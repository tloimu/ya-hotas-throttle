// Throttle case

include <throttle-parameters.scad>
include <common.scad>

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
grooveLength = throttle_travel + 2 * grooveClearance;

case_fitting_cut_thickness = case_thickness / 2 + 0.2;
case_fitting_cut_height = case_thickness / 2;

module CaseBottom()
{
    module CaseNut(x, y, h = 6) // center from the inner back-right corner of the case
    {
        off_x = -case_inside.x/2 + x;
        off_y = case_inside.y/2 - y;
        moveX(off_x) moveY(off_y)
        moveZ(case_thickness)
        difference ()
        {
            cylinder (r1=2.5, r2=2.5, h=h);
            cylinder (r1=1.5, r2=1.5, h=h + 1);
        }
    }

    color("DimGray")
    union()
    {
        CaseNut(40, 10);
        CaseNut(60, 10);
        CaseNut(100, 10);
        CaseNut(140, 10);

        moveZ(case_thickness)
        translate(guts_offset)
        Guts(test_frame=false, lowerPartOnly=true, otherParts=false);

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
        }

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
    }
}

module CaseCoverFull()
{
    difference()
    {
        translate ([0, -case_outside.y/2, case_depth])
        difference ()
        {
            translate ([-case_outside.x/2, 0, 0])
            union()
            {
                // Main case body
                roundness = 4;
                roundCube(d=roundness,
                    size=[case_outside.x, case_outside.y, case_cover_height + 0.12*roundness],
                    offset=[0,0,roundness])
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
            translate(guts_offset)
            translate ([-grooveClearance - throttle_travel/2, case_outside.y/2 - grooveDiameter/2, case_cover_height - case_thickness - 0.1])
            {
                cube ([grooveLength, grooveDiameter, case_thickness + 0.2]);
                translate ([grooveLength,grooveDiameter/2,0])
                cylinder(d=grooveDiameter, h=case_thickness + 0.2);
                translate ([0,grooveDiameter/2,0])
                cylinder(d=grooveDiameter, h=case_thickness + 0.2);
            }

            // Fitting cuts
            translate ([-case_outside.x/2, 0, 0])
            translate ([case_thickness - case_fitting_cut_thickness, case_thickness - case_fitting_cut_thickness, - 0.01])
            cube ([case_inside.x + case_fitting_cut_thickness*2, case_inside.y + 2*case_fitting_cut_thickness, case_fitting_cut_height]);
        }

        // Detents
        moveY(guts_offset.y)
        for (s = detent_values)
        {
            translate([-s.x * throttle_travel + throttle_travel/2, 31 + detent_ball_offset, -case_thickness - sqrt(3) - (1.0-s.y) + case_depth + case_cover_height -0.1])
            turnZ(90)
            turnX(45)
            cube([12, 3, 3]);
        }

        // Support cavities
        for (s = case_cover_supports)
        {
            translate([s.x, s.y, case_cover_support_height + case_thickness])
            {
                translate ([0, 0, -0.01]) cylinder (d=3.8, h=case_cover_height+case_thickness);
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

            translate(guts_offset)
            translate([-case_outside.x/2-1, 0, 0])
            cube([case_outside.x+2, case_outside.y, 200]);
        }
        moveY(guts_offset.y)
        {
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
        }
        translate([0, -case_inside.y/2, case_depth]) cube([7, 1, 6]); // side wall
    }

    // Right half
    if (right == true)
    {
        difference()
        {
            CaseCoverFull();

            translate(guts_offset)
            translate([-case_outside.x/2-1,-case_outside.y,0])
            cube([case_outside.x+2, case_outside.y, 200]);
        }

        moveY(guts_offset.y)
        {
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
        }
        translate([0, case_inside.y/2 - 1, case_depth]) cube([7, 1, 6]); // side wall
    }
}
