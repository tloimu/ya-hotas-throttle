include <common.scad>;
include <throttle-base.scad>;
include <throttle-handle.scad>;
include <throttle-case.scad>;

drawOtherParts = false;
separateHandle = true;

handleSeparation = separateHandle ? 15 : 0;

handle_radius = 30;
shaft_intrusion = caseThickness + 1;
shaft_length = 35;

// Lay out all printable parts on the same level

// Parts inside
ShaftAndBase(shaft_length, shaft_intrusion);
moveX(60)
{
    moveZ(main_throttle_lever_height) flipY() MainThrottleLever();
    moveX(30)
    {
        moveZ(base_height) flipY() BasePrinted();
        moveX(45)
        {
            moveZ(ThrottleAxisHolderOffsetX) turnY(-90) ThrottleAxisHolder();
            moveX(20)
            {
                moveZ(ThrottleAxisHolderOffsetX) turnY(-90) ThrottleAxisHolder();
                moveX(15)
                {
                    moveZ(backstop_offset_z) turnY(90) Backstop();
                    moveX(30) moveZ(BallSpringPlungerBallPartOffsetZ) flipY()
                    BallSpringPlunger(springPart=false);
                    moveX(45) moveZ(BallSpringPlungerSpringPartOffsetZ)
                    BallSpringPlunger(ballPart=false);
                }
            }
        }
    }
}

// Case and handle
moveY(90)
{
    moveX(120)
    {
        moveZ(handle_case_print_offset_z) handleCase();
        moveY(0) moveX(-50)
        {
            moveX(-45)
            moveY(-20)
            moveZ(thumb_print_offset_z) 
            turnX(thumbPlateAngle.x) turnY(180 - thumbPlateAngle.y)
            handleThumbPart();
            moveX(80)
            {
                flipY()
                moveY(140)
                moveZ(-2*case_cover_height - caseThickness/2)
                {
                    CaseCover(left=true, right=false);
                    moveY(-130) moveX(150)
                    // Turn the right cover to print the correct way - your slicer may do this differently, so check it
                    turnZ(-45) CaseCover(left=false, right=true);
                }
            }
        }
    }
}

// Knobs and buttons (Recommend 0.20mm layer on 0.40mm nozzle)
moveY(-50)
{
    moveZ(12) flipY() XPotKnob();
    moveX(30)
    moveZ(12) flipY() YPotKnob();
    moveX(50)
    {
        flipY() hatKnob();
        moveX(15)
        for (i=[0:1:4])
        {
            moveX(15*i)
            moveZ(SwitchButtonBallOffsetZ)
            SwitchButtonBall();
        }
    }
}
