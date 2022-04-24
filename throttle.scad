include <common.scad>
include <throttle-base.scad>
include <throttle-handle.scad>
include <throttle-case.scad>
include <throttle-guts.scad>

// Put it all together for a grand view of it all

module Throttle()
{   
    color("DimGray") CaseBottom();

    moveY(3*separation) moveZ(separation)
    difference()
    {
        CaseCover(right=true, left=false);

        moveX(case_inside.x/2 - 16)
        moveY(case_inside.y/2 - 16)
        moveZ(case_depth + case_cover_height + 0.01)
        translate([-(19 + 12), 0, 0])
        {
            CherryMxCutout(h = case_thickness + 1, top_depth=0);
            translate([19, 0, 0])
            CherryMxCutout(h = case_thickness + 1, top_depth=0);
            translate([-19, 0, 0])
            CherryMxCutout(h = case_thickness + 1, top_depth=0);
        }
    }

    moveY(-3*separation) moveZ(separation) CaseCover(right=false, left=true);
    
    translate(guts_offset)
    color("Silver")
    {
        Guts();
        moveX(throttle_offset)
        {
            translate ([0,0,case_bottom])
            BasePrinted(leverDistance=throttle_lever_distance);

            translate ([0, 0, case_bottom + base_height + separation])
            ShaftAndBase(shaft_length, shaft_intrusion);
            moveY(base_width/2 + 3) moveZ(case_bottom + base_height + 9) flipY() turnZ(-90)
            BallSpringPlunger3(ballPart=true);
        }

        moveX(-case_inside.x/2 - throttle_slider_end_length)
        translate ([0, -base_width/2 - throttle_lever_distance, case_thickness])
        {
            ThrottleAxisHolder();
            moveX(throttle_travel + 2*throttle_slider_end_length)
            ThrottleAxisHolder();
        }
    }

    translate(guts_offset)
    moveZ(shaft_length + case_bottom + base_height + separation + shaft_connector_height)
    moveY(-handle_case_print_offset_z)
    turnX(handleAngle-90)
    handle();
}
