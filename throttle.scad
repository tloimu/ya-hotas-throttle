include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;

separateHandle = true;

handleSeparation = separateHandle ? 15 : 0;

handle_radius = 30;
shaft_intrusion = caseThickness + 1;
shaft_length = 35;

// Put it all together for a grand view of it all

module All()
{
    rotate([0,0,180])
    translate ([0,0,case_bottom]) BasePrinted();
    rotate([0,0,180])
    translate ([-17.5,base_width/2,12+case_bottom]) MainThrottleLever();
    translate ([0,0,case_bottom]) Tracks();
    
    color("DimGray") CaseBottom();
    %CaseCover();
    translate ([-(case_inside/2)+case_bottom+12, -case_inside/2 + 29, 9.5 + case_thickness])
    {
        translate([0,0,5.6])
        SlidePotentiometer100();
        rotate([0,0,180])
        translate([-134.5,-11.6,0])
        ThrottleAxisHolder();
        translate([-6.5,-3.4,0])
        ThrottleAxisHolder();
    }

    translate ([0,0,base_height + case_bottom]) ShaftAndBase(shaft_length, shaft_intrusion);

    translate ([0,-25,base_height + case_bottom + shaft_length + 18 - shaft_intrusion + handleSeparation])
    rotate([handleAngle-90,0,0])
    handle();
        
    translate ([case_inside/2 - 23,-40,6 + case_thickness]) Backstop();

    moveY(base_width/2 + 6) moveZ(35) flipY() turnZ(-90) BallSpringPlunger(); // center detent actuator
}

All();
