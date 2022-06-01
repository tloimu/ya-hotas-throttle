$fn=100;
module Backstop(rail_height=bearing_height/2)
{
    width = base_width;
    translate([throttle_rail_o_ring_thickness, 0, 0])
    difference ()
    {
        union ()
        {
            // Back stopper
            translate ([0, -width/2, 0]) cube ([rails_stopper_width, width, 3 + case_bottom_gap]);
            translate ([0, -width/2, 0]) cube ([3, width, case_bottom_gap + rail_diameter + 7]);
        }
        
        // Rod holes
        translate ([-0.1,bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        cylinder(d1=rail_diameter + 1, d2=rail_diameter, h=1);
        translate ([0,bearing_offset, rail_height + case_bottom_gap])
        hole_teardrop(d=rail_diameter, h=rails_stopper_width + 1);
        
        translate ([-0.1,-bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        cylinder(d1=rail_diameter + 1, d2=rail_diameter, h=1);
        translate ([0,-bearing_offset, rail_height + case_bottom_gap])
        hole_teardrop(d=rail_diameter, h=rails_stopper_width + 1);
    }

    if (draw_other_parts)
    {   // O-rings to soften the stoppers
        color("black")
        translate ([0, bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        {
            tubeD(din=rail_diameter, dout= rail_diameter + throttle_rail_o_ring_thickness, h = throttle_rail_o_ring_thickness);
            moveY(-throttle_rails_width)
            tubeD(din=rail_diameter, dout= rail_diameter + throttle_rail_o_ring_thickness, h = throttle_rail_o_ring_thickness);
        }
    }
}


module FrontstopFull(lowerPart=true, rail_height=bearing_height/2)
{
    width = base_width;
    difference ()
    {
        if (lowerPart == true)
            translate ([0,-width/2,0]) cube ([rails_stopper_width, width, rail_height + case_bottom_gap]);
        else
            translate ([0,-width/2, rail_height + case_bottom_gap]) cube ([rails_stopper_width, width, rail_height]);

        // Tension gap at the center
        translate ([-1,-throttle_rails_width/2 - 5, rail_height + case_bottom_gap]) cube ([rails_stopper_width + 2, throttle_rails_width + 10, 0.6]);

        // Rod holes
        translate ([-0.5,bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        cylinder(d=rail_diameter, h=rails_stopper_width + 1);
        translate ([-0.5,-bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        cylinder(d=rail_diameter, h=rails_stopper_width + 1);

        // Screw holes
        moveX(rails_stopper_width/2)
        moveZ(case_bottom_gap)
        if (lowerPart == true)
        {
            moveY(throttle_rails_width/2 - rail_diameter - 2) cylinder(d=2.5, h=2*rail_height);
            moveY(-throttle_rails_width/2 + rail_diameter + 2) cylinder(d=2.5, h=2*rail_height);
        }
        else
        {
            moveZ(rail_height - 0.1)
            {
                moveY(throttle_rails_width/2 - rail_diameter - 2)  cylinder(d=3.5, h=2*rail_height);
                moveY(-throttle_rails_width/2 + rail_diameter + 2) cylinder(d=3.5, h=2*rail_height);
            }
        }
    }
    if (draw_other_parts)
    {   // O-rings to soften the stoppers
        color("black")
        translate ([rails_stopper_width, bearing_offset, rail_height + case_bottom_gap])
        turnY(90)
        {
            tubeD(din=rail_diameter, dout= rail_diameter + throttle_rail_o_ring_thickness, h = throttle_rail_o_ring_thickness);
            moveY(-throttle_rails_width)
            tubeD(din=rail_diameter, dout= rail_diameter + throttle_rail_o_ring_thickness, h = throttle_rail_o_ring_thickness);
        }
    }
}

module Frontstop(lowerPart=true, rail_height=bearing_height/2)
{
    translate ([-throttle_travel/2 - base_length/2 - rails_stopper_width - throttle_rail_o_ring_thickness, 0, 0])
    FrontstopFull(lowerPart=lowerPart, rail_height=rail_height);
}

module FrontstopUpperPartPrintable(rail_height=bearing_height/2)
{
    moveZ(rail_height)
    flipY()
    moveZ(-(rail_height + case_bottom_gap))
    FrontstopFull(lowerPart=false, rail_height=rail_height);
}

module Tracks(bearingPosition=0)
{
    module Rod()
    {
        color("Snow") turnY(90) cylinder (d=rail_diameter, h=rail_length);
    }
    
    translate ([-rail_length/2, bearing_offset, bearing_height/2]) Rod();
    translate ([-rail_length/2, -bearing_offset, bearing_height/2]) Rod();
}

module ThrottleAxisHolder(l=16, screw_diameter=3.5)
{
    w = screw_diameter * 3;
    difference()
    {
        union()
        {
            translate([-w/2, -6, 0]) cube([w, 6, 2]);
            translate([-w/2, 0, 0]) cube([w, 2, l + 1]);
            moveZ(2) moveX(-w/2)
            turnY(90)
            linear_extrude(w) polygon(points=[ [0, 0], [-6,0], [0,-6] ]);

            moveZ(l+1)
            moveY(2)
            turnX(90)
            cylinder(d=w, h=2);
        }
        moveZ(l)
        moveY(2.1)
        turnX(90)
        cylinder(d=screw_diameter, h=2.2);
    }    
}


module CableGuide(l=10, h=base_height + case_bottom_gap + 2, cable_diameter=3.5, connector_hole_d=6, connector_screw_d=2, draw_connector=false, draw_guide=false)
{
    connector_height = 6;
    slot_width = cable_diameter*0.8;
    slot_height = 10;
    pin_thickness = 2.5;
    pin_width = 3;
    guide_width = slot_width + 2 * pin_thickness;
    split_width = l - 2 * pin_width;
    connector_width = connector_hole_d + 2;

    if (draw_guide)
    {
        difference()
        {
            translate([0, -guide_width/2, 0]) cube([l, guide_width, h + 1]);

            moveX(-0.01)
            {
                moveZ(h - cable_diameter*0.3)
                turnY(90)
                {
                    cylinder(d=cable_diameter*0.9, h=l + 0.02); // primary slot
                    moveX(cable_diameter/2+1)
                    cylinder(d=cable_diameter*0.9, h=l + 0.02); // secondary slot
                    moveX(-cable_diameter/2-1)
                    cylinder(d=cable_diameter*1.1, h=l + 0.02); // entry rounding
                }

                moveZ(h + 1 - slot_height) moveY(-slot_width/2)
                cube([l + 0.02, slot_width, slot_height + 0.01]);

                moveZ(h + 1 - slot_height + split_width/2) moveX( (l-split_width)/2 )
                {
                    cube([split_width, guide_width, slot_height + 0.01]);
                    moveY(slot_width/2+ pin_thickness+0.01) moveX(split_width/2) turnX(90) cylinder(d=split_width, h=pin_thickness+0.02); // fillet
                }

                moveZ(h + 1 - slot_height) turnY(90) cylinder(d=slot_width, h=l + 0.02); // fillet
            }
        }

        // Cable holder part of the connector
        moveY(guide_width/2)
        difference()
        {
            s = 0.25;
            cube([l, connector_width, connector_height + s]);
            translate([(l - connector_hole_d - 2*s)/2, 1-s, -0.01])
            cube_camfered_z([connector_hole_d + 2*s, connector_hole_d + 2*s, connector_height + s + 0.02], 4);
        }
    }

    if (draw_connector)
    {
        // Connector to be printed as part where guide is to be attached to
        moveY(guide_width/2)
        difference()
        {
            translate([(l-connector_hole_d)/2, 1, 0])
            cube_camfered_z([connector_hole_d, connector_hole_d, connector_height], 4);
            translate([l/2, connector_hole_d/2+1, -0.01])
            cylinder(d=connector_screw_d, h=connector_height + 0.02); // screw hole
        }
    }
}

module Guts(test_frame=true, lowerPartOnly=true, otherParts=true)
{
    // Backstop
    translate ([throttle_travel/2 + base_length/2, 0, 0])
    Backstop();

    // Frontstop
    Frontstop(lowerPart=true);
    if (lowerPartOnly == false)
        Frontstop(lowerPart=false);

    // Throttle slider supports
    moveX(-throttle_travel/2)
    moveY(-(base_width/2 + throttle_lever_distance))
    {
        moveX(-throttle_slider_end_length)
        ThrottleAxisHolder(l=slider_height);
        moveX(throttle_travel + throttle_slider_end_length)
        ThrottleAxisHolder(l=slider_height);

        moveX(throttle_travel + throttle_slider_end_length + throttle_slider_screw_offset + 3)
        moveY(-3)
        {
            CableGuide(h=base_height + case_bottom_gap + 2, cable_diameter=cable_guide_cable_d, draw_connector=true);
        }

        if (otherParts)
        {
            color("Snow")
            translate ([-throttle_slider_screw_offset, 0, slider_height])
            turnX(-90)
            {
                SlidePotentiometer(sliderEndLength=throttle_slider_end_length,
                    sliderHeight=throttle_slider_height, leverHeight=throttle_slider_lever_height,
                    value=throttleValue, alignTop=true, alignLever=true, alignValueMax=true,
                    screwOffset=throttle_slider_screw_offset);
            }
        }
    }

    // When printing Guts as not part of the case, but a separate print then
    // include some supports and case attachments. You can basically screw the
    // whole thing onto a bottom of any large enough case.
    // When printing everything as part of the case, these are left out as the
    // bottom of the case holds everything together instead.
    guts_size = [throttle_travel + base_length,
        base_width/2 + throttle_lever_distance ];
    if (test_frame)
    {
        color("green")
        {
            translate([-guts_size.x/2, -12, 0])
            cube([guts_size.x, 24, case_bottom_gap - 1]);

            // test frame for throttle slider and cable guide
            translate([-guts_size.x/2 - 7, -guts_size.y - 6, 0])
            cube_l([17, guts_size.y, case_bottom_gap - 1], rails_stopper_width, 8);

            translate([guts_size.x/2 - 10, -guts_size.y - 6, 0])
            cube_l([17, guts_size.y, case_bottom_gap - 1], -rails_stopper_width, 8);

            // test frame for base-buttons
            *translate([-guts_size.x/2 + rails_stopper_width, 0, 0])
            cube_l([guts_size.x, case_inside.y/2 - guts_offset.y, case_bottom_gap - 1], -rails_stopper_width, -20);
        }
    }

    // Detent plate holders
    translate([-guts_size.x / 2 - rails_stopper_width, 0, 0])
    cube([rails_stopper_width, detent_plate_base_offset.y, case_bottom_gap - 1]);
    
    moveZ(case_thickness)
    translate(detent_plate_base_offset)
    {
        moveX(guts_size.x/2)
        moveY(-detent_plate_slot_size.y/2)
        moveZ(-detent_plate_base_offset.z - case_bottom_gap)
        difference()
        {
            union()
            {
                cube([rails_stopper_width, detent_plate_slot_size.y, detent_plate_base_offset.z + case_bottom_gap]);
                moveX(3.5)
                moveY((detent_plate_slot_size.y)/2)
                cylinder(d=rails_stopper_width + 2, h = detent_plate_base_offset.z + case_bottom_gap);
            }
            translate([rails_stopper_width/2, detent_plate_slot_size.y/2, detent_plate_base_offset.z])
            moveZ(3) // ???? why 3
            heatInsert_M3(screwDepth=4);
        }

        moveX(-guts_size.x/2 - rails_stopper_width)
        moveY(-detent_plate_slot_size.y/2)
        moveZ(-detent_plate_base_offset.z - case_bottom_gap)
        difference()
        {
            union()
            {
                cube([rails_stopper_width, detent_plate_slot_size.y, detent_plate_base_offset.z + case_bottom_gap]);
                moveX(3.5)
                moveY((detent_plate_slot_size.y)/2)
                cylinder(d=rails_stopper_width + 2, h = detent_plate_base_offset.z + case_bottom_gap);
            }
            translate([rails_stopper_width/2, detent_plate_slot_size.y/2, detent_plate_base_offset.z])
            moveZ(3) // ???? why 3
            heatInsert_M3(screwDepth=4);
        }
    }

    if (otherParts == true)
    {
        color("grey")
        moveX(-throttle_travel/2)
        moveY(-(base_width/2 + throttle_lever_distance))
        moveX(throttle_travel + throttle_slider_end_length + throttle_slider_screw_offset + 3)
        moveY(-3)
        CableGuide(h=base_height + case_bottom_gap + 2, cable_diameter=cable_guide_cable_d, draw_guide=true);

        translate ([0, 0, case_bottom_gap])
        Tracks(0);

        moveX(-bearing_case_length/2 - throttle_travel/2 + throttleValue * throttle_travel)
        moveZ(case_bottom_gap)
        {
            translate ([0, throttle_rails_width/2, 0]) LinearBearing(length=bearing_case_length);
            translate ([0, -throttle_rails_width/2, 0]) LinearBearing(length=bearing_case_length);
        }
    }
}
