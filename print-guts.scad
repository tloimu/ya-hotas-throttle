//include <throttle-handle.scad>;

include <common.scad>;
include <throttle-parameters.scad>;

/*
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(5)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(10)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(15)
tubeD(din=2.9,dout=4.5,h=0.6);
moveY(5)
{
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(5)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(10)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(15)
tubeD(din=2.9,dout=4.5,h=0.6);
}
moveY(10)
{
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(5)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(10)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(15)
tubeD(din=2.9,dout=4.5,h=0.6);
}
moveY(15)
{
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(5)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(10)
tubeD(din=2.9,dout=4.5,h=0.6);
moveX(15)
tubeD(din=2.9,dout=4.5,h=0.6);
}
*/
//draw_other_parts=true;
//showKnobs=true;
//include <common.scad>;
//rotate([-90, 0, 0]) handle();

//xyPots();
//thumbSupports();

//buttonModuleButtons();
//buttonModuleSprings();

//handleThumbPart();
/*
moveY(0)
{
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="5");
    moveX(10)
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="6");
    moveX(20)
    SwitchButtonBall(d=8, h=6, topRounding=3.75, text="5");
    moveX(30)
    SwitchButtonBall(d=8, h=6, topRounding=3.75, text="6");
}
moveY(10)
{
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="1");
    moveX(10)
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="2");
    moveX(20)
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="3");
    moveX(30)
    SwitchButtonBall(d=8, h=7, topRounding=3.5, text="4");
}
*/

// ---------------------------------------
// Throttle Case
// ---------------------------------------
include <throttle.scad>
include <throttle-guts.scad>

//Throttle();
showThumb=false;

include <throttle-guts.scad>
separation=0;
draw_other_parts=false;
/*
difference()
{
    CaseBottom();
    moveX(-110) moveY(-215) moveZ(-10)
    cube([200, 220, 210]);
}

moveZ(case_thickness)
translate(guts_offset)
Guts(otherParts=draw_other_parts, test_frame=true, lowerPartOnly=false);

*moveY(3*separation) moveZ(separation)
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

*moveY(-3*separation) moveZ(separation) CaseCover(right=false, left=true);

*moveX(throttle_offset)
{
    translate(guts_offset)
    translate ([0, 0, case_bottom])
    {
        *BasePrinted(leverDistance=throttle_lever_distance);

        moveX(-throttle_offset)
        translate(detent_plate_base_offset)
        DetentPlate();

        *translate ([0, 0, base_height + separation])
        ShaftAndBase(shaft_length, shaft_intrusion);
    }
}
*/

// Printable guts with full frames

moveY(150)
color("green")
{
    Guts(lowerPartOnly=true, test_frame=true, otherParts=false);

    *moveY(60)
    turnZ(90)
    moveZ(bearing_height/2)
    turnX(180)
    moveZ(-(bearing_height/2 + case_bottom_gap))
    Frontstop(lowerPart=false);

    *moveY(-53)
    CableGuide(draw_guide=true, h=base_height + case_bottom_gap + 2, cable_diameter=cable_guide_cable_d);

    *moveY(-62.5)
    moveZ(6.5)
    turnX(-90)
    DetentPlate();

    moveY(30) moveZ(base_length/2) turnZ(90) turnY(90) BasePrinted();
}

