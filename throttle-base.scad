// Throttle handle base that connect the handle to the rails and case bottom

include <throttle-parameters.scad>

// Parameters

bearing_margin_side = 3;
bearing_margin_frontback = 2;
bearing_offset = 60.5 / 2 - 7.5; // 25?
bearing_radius = bearing_height / 2;
bearing_case_margin = 0.17;
bearing_case_radius = bearing_radius + bearing_case_margin;
bearing_case_length = bearing_length + 2 * bearing_case_margin;

base_top_height = 1;
base_width = 60.5 + 2 * bearing_margin_side;
base_length = 45 + 2 * bearing_margin_frontback;
base_height = bearing_height + base_top_height;
base_cavity_width = 25;

shaft_outer_radius = 10;
shaft_bolt_offsets = 20;
shaft_connector_width = 35;
shaft_connector_height = 4;

// Bearing casing for housing standard linear bearings like LM8LUU

module BearingCase()
{
    // Bearing case
    translate ([-bearing_case_margin,0,bearing_case_radius])
    rotate (a=90, v=[0,1,0])
    cylinder (r1=bearing_case_radius, r2=bearing_case_radius,
        h=bearing_case_length);
    
    // Bearing insert box
    translate ([-bearing_case_margin,-bearing_case_radius,-2])
    cube ([bearing_case_length, 2 * bearing_case_radius, bearing_case_radius + 2]);
    
    // Rod cavity
    translate ([-1 - bearing_margin_frontback, 0, bearing_radius])
    rotate (a=90, v=[0,1,0])
    cylinder (r1=5, r2=5, h=base_length + 2);    
    
    // Rod insert box
    translate ([-1 - bearing_margin_frontback, -5, -0.1])
    cube ([base_length + 2, 10, bearing_radius]);
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
        translate ([-0.1-base_length/2, -12.5,-0.1])
        cube([base_length + 0.2, base_cavity_width, base_height - base_top_height  - 2 + 0.1]);
        
        // Cable hole
        cylinder (r1=7.7, r2=7.7, h=26);
        
        // Handle mounting holes (2 x 4mm bolts with washers)
        translate ([shaft_bolt_offsets,0,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
        translate ([-shaft_bolt_offsets,0,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
    
        // Zip tie holes
        ziptie_thickness = 1.7;
        ziptie_width = 3.2;
        translate ([18.5,12,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([-21.5,12,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([18.5,-34,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([-21.5,-34,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
    }

    // Lever
    lever_rim_width = 2;
    lever_outside_width = leverWidth + 2 * lever_rim_width;
    lever_height = 3;

    translate([-lever_outside_width/2,-(base_width/2 + leverDistance + lever_rim_width),base_height-lever_height])
    difference()
    {
        cube([lever_outside_width,leverDistance + lever_rim_width,lever_height]);
        translate([lever_rim_width, lever_rim_width - 1, -0.1])
        cube([leverWidth,2,lever_height+0.2]);
    }

    // Ball Spring Plunger spring case
    // moveY(base_width/2 + 6) moveZ(33) flipY() turnZ(-90) BallSpringPlunger(); // center detent actuator
    translate([0, 2+base_width/2 + detent_ball_offset + 0.75, 12 - case_bottom + base_height + case_bottom_gap])
    flipY() turnZ(-90) BallSpringPlunger2(ballPart=false);
    *translate([0, 2+base_width/2 + 0.5, 12 - case_bottom + base_height + case_bottom_gap])
    flipY() turnZ(-90) BallSpringPlunger2(springPart=false);
}

// --------------------------
// Handle shaft and its base
// --------------------------

module ShaftAndBase(length, intrusion)
{
    difference ()
    {
        union ()
        {
            // Base box
            translate ([-base_length/2, -shaft_connector_width/2,0])
            cube([base_length,
                shaft_connector_width,
                shaft_connector_height]);

            // ???? TODO: Round the cable exit side of the base box
            
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
				cylinder (d1=30, d2=20, h=6);
            }
			
			// Handle connector cone
			translate ([0,0,length - intrusion - 10 + case_thickness])
			cylinder (d1=20, d2=30, h=7);
        }

        // Handle mounting holes (2 x 4mm bolts with washers)
        translate ([shaft_bolt_offsets,0,0]) hole (4, shaft_connector_height);
        translate ([-shaft_bolt_offsets,0,0]) hole (4, shaft_connector_height);

		// Central cable hole
        hole(14, length);

		// Side cable exit hole
        turnZ(-25) translate ([0,0,7]) rotate([110,0,0])
        {
            scale([1,1.4,1])
            hole(8, 28);
        }
    }
}
