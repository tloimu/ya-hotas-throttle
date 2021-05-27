include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;

throttle_slider_height = 6.4;
throttle_slider_end_length = 10;
handle_radius = 30;

dist = 5;

// Unless otherwise mentioned, 0.30mm layer on 0.40mm nozzle is sufficient

module AllPrintableParts()
{
    CaseBottom();

    moveY(case_outside.y/2 + dist)
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=true, left=false);

    moveY(- case_outside.y/2 - dist)
    flipY() moveZ(-case_depth-case_cover_height) CaseCover(right=false, left=true);

    moveX(case_outside.x + dist)
    {
        moveY(-base_width - handle_radius)
        {
            flipY() moveZ(-base_height)
            BasePrinted(leverDistance=throttle_lever_distance);

            moveX(-base_length - dist)
            ShaftAndBase(shaft_length, shaft_intrusion);

            moveY(base_width)
            moveX(-base_length)
            moveZ(-base_height + 2) 
            {
                ThrottleAxisHolder(sliderPart=true);
                moveX(-2*dist) ThrottleAxisHolder(sliderPart=true);

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
