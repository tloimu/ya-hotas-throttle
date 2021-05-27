include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;

throttle_slider_height = 6.4;
throttle_slider_end_length = 10;

// Put it all together for a grand view of it all

module Throttle()
{   
    color("DimGray") CaseBottom();

    moveY(3*separation) moveZ(separation) CaseCover(right=true, left=false);
    moveY(-3*separation) moveZ(separation) CaseCover(right=false, left=true);
    
    if (draw_other_parts == true)
    {
        translate ([0,0,case_bottom])
        Tracks(-case_inside.x/2 + throttle_offset + throttleValue * throttle_travel);

        color("Snow")
        moveX(throttle_offset)
        translate ([-case_inside.x/2 - throttle_lever_width/2, -base_width/2 - throttle_lever_distance, case_bottom])
        {   
            SlidePotentiometer(sliderEndLength=throttle_slider_end_length, sliderHeight=throttle_slider_height, leverHeight=20,
                value=throttleValue, alignPin=true, alignLever=true, alignValueMax=true);
        }
    }

    color("Silver")
    moveX(throttle_offset + throttleValue * throttle_travel - case_inside.x/2)
    {
        translate ([0,0,case_bottom])
        BasePrinted(leverDistance=throttle_lever_distance);

        translate ([0,0,case_bottom + base_height + separation])
        ShaftAndBase(shaft_length, shaft_intrusion);
        moveY(base_width/2 + 3) moveZ(case_bottom + base_height + 9) flipY() turnZ(-90) BallSpringPlunger2(ballPart=true, springPart=false);
    }

    moveX(throttle_offset - case_inside.x/2 - throttle_slider_end_length)
    translate ([0, -base_width/2 - throttle_lever_distance, case_thickness])
    {
        ThrottleAxisHolder(sliderPart=true);
        moveX(throttle_travel + 2*throttle_slider_end_length)
        ThrottleAxisHolder(sliderPart=true);
    }

    moveZ(shaft_length + case_bottom + base_height + 4*separation + shaft_connector_height)
    moveY(-25)
    turnX(handleAngle-90)
    handle();
}
