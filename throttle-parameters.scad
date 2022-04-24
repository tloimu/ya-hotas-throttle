// Rendering

throttleValue = 1.0; // Position the throttle when drawing the whole throttle unit
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

// Throttle slide potentiometer size parameters
throttle_lever_width = 8.0; // Width of the potentiometer lever
throttle_lever_length = 12.3; // Length of the potentiometer lever
throttle_slider_height = 6.4;
throttle_slider_lever_height = throttle_slider_height + throttle_lever_length;
throttle_slider_end_length = 10;
throttle_slider_screw_offset = 4; // screw offset from slide pot's end
slider_height = 12; // height of the slider lever (center) from case bottom

guts_offset = [0, -12, 0]; // x, y, z offset from center for the "guts" containing the rails and throttle slider etc.

// Throttle handle shape

throttle_handle_length = 60; // The length of the center section of the handle

// Case

case_thickness = 3;
case_bottom_gap = 3; // Gap between inside case bottom and throttle base
case_depth = 20; // outer height of the bottom of the case
case_outside = [200, 155]; // Warthog Throttle = [272, 142] case = [272-plate_ends,142], ProtoV4 = [190, 140], Rhino = [224, 184] base_h=50 total_h=170
case_cover_height = 10; // outer height of the top of the case
grooveClearance = 2;

shaft_length = 31; // Length of the shaft of the handle
shaft_intrusion = 11;
shaft_outer_radius = 10;

detent_ball_offset = 0;
detent_values = [[0.75, 0.1], [0.5, 1.0]];

// Calcualted parameters for ease of use

throttle_offset = throttleValue * throttle_travel - throttle_travel/2; // throttle offset from center position
