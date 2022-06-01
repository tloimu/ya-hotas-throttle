include <common.scad>;

module PsButton()
{
	color("black")
	{
		translate ([0,0,-1.5])
		cylinder (d=10.4, h=10.5);
		translate ([-7,-1.5,-1.5])
		cube([14,3,1.5]);
		translate ([0,0,-6.5])
		cylinder (d=5, h=5);
	}
}

module PsButtonHole()
{
	translate ([0,0,-1])
	cylinder (d=10.9, h=12);
}


module HatSwitchX45()
{
	color("lightgrey")
	translate([0,0,-9.5])
	{
		difference()
		{
			translate([-17.5/2,-17.5/2,0])
			cube([17.5, 17.5, 9.5]);
			translate([-7/2,-7/2,0.1])
			cube([7, 7, 9.5]);
			translate([-5.5,-5.5,6])
			cylinder(d=1.4, h=4);
			translate([-5.5,5.5,6])
			cylinder(d=1.4, h=4);
			translate([5.5,-5.5,6])
			cylinder(d=1.4, h=4);
			translate([5.5,5.5,6])
			cylinder(d=1.4, h=4);
			translate([0,0,-0.5])
			tube(25/2, 11, 3);
		}
		translate([0,0,-8])
		cylinder(d=9, h=8);
	}
}

module HatSwitchX45Holes(screws=true)
{
	// Main shaft hole
	cylinder (d=6.5, h=handle_thickness*6);

    if (screws == true)
    {
        // Screw hole 1
        translate ([-5.5,-5.5,-handle_thickness*3])
        cylinder (d=2, h=handle_thickness*6);
        translate ([-5.5,-5.5,1.4])
        cylinder (d=4, h=1);

        // Screw hole 2
        translate ([5.5,5.5,-handle_thickness*3])
        cylinder (d=2, h=handle_thickness*6);
        translate ([5.5,5.5,1.4])
        cylinder (d=4, h=1);

        // Screw hole 3
        translate ([5.5,-5.5,-handle_thickness*3])
        cylinder (d=2, h=handle_thickness*6);
        translate ([5.5,-5.5,1.4])
        cylinder (d=4, h=1);
    }
}


BallSpringPlungerBallPartOffsetZ = 9.5 - 1/2;
BallSpringPlungerSpringPartOffsetZ = -BallSpringPlungerBallPartOffsetZ;
module BallSpringPlunger(ball_diameter = 9.5, spring_diameter = 4.5, spring_length = 19, ball_extrusion_ratio = 0.20,
    springPart=true, ballPart=true)
{
    thickness = 1;
    gap = 0.5;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    screw_d = 2;

    %translate([0, 0, ball_out])
    {
        // spring
        translate([0, 0, ball_diameter/2])
        spring(d=spring_diameter, l=spring_length);
        // ball
        color("silver") sphere(d=ball_diameter);
    }

    if (springPart == true)
        {
        spring_tube_length = spring_length - ball_out - gap;
        translate([0, 0, ball_case_inner_top])
        {
            // spring tube
            tubeD(spring_case_outer_d, spring_case_inner_d, spring_tube_length);

            // top ring
            translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);
            // ring
            tubeD(ball_case_outer_d, spring_case_outer_d, thickness);

            // connector plate
            difference()
            {
                translate([0, 0, thickness-thickness/2])
                cube([ball_case_outer_d, 2*ball_case_outer_d, thickness], center = true);
                translate([0,0,-0.1])
                {
                    cylinder(d=spring_case_inner_d,h=thickness+0.2);
                    
                    translate([0,ball_case_outer_d- screw_d,0])
                    cylinder(d=screw_d,h=thickness+0.2);
                    translate([0,-(ball_case_outer_d- screw_d),0])
                    cylinder(d=screw_d,h=thickness+0.2);
                }
            }

            // fixture plate
            fixture_plate_height = ball_case_outer_d;
            translate([ball_case_outer_d/2, 0, fixture_plate_height/2])
            {
                difference()
                {
                    cube([thickness, 2*ball_case_outer_d, ball_case_outer_d], center = true);
                    
                    translate([-thickness/2-0.1,ball_case_outer_d- screw_d,0])
                    rotate([0,90,0])
                    cylinder(d=screw_d,h=thickness+0.2);
                    translate([-thickness/2-0.1,-(ball_case_outer_d- screw_d),0])
                    rotate([0,90,0])
                    cylinder(d=screw_d,h=thickness+0.2);
                }
            }
        }
    }
    
    if (ballPart == true)
    {
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }

        // connector plate
        translate([0,0,ball_case_inner_top])
        difference()
        {
            translate([0,0,-thickness/2])
            cube([ball_case_outer_d, 2*ball_case_outer_d, thickness], center = true);
            translate([0,0,-thickness-0.1])
            {
                cylinder(d=ball_case_inner_d,h=thickness+0.2);

                translate([0,ball_case_outer_d- screw_d,0])
                cylinder(d=screw_d,h=thickness+0.2);
                translate([0,-(ball_case_outer_d- screw_d),0])
                cylinder(d=screw_d,h=thickness+0.2);
            }
        }
    }
}



