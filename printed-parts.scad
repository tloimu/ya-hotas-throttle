include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;
include <throttle-guts.scad>;

handle_radius = 30;

dist = 5;

// Unless otherwise mentioned, 0.30mm layer on 0.40mm nozzle is sufficient

module AllPrintableParts()
{
    moveY(-case_outside.y-dist)
    {
        CaseBottom();

        moveX(case_outside.x/2 + dist + rails_stopper_width)
        FrontstopUpperPartPrintable();
    }

    moveY(dist)
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=true, left=false);
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=false, left=true);

    moveX(case_outside.x + dist)
    {
        moveY(-base_width - handle_radius)
        {
            moveZ(base_length/2)
            turnY(90)
            BasePrinted(leverDistance=throttle_lever_distance);

            moveX(-base_length - dist)
            ShaftAndBase(shaft_length, shaft_intrusion);

            moveY(base_width)
            moveX(-base_length)
            moveZ(-base_height + 2) 
            {
                moveX(-25) moveZ(case_bottom + base_height + 1)
                flipY()
                BallSpringPlunger2(ballPart=true, springPart=false);
            }
        }

        moveX(-70) moveY(60)
        PrintableKnobsAndButtons();

        moveZ(handle_case_print_offset_z)
        handleCase();

        moveY(handle_radius*2 + dist)
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
