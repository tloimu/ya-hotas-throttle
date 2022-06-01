// Rendering

throttleValue = 0.0; // Position the throttle when drawing the whole throttle unit
separation = 0; // Separation for making exploded view
drawOtherParts = false; // Whether to render non-printable parts as well in preview mode
showKnobs = false; // Whether to render all knobs as well (heavy calculation warning)
$fn = $preview ? 30 : 100;

draw_other_parts = $preview ? drawOtherParts : false;

// Throttle axis
throttle_travel = 100; // Potentiometer travel length
throttle_lever_distance = 15; // Distance of the potentiometer base from the side of the base
bearing_height = 15;
bearing_length = 45;

rail_diameter = 8;
rail_length = 168;
throttle_rails_width = 50; // [40:100]
rails_stopper_width = 7; // Width of the throttle base stoppers on the ends of the rails
throttle_rail_o_ring_thickness = 0.0; // Thickness of the O-rings on the rails at the stoppers to soften it (set to zero if not using o-rings)

// Detent plate and plunger connectivity
detent_plate_size = [12, 9, 4];
detent_plunger_d = 5.0;

// Throttle slide potentiometer size parameters
throttle_lever_width = 8.0; // Width of the potentiometer lever
throttle_lever_length = 12.3; // Length of the potentiometer lever
throttle_slider_height = 6.4;
throttle_slider_lever_height = throttle_slider_height + throttle_lever_length;
throttle_slider_end_length = 10;
throttle_slider_screw_offset = 4; // screw offset from slide pot's end
slider_height = 12; // height of the slider lever (center) from case bottom

guts_offset = [0, -5, 0]; // x, y, z offset from center for the "guts" containing the rails and throttle slider etc.

// Throttle handle shape

throttle_handle_length = 60; // The length of the center section of the handle

// Case

case_thickness = 3;
case_bottom_gap = 3; // Gap between inside case bottom and throttle base
case_depth = 5; // outer height of the bottom of the case
case_outside = [180, 140]; //[200, 155]; // Warthog Throttle = [272, 142] case = [272-plate_ends,142], ProtoV4 = [190, 140], Rhino = [224, 184] base_h=50 total_h=170
case_cover_height = 25; // outer height of the top of the case
grooveClearance = 2;

shaft_length = 31; // Length of the shaft of the handle
shaft_intrusion = 11;
shaft_outer_radius = 10;

cable_guide_cable_d = 2.5; // Diameter of the cable between case and the handle for optimized cable guide

// Detent plunger and plate

detent_ball_travel = 1.0; // target travel of the detent ball
detent_ball_top_offset = 2.3; // detent ball top offset from the seat of the plunger
detent_values = [[0.75, 0.4], [0.5, 0.8], [0.0, 0.0], [1.0, 0.0]]; // optional z-parameter is text to be printed as top-size marking text

// Base parameters

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

// Calculated parameters for ease of use

throttle_offset = throttleValue * throttle_travel - throttle_travel/2; // throttle offset from center position
detent_plate_base_offset = [0, base_width/2 + detent_plate_size.y/2, base_height + (detent_ball_top_offset - detent_ball_travel)];
detent_plate_slot_size = [ throttle_travel + 2 * base_length/2, detent_plate_size.y, case_thickness + 2.7];
