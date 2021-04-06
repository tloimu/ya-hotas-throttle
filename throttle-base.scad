// Throttle handle base that connect the handle to the rails and case bottom

// Parameters

bearing_margin_side = 3;
bearing_margin_frontback = 2;
bearing_offset = 60.5 / 2 - 7.5;
bearing_height = 15;
bearing_length = 45;
bearing_radius = 7.5;
bearing_case_margin = 0.17;
bearing_case_radius = bearing_radius + bearing_case_margin;
bearing_case_length = 45 + 2 * bearing_case_margin;

base_top_height = 5;
base_width = 60.5 + 2 * bearing_margin_side;
base_length = 45 + 2 * bearing_margin_frontback;
base_height = bearing_height + base_top_height;

shaft_outer_radius = 10;

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
    translate ([-1 - bearing_margin_frontback,-5 , 0])
    cube ([base_length + 2, 10, bearing_radius]);
}

// The printed part of the base

module BasePrinted()
{
    // Base
    difference ()
    {
        // Main base box
        translate ([-base_length/2, -base_width/2,0])
        cube([base_length,
            base_width,
            base_height]);

        // Left bearing case
        translate ([-base_length/2 + bearing_margin_frontback, bearing_offset,0]) BearingCase();

        // Right bearing case
        translate ([-base_length/2 + bearing_margin_frontback, -bearing_offset,0]) BearingCase();
        
        // Center cavity
        translate ([-1-base_length/2, -12.5,-1])
        cube([base_length + 2,
            25,
            16]);
        
        // Cable hole and its edge softening
        cylinder (r1=7.7, r2=7.7, h=26);
        translate ([0,0,base_top_height + 3])
        cylinder(r1=10,r2=7, h=13);
        translate ([0,0,base_top_height + 6])
        cylinder(r1=12,r2=7, h=7);
        
        // Handle mounting holes (4 x 4mm bolts with washers)
        translate ([18,8,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
        translate ([18,-8,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
        translate ([-18,8,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
        translate ([-18,-8,0]) cylinder (r1=2, r2=2, h=bearing_height + base_top_height + 1);
    
        // Lever nut and bolt grooves
        translate ([-20,27,15]) cube ([15,7,3.2]);
        translate ([0,27,15]) cube ([15,7,3.2]);
        translate ([-20,29,13.8]) cube ([15,2.5,10]);
        translate ([0,29,13.8]) cube ([15,2.5,10]);
        
        // Zip tie holes
        ziptie_thickness = 1.7;
        ziptie_width = 3.2;
        translate ([18.5,12,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([-21.5,12,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([18.5,-34,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
        translate ([-21.5,-34,2.5]) cube ([ziptie_width, 22, ziptie_thickness]);
    }
}

main_throttle_lever_height = 8;
module MainThrottleLever()
{
    // Lever base
    difference ()
    {
        translate ([-2,0,-2]) cube ([32, 2, 2 + main_throttle_lever_height]);
        
        // Screw holes
        translate ([3,3,4.5])
        rotate (a=90, v=[1,0,0])
        cylinder (r1=1.6, r2=1.6, h=5);
        
        translate ([23,3,4.5])
        rotate (a=90, v=[1,0,0])
        cylinder (r1=1.6, r2=1.6, h=5);
    }
    // Lever
    lever_slot_distance = 18;
    translate([-1.5,0,0])
        {
        translate ([8,0,5]) cube ([6, lever_slot_distance - 3, 3]);
        difference ()
        {
        translate ([5,lever_slot_distance-3,5]) cube ([12, 6, 3]);
        translate ([7.1,lever_slot_distance-1.4,3]) cube ([7.8, 2.5, 6]);
        }
    }
}

// --------------------------
// Handle shaft and its base
// --------------------------

module ShaftAndBase(length, intrusion, handle_base_height = 5, handle_base_width = 40)
{
    difference ()
    {
        union ()
        {
            // Base box
            translate ([-base_length/2, -handle_base_width/2,0])
            cube([base_length,
                handle_base_width,
                handle_base_height]);

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
            translate([0,0,handle_base_height])
            difference ()
            {
				cylinder (d1=30, d2=20, h=8);
            }
			
			// Handle connector cone
			translate ([0,0,length-intrusion-7-7.3])
			cylinder (d1=20, d2=30, h=7);
        }

        // Handle mounting holes (4 x 4mm bolts with washers)
        translate ([18,8,0]) hole (4, handle_base_height);
        translate ([18,-8,0]) hole (4, handle_base_height);
        translate ([-18,8,0]) hole (4, handle_base_height);
        translate ([-18,-8,0]) hole (4, handle_base_height);

		// Central cable hole
        hole(14, length);

		// Side cable exit hole
        translate ([0,0,16])  rotate([115,0,0]) hole(6, 18);
    }
}

// --------------------------
// Throttle axis holders
// --------------------------

ThrottleAxisHolderOffsetX = 3;
module ThrottleAxisHolder()
{
	difference()
	{
		translate ([-ThrottleAxisHolderOffsetX,3.5,12])
		cube ([18,8,2]);
		translate([13-2.5,3.5+4,1])
		cylinder(d=3.5,h=20);
	}
	difference(convexity=10)
	{
		translate([-ThrottleAxisHolderOffsetX,-1.5,0])
		sheet_cone(x=7, y1=18, y2=8, h=12);

		translate([0.5,14,3])
		cylinder(d=5,h=20);
		translate([0.5,14,-3])
		cylinder(d=2.5,h=20);

		translate([0.5,1,3])
		cylinder(d=5,h=20);
		translate([0.5,1,-3])
		cylinder(d=2.5,h=20);
	}
}

