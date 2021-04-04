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
moveZ(base_height) flipY() BasePrinted();
moveY(50)
{
    moveZ(main_throttle_lever_height) flipY() MainThrottleLever();
    moveX(150)
    {
        moveZ(backstop_offset_z) turnY(90) Backstop();
        moveX(30)
        {
            turnY(-90) ThrottleAxisHolder();
            moveX(20)
            {
                turnY(-90) ThrottleAxisHolder();
                moveX(20)
                {
                    ShaftAndBase(shaft_length, shaft_intrusion);
                    moveX(20)
                         BallSpringPlunger(); // center detent actuator
                }
            }
        }
    }
}

// Case and handle
moveY(100)
{
    moveX(60)
    {
        moveZ(handle_case_print_offset_z) handleCase();
        moveY(100)
        {
            moveZ(thumb_print_offset_z) 
            turnX(thumbPlateAngle.x) turnY(180 - thumbPlateAngle.y)
            handleThumbPart();
            moveX(100)
            {
                flipY()
                moveY(200)
                moveZ(-2*case_cover_height)
                {
                    turnZ(-45) CaseCover(left=false, right=true);
                    moveX(220)
                    {
                        CaseCover(left=true, right=false);
                    }
                }
            }
        }
    }
}
