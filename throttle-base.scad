// Throttle handle base that connect the handle to the rails and case bottom

include <throttle-parameters.scad>
include <throttle-case.scad>

// Parameters

bearing_margin_side = 3; // [1:5]
bearing_margin_frontback = 2;
bearing_offset = throttle_rails_width / 2;
bearing_radius = bearing_height / 2;
bearing_case_margin = 0.17;
bearing_case_radius = bearing_radius + bearing_case_margin;
bearing_case_length = bearing_length + 2 * bearing_case_margin;

base_top_height = 2; // [1:5]
base_width = 2 * (bearing_offset + bearing_margin_side + bearing_case_radius);
base_length = 45 + 2 * bearing_margin_frontback;
base_height = bearing_height + base_top_height;
base_cavity_width = 2 * (bearing_offset - bearing_margin_side - bearing_case_radius);

shaft_bolt_offsets = 18;
shaft_connector_width = 35;
shaft_connector_height = 4;
shaft_base_intrusion = shaft_connector_height;


// Bearing casing for housing standard linear bearings like LM8LUU

module BearingCase()
{
    // Bearing case
    translate ([-bearing_case_margin, 0, bearing_case_radius])
    rotate (a=90, v=[0,1,0])
    cylinder (r1=bearing_case_radius, r2=bearing_case_radius,
        h=bearing_case_length);
    
    // Bearing insert box
    translate ([-bearing_case_margin,-bearing_case_radius,-2])
    cube ([bearing_case_length, 2 * bearing_case_radius, bearing_case_radius + 2]);
    
    front_cavity_radius = bearing_case_radius - 0.7;
    // Rod cavity
    translate ([-1 - bearing_margin_frontback, 0, bearing_radius])
    rotate (a=90, v=[0,1,0])
    cylinder (r1=front_cavity_radius, r2=5, h=base_length + 2);    
    
    // Rod insert box
    translate ([-1 - bearing_margin_frontback, -5, -0.1])
    cube ([base_length + 2, 10, bearing_radius]);
    translate ([-bearing_margin_frontback-0.1, -front_cavity_radius, -0.1])
    conical_cube ([bearing_margin_frontback, 2*front_cavity_radius, bearing_radius], 0.91);

    // Zip tie holes
    ziptie_thickness = 1.7;
    ziptie_width = 3.2;
    translate([0, -bearing_case_radius*2, 2.5])
    {
        moveX(1) cube ([ziptie_width, bearing_case_radius*4, ziptie_thickness]);
        moveX(bearing_length - ziptie_width - 1) cube ([ziptie_width, bearing_case_radius*4, ziptie_thickness]);
    }
}

// --------------------------
// Handle shaft and its base
// --------------------------

module BaseConnector()
{
    translate ([-base_length/2, 0,0])
    {
        moveY(-shaft_connector_width/2)
        conical_cube([base_length-2,
            shaft_connector_width,
            shaft_connector_height], 1.15);
    }
}

module ShaftAndBase(length, intrusion)
{
    moveZ(-shaft_base_intrusion)
    difference ()
    {
        union ()
        {
            BaseConnector();
            
			// Shaft tubes
            tube (shaft_outer_radius-2, length, 1);
            tube (shaft_outer_radius, length, 1);
			
			// Shaft supports
			translate ([-1.5,9,0])
			rotate ([90,0,0])
			cube ([3,length, 18]);
			translate ([-9,-1.5,0])
			rotate ([90,0,90])
			cube ([3,length, 18]);
			
			// Shaft base support cone
            translate([0,0,shaft_connector_height])
            difference ()
            {
				cylinder (d1=30, d2=20, h=4);
            }
			
			// Handle connector cone
			translate ([0,0,length - intrusion - 12 + case_thickness])
			cylinder (d1=20, d2=30, h=6);
        }

        // Handle mounting holes (2 x 4mm bolts with washers)
        translate ([shaft_bolt_offsets,0,0]) hole (4, shaft_connector_height);
        translate ([-shaft_bolt_offsets,0,0]) hole (4, shaft_connector_height);

		// Central cable hole
        hole(14, length);

		// Side cable exit hole
        turnZ(180-35) translate ([0,0,9]) rotate([100,0,0])
        {
            scale([1,1,1])
            hole(7, 14.4);
            translate([-2.5, -10, 5])
            cube([5, 10, 20]);
        }
    }
}