module BallSpringPlunger2(ball_diameter = 9.5, spring_diameter = 4.5, spring_length = 19, ball_extrusion_ratio = 0.20,
    springPart=true, ballPart=true)
{
    thickness = 1;
    gap = 0.5;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    screw_d = 2;

    if (draw_other_parts == true)
    {
        %translate([0, 0, ball_out])
        {
            // spring
            translate([0, 0, ball_diameter/2])
            spring(d=spring_diameter, l=spring_length);
            // ball
            color("silver") sphere(d=ball_diameter);
        }
    }

    if (springPart == true)
        {
        spring_tube_length = spring_length - ball_out - gap;
        translate([0, 0, ball_case_inner_top])
        {
            // spring tube and its bottom
            tubeD(spring_case_outer_d, spring_case_inner_d, spring_tube_length);
            translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);

            // connector plate
            difference()
            {
                connector_plate_thickness = 1;
                translate([0, 0, connector_plate_thickness/2])
                cube([ball_case_outer_d, 2*ball_case_outer_d + 1, connector_plate_thickness], center = true);
                translate([0,0,-0.1])
                {
                    cylinder(d=spring_case_inner_d,h=connector_plate_thickness+0.2);
                    
                    translate([0,ball_case_outer_d- screw_d,0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                    translate([0,-(ball_case_outer_d- screw_d),0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                }
            }
        }
    }
    
    if (ballPart == true)
    {
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }

        // connector plate
        translate([0,0,ball_case_inner_top])
        difference()
        {
            translate([0,0,-thickness/2])
            cube([ball_case_outer_d, 2*ball_case_outer_d + 1, thickness], center = true);
            translate([0,0,-thickness-0.1])
            {
                cylinder(d=ball_case_inner_d,h=thickness+0.2);

                translate([0,ball_case_outer_d- screw_d,0])
                cylinder(d=screw_d,h=thickness+0.2);
                translate([0,-(ball_case_outer_d- screw_d),0])
                cylinder(d=screw_d,h=thickness+0.2);
            }
        }
    }
}


module BallSpringPlunger3(ball_diameter = 9.5, spring_diameter = 4.5, spring_length = 19, ball_extrusion_ratio = 0.20,
    springPart=false, ballPart=false, slotPart=false)
{
    thickness = 1;
    gap = 0.5;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    screw_d = 2;

/*    if (draw_other_parts == true)
    {
        %translate([0, 0, ball_out])
        {
            // spring
            translate([0, 0, ball_diameter/2])
            spring(d=spring_diameter, l=spring_length);
            // ball
            color("silver") sphere(d=ball_diameter);
        }
    }*/

    if (springPart == true)
        {
        spring_tube_length = spring_length - ball_out - gap;
        translate([0, 0, ball_case_inner_top])
        {
            // spring tube and its bottom
            tubeD(spring_case_outer_d, spring_case_inner_d, spring_tube_length);
            translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);

            // connector plate
            difference()
            {
                connector_plate_thickness = 3;
                translate([0, 0, connector_plate_thickness/2])
                cube([ball_case_outer_d, 2*ball_case_outer_d + 1, connector_plate_thickness], center = true);
                translate([0,0,-0.1])
                {
                    cylinder(d=spring_case_inner_d,h=connector_plate_thickness+0.2);
                    
                    translate([0,ball_case_outer_d- screw_d,0])
                    cylinder(d=screw_d,h=3+0.2);
                    translate([0,-(ball_case_outer_d- screw_d),0])
                    cylinder(d=screw_d,h=3+0.2);
                }
            }
        }
    }
    
    if (ballPart == true)
    {
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }

        // connector plate
        translate([0,0,ball_case_inner_top])
        difference()
        {
            translate([0,0,-thickness/2])
            cube([ball_case_outer_d, 2*ball_case_outer_d + 1, thickness], center = true);
            translate([0,0,-thickness-0.1])
            {
                cylinder(d=ball_case_inner_d,h=thickness+0.2);

                translate([0,ball_case_outer_d- screw_d,0])
                cylinder(d=screw_d,h=thickness+0.2);
                translate([0,-(ball_case_outer_d- screw_d),0])
                cylinder(d=screw_d,h=thickness+0.2);
            }
        }
    }
}


