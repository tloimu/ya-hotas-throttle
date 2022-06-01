// Throttle case

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

module CaseCoverSolid(inset = 0)
{
    r = case_thickness;
    d = r * 2;

    bottomBox = [ case_outside.x - d, case_outside.y - d, 1 ];
    topBox = [ case_outside.x - d, case_outside.y - d - case_cover_height/sqrt(2), case_cover_height - r ];
    hLow = case_cover_height - case_cover_height/sqrt(2) - r;

    if (inset == 0)
    {
        moveX(r) moveY(r)
        hull()
        {
            cylinder(h=1, d=d);

            moveX(bottomBox.x)
            cylinder(h=1, d=d);

            moveX(bottomBox.x)
            moveY(bottomBox.y)
            cylinder(h=1, d=d);

            moveY(bottomBox.y)
            cylinder(h=1, d=d);

            moveZ(hLow)
            {
                moveY(bottomBox.y)
                sphere(d=d);
                moveX(bottomBox.x) moveY(bottomBox.y)
                sphere(d=d);
            }

            moveZ(topBox.z)
            {
                sphere(d=d);
                moveX(topBox.x)
                sphere(d=d);
                moveY(topBox.y)
                sphere(d=d);
                moveX(topBox.x) moveY(topBox.y)
                sphere(d=d);
            }
        }
    }
    else
    {
        h = case_cover_height - inset;
        translate([inset, inset, 0])
        turnX(90) turnY(90)
        linear_extrude(height = case_outside.x - 2*inset)
        {
            polygon([
                [0, 0], [0, h], [topBox.y, h],
                [bottomBox.y, hLow], [bottomBox.y, 0], [0, 0]
            ]);   
        }
    }
}

module CaseCoverMainBody()
{
    difference()
    {
        carveAndFillWith()
        {
            CaseCoverSolid();
            moveZ(-0.01)
            CaseCoverSolid(inset = case_thickness);

            // Screw supports
            for (s = case_cover_supports)
            {
                h = case_cover_height - case_thickness;
                translate([case_outside.x/2 + s.x, case_outside.y/2 + s.y, case_thickness])
                cylinder (d=8.5+case_thickness, h=h);
            }
        }
    }
}

module DetentPlate(font_size=4, slotOnly=false) // set font_size=0 to omit top-side markings
{
    plate_end_len = rails_stopper_width + 2;
    plate_groove_width = detent_plate_size.y - 2; // a good minimum is the ball diameter
    plate_size = detent_plate_slot_size;
    vert_support_w = 2; vert_support_h = 15;

    if (slotOnly)
    {
        slot_margin = 0.5;
        moveX(-detent_plate_slot_size.x - plate_end_len - slot_margin)
        translate([detent_plate_slot_size.x/2, -vert_support_w - 2.5 - slot_margin, 0])
        cube([plate_end_len * 2 + detent_plate_slot_size.x + 2 * slot_margin, detent_plate_slot_size.y + vert_support_w + 2 * slot_margin, vert_support_h]);
    }
    else
    {
        difference()
        {
            union()
            {
                color("orange")
                translate([-plate_size.x/2 - plate_end_len, -plate_size.y/2, 0])
                cube([plate_size.x + 2 * plate_end_len, plate_size.y, plate_size.z]);

                moveY(plate_size.y)
                moveX(-plate_size.x - plate_end_len)
                color("blue")
                translate([plate_size.x/2, -plate_size.y/2, plate_size.z - vert_support_h])
                {
                    cube([plate_end_len * 2 + plate_size.x, vert_support_w, vert_support_h]);
                }
            }

            // Detents and their top-size markings
            for (s=detent_values)
            {
                translate([throttle_travel/2-s.x*throttle_travel, 0, 0])
                {
                    turnX(90) cylinder(h=plate_groove_width, d=4*s.y, center=true, $fn=4);
                    if (font_size > 0)
                    {
                        moveZ(plate_size.z - 0.3)
                        {
                            moveY(-plate_size.y/2)
                            moveX(-0.5)
                            cube([1, plate_size.y, 0.5]);

                            moveX(-1)
                            moveY(-plate_size.y/2 + font_size/2 + 5)
                            turnZ(180)
                            if (s.z == undef)
                                linear_extrude(height = 0.5) { text(text=str(s.x * 100), size=font_size, halign="left"); }
                            else
                                linear_extrude(height = 0.5) { text(text=s.z, size=font_size, halign="left"); }
                        }
                    }
                }
            }

            // Screw holes
            capDepth = 3;
            moveZ(-plate_size.z + 0.01 - capDepth)
            {
                moveX(plate_size.x/2 + 7/2)
                ScrewCavity3m(10, capDepth = capDepth + 10);

                moveX(-(plate_size.x/2 + 7/2))
                ScrewCavity3m(10, capDepth = capDepth + 10);
            }
        }
    }
}

module CaseCoverFull(fast = false)
{
    difference()
    {
        translate ([-case_outside.x/2, -case_outside.y/2, case_depth])
        difference ()
        {
            CaseCoverMainBody();

            // Cherry button inserts
            moveY(case_outside.y + case_thickness + 2.6)
            moveX(case_outside.x - case_thickness - 12)
            turnX(-45)
            turnZ(180)
            moveY(14)
            {
                CherryMxCutout(h = case_thickness + 1, top_depth=0);
                moveX(19)
                CherryMxCutout(h = case_thickness + 1, top_depth=0);
                moveX(2*19)
                CherryMxCutout(h = case_thickness + 1, top_depth=0);
            }

            // Shaft groove
            translate(guts_offset)
            moveX(case_outside.x/2)
            translate ([-grooveClearance - throttle_travel/2, case_outside.y/2 - grooveDiameter/2, case_cover_height - case_thickness - 0.1])
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

        // Detent plate slot
        moveZ(case_bottom_gap)
        translate(guts_offset)
        translate(detent_plate_base_offset)
        DetentPlate(slotOnly=true);

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

module CaseCover(left = true, right = true, fast = false)
{
    // Left half
    if (left == true)
    {
        difference()
        {
            CaseCoverFull(fast=fast);

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
            CaseCoverFull(fast=fast);

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