// The printed part of the base

module BasePrinted(leverDistance=18, leverWidth=8.0, shaftConnectorWidth, shaftConnectorThickness=3.0)
{
    difference ()
    {
        // Main base box
        translate ([-base_length/2, -base_width/2,0])
        cube([base_length,
            base_width,
            base_height]);

        // Right bearing case
        translate ([-base_length/2 + bearing_margin_frontback, bearing_offset,0])
        BearingCase();

        // Left bearing case
        translate ([-base_length/2 + bearing_margin_frontback, -bearing_offset,0])
        BearingCase();
        
        // Center cavity
        translate ([-0.1-base_length/2, -base_cavity_width/2,-0.1])
        cube([base_length + 0.2, base_cavity_width, base_height - 2 * shaft_base_intrusion + 0.1]);
        
        // Handle mounting holes (2 x 4mm bolts with washers)
        translate ([shaft_bolt_offsets,0,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
        translate ([-shaft_bolt_offsets,0,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);

        translate([0, 0, base_height - shaft_base_intrusion + 0.1])
        BaseConnector();
    }
    moveZ(slider_height - case_bottom_gap)
    LeverModule();

    moveY(base_width/2) moveZ(base_height - case_bottom_gap)
    DetentPlungerModule();
}

module LeverModule(leverDistance=15, leverWidthReal=8.0)
{
    gap = 0.5;
    leverWidth = leverWidthReal + gap;
    lever_rim_width = 1.5;
    lever_outside_width = leverWidth + 2 * lever_rim_width;
    lever_groove_height = 1.8;
    lever_holder_height = 4;

    translate([-lever_outside_width/2,-(base_width/2), -lever_holder_height/2])
    {
        difference()
        {
            turnX(90)
            conical_cubep([1.5*lever_outside_width, lever_holder_height], [lever_outside_width, lever_holder_height], 8, [0, 0]);
            translate([(lever_outside_width - leverWidth)/2, -leverDistance, (lever_holder_height-lever_groove_height)/2])
            cube([leverWidth, throttle_lever_length + 2.7, lever_groove_height]);
        }

        // Add some spheres to tighten the fit to avoid any "play" with the slider lever and the base
        moveZ(1)
        moveX(lever_outside_width/2)
        moveY(-leverDistance/2 + 1)
        turnX(90)
        {
            sphere(d=1.3);
            moveY(lever_groove_height+0.3)
            sphere(d=1.3);
        }
    }
}


module DetentPlungerModule()
{
    plate_size = [28, 12, 3];
    screw_d = 2;
    screw_offset = 11;
    plunger_d = 6.5;
    translate([-plate_size.x/2, 0, -plate_size.z + 3])
    {
        difference()
        {
            moveZ(plate_size.z)
            turnX(-90)
            conical_cubep([plate_size.x + plate_size.y/1.3, plate_size.z], [plate_size.x, plate_size.z], plate_size.y, [0, 0]);

            translate([plate_size.x/2 - screw_offset, plate_size.y/2, -0.1])
            cylinder(d=screw_d, h=plate_size.z+0.2);
            translate([plate_size.x/2 + screw_offset, plate_size.y/2, -0.1])
            cylinder(d=screw_d, h=plate_size.z+0.2);

            translate([plate_size.x/2, plate_size.y/2, -0.1])
            cylinder(d=plunger_d, h=plate_size.z+0.2);
        }
    }

}
module DetentPlungerModuleOLD()
{
    // Ball Spring Plunger spring case
    // moveY(base_width/2 + 6) moveZ(33) flipY() turnZ(-90) BallSpringPlunger(); // center detent actuator
    translate([0, 2+base_width/2 + detent_ball_offset + 0.75, 12 - case_bottom + base_height + case_bottom_gap])
    flipY() turnZ(-90) BallSpringPlunger3(ballPart=false, springPart=true);
    if (draw_other_parts)
    {
        *translate([0, 2+base_width/2 + detent_ball_offset + 0.75, 12 - case_bottom + base_height + case_bottom_gap])
        flipY() turnZ(-90) BallSpringPlunger3(ballPart=false, slotPart=false);
        *translate([0, 2+base_width/2 + 0.5, 12 - case_bottom + base_height + case_bottom_gap])
        flipY() turnZ(-90) BallSpringPlunger3(springPart=false, slotPart=false);
    }
}