module BallSpringPlunger4(ball_diameter = 9.5, spring_diameter = 4.5, spring_length = 19, ball_extrusion_ratio = 0.20,
    springPart=true, ballPart=true)
{
    thickness = 1;
    gap = 0.5;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    screw_d = 2;

    if (draw_other_parts == true)
    {
        %translate([0, 0, ball_out])
        {
            // spring
            translate([0, 0, ball_diameter/2])
            spring(d=spring_diameter, l=spring_length);
            // ball
            color("silver") sphere(d=ball_diameter);
        }
    }

    if (springPart == true)
        {
        spring_tube_length = spring_length - ball_out - gap;
        translate([0, 0, ball_case_inner_top])
        {
            // spring tube and its bottom
            tubeD(spring_case_outer_d, spring_case_inner_d, spring_tube_length);
            translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);

            // connector plate
            difference()
            {
                connector_plate_thickness = 1;
                translate([0, 0, connector_plate_thickness/2])
                cube([ball_case_outer_d, 2*ball_case_outer_d + 1, connector_plate_thickness], center = true);
                translate([0,0,-0.1])
                {
                    cylinder(d=spring_case_inner_d,h=connector_plate_thickness+0.2);
                    
                    translate([0,ball_case_outer_d- screw_d,0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                    translate([0,-(ball_case_outer_d- screw_d),0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                }
            }
        }
    }
    
    if (ballPart == true)
    {
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }

        // connector plate
        translate([0,0,ball_case_inner_top])
        difference()
        {
            translate([0,0,-thickness/2])
            cube([ball_case_outer_d, 2*ball_case_outer_d + 1, thickness], center = true);
            translate([0,0,-thickness-0.1])
            {
                cylinder(d=ball_case_inner_d,h=thickness+0.2);

                translate([0,ball_case_outer_d- screw_d,0])
                cylinder(d=screw_d,h=thickness+0.2);
                translate([0,-(ball_case_outer_d- screw_d),0])
                cylinder(d=screw_d,h=thickness+0.2);
            }
        }
    }
}


module BallSpringPlunger5(ball_diameter = 9.5, spring_diameter = 4.5, spring_length = 19, ball_extrusion_ratio = 0.20,
    springPart=true, ballPart=true, screw_distance=23)
{
    thickness = 1.0;
    gap = 0.5;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    screw_d = 2;
    connector_plate_thickness = 1;                
    plate_width = screw_distance + 2 * (screw_d + 2);

    if (draw_other_parts == true)
    {
        %translate([0, 0, ball_out])
        {
            // spring
            translate([0, 0, ball_diameter/2])
            spring(d=spring_diameter, l=spring_length);
            // ball
            color("silver") sphere(d=ball_diameter);
        }
    }

    if (springPart == true)
        {
        spring_tube_length = spring_length - ball_out - gap;
        translate([0, 0, ball_case_inner_top])
        {
            // spring tube and its bottom
            tubeD(spring_case_outer_d, spring_case_inner_d, spring_tube_length);
            translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);

            // connector plate
            difference()
            {
                translate([0, 0, connector_plate_thickness/2])
                cube([ball_case_outer_d, plate_width, connector_plate_thickness], center = true);
                translate([0,0,-0.1])
                {
                    cylinder(d=spring_case_inner_d,h=connector_plate_thickness+0.2);
                    
                    translate([0, screw_distance/2, 0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                    translate([0, -screw_distance/2, 0])
                    cylinder(d=screw_d,h=connector_plate_thickness+0.2);
                }
            }
        }
    }
    
    if (ballPart == true)
    {
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }

        // connector plate
        translate([0,0,ball_case_inner_top])
        difference()
        {
            translate([0,0,-thickness/2])
            cube([ball_case_outer_d, plate_width, thickness], center = true);
            translate([0,0,-thickness-0.1])
            {
                cylinder(d=ball_case_inner_d,h=thickness+0.2);

                translate([0, screw_distance/2, 0])
                cylinder(d=screw_d,h=thickness+0.2);
                translate([0, -screw_distance/2, 0])
                cylinder(d=screw_d,h=thickness+0.2);
            }
        }
    }
}


module BallSpringPlunger6(ball_diameter = 5.0, spring_diameter = 5.0, spring_length = 10, ball_extrusion_ratio = 0.20,
    springPart=true, ballPart=true)
{
    thickness = 1.0;
    gap = 0.4;
    ball_out = ball_extrusion_ratio * ball_diameter;
    ball_high = ball_diameter*(1-ball_extrusion_ratio) + gap;
    ball_case_inner_top = ball_diameter/2 - thickness + gap;
    ball_case_inner_d = ball_diameter + gap;
    ball_case_outer_d = ball_case_inner_d + thickness;
    spring_case_inner_d = spring_diameter + gap;
    spring_case_outer_d = spring_case_inner_d + thickness;
    spring_tube_length = spring_length + ball_diameter*(1-ball_extrusion_ratio) + gap - 1;

    if (draw_other_parts == true)
    {
        color("silver")
        translate([0, 0, ball_out])
        {
            // spring
            translate([0, 0, ball_diameter/2 * (1-ball_extrusion_ratio)])
            spring(d=spring_diameter, l=spring_length);
            // ball
            sphere(d=ball_diameter);
        }
    }

    if (springPart == true)
        {
        translate([0, 0, 0])
        {
            // spring tube and its bottom
            difference()
            {
                cylinder(d=spring_case_outer_d, h=spring_tube_length + 1);
                cylinder(d=spring_case_inner_d, h=spring_tube_length + 2);
                translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
            }
            moveZ(ball_diameter/2-1)
            {
                tubeD2(din1=ball_case_outer_d, dout1=ball_case_outer_d,
                    din2=ball_case_outer_d, dout2=ball_case_outer_d+2,
                    h=1);
            }
        }
        // ball tube
        tubeD(ball_case_outer_d, ball_case_inner_d, ball_case_inner_top);
        difference()
        {
            tubeD(ball_case_outer_d, 0, thickness);
            translate([0, 0, ball_out]) sphere(d=ball_diameter + gap);
        }
    }
    
    if (ballPart == true)
    {
        //#translate([0, 0, spring_tube_length]) tubeD(spring_case_outer_d, 2*gap, thickness);
    }
}
