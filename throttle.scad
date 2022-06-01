include <common.scad>
include <commercial-parts.scad>
include <throttle-base.scad>
include <throttle-handle.scad>
include <throttle-case.scad>
include <throttle-guts.scad>

// Put it all together for a grand view of it all

module Throttle()
{   
    CaseBottom();

    moveY(3*separation) moveZ(separation) CaseCover(right=true, left=false);
    moveY(-3*separation) moveZ(separation) CaseCover(right=false, left=true);
    
    translate(guts_offset)
    {
        moveZ(case_thickness)
        Guts(test_frame=false);

        moveZ(case_thickness)
        moveZ(case_bottom_gap)
        translate(detent_plate_base_offset)
        DetentPlate();

        moveX(throttle_offset)
        {
            translate ([0,0,case_bottom])
            BasePrinted(leverDistance=throttle_lever_distance);

            translate ([0, 0, case_bottom + base_height + separation])
            ShaftAndBase(shaft_length, shaft_intrusion);

            moveZ(shaft_length + case_bottom + base_height + 2*separation)
            moveY(-handle_case_print_offset_z + shaftConnectorPos.y - shaft_outer_radius*2 -1.5) // ???
            turnZ(thumbAngle)
            turnX(handleAngle-90)
            handle();
        }
    }
}
