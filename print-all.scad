include <throttle-parameters.scad>;
include <commercial-parts.scad>;
include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;
include <throttle-guts.scad>;

handle_radius = 30;

dist = 3;

// Unless otherwise mentioned, 0.30mm layer on 0.40mm nozzle is sufficient

module AllPrintableParts()
{
    moveY(-case_outside.y-dist)
    {
        CaseBottom();

        color("DimGray")
        translate(guts_offset)
        moveZ(case_thickness)
        Guts(test_frame=false, lowerPartOnly=true, otherParts=false);

        moveX(case_outside.x/2 + dist + rails_stopper_width)
        {
            FrontstopUpperPartPrintable();

            moveX(dist)
            {
                moveZ(base_length/2)
                turnY(90)
                BasePrinted(leverDistance=throttle_lever_distance);

                moveX(base_height + 17 + dist)
                turnZ(90)
                ShaftAndBase(shaft_length, shaft_intrusion);
            }
        }
    }

    moveY(dist)
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=true, left=false);
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=false, left=true);

    moveX(case_outside.x/2 + dist)
    {
        CableGuide(draw_guide=true, h=base_height + case_bottom_gap + 2, cable_diameter=cable_guide_cable_d);

        moveX(8 + dist) moveY(30)
        PrintableKnobsAndButtons();

        moveX(2 + dist)
        moveY(-20)
        moveZ(-base_height + 2) 
        {
            moveZ(case_bottom + base_height + 1)
            flipY()
            BallSpringPlunger2(ballPart=true, springPart=false);
        }
    }
    moveY(case_outside.y/2 + dist)
    {
        moveY(50)
        moveX(-50)
        turnZ(180)
        moveZ(handle_case_print_offset_z)
        handleCase();

        moveX(50)
        moveY(handle_radius + 7)
        moveZ(thumb_print_offset_z)
        turnX(thumbPlateAngle.x) turnY(180 - thumbPlateAngle.y)
        handleThumbPart();
    }
}

// Knobs and buttons (Recommend 0.20mm layer on 0.40mm nozzle)
module PrintableKnobsAndButtons()
{
    moveZ(12) flipY() XPotKnob();
    moveY(30)
    moveZ(12) flipY() YPotKnob();
    moveX(20)
    {
        flipY() hatKnob();
        moveX(15)
        for (i=[0:1:4])
        {
            moveY(10*i)
            moveZ(SwitchButtonBallOffsetZ)
            SwitchButtonBall(d=8, h=7, topRounding=3.5);
        }
        moveY(20)
        for (i=[0:1:2])
        {
            moveY(10*i)
            moveZ(SwitchButtonBallOffsetZ)
            SwitchButtonBall(d=8, h=6, topRounding=3.5);
        }
    }
}

AllPrintableParts();
