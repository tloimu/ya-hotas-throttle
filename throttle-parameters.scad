// Rendering

throttle_value = 0.5; // Position the throttle when drawing the whole throttle unit
separation = 10; // Separation for making exploded view
drawOtherParts = true; // Whether to render non-printable parts as well in preview mode
showKnobs = true; // Whether to render all knobs as well (heavy calculation warning)
$fn = $preview ? 30 : 100;

draw_other_parts = $preview ? drawOtherParts : false;

// Throttle axis

throttle_travel = 100; // Potentiometer travel length
throttle_offset = 14 + 49/2; // Offset of the base from the center-zero
throttle_lever_distance = 7; // Distance of the potentiometer lever from the side of the base
throttle_lever_width = 8.0; // Width of the potentiometer lever
bearing_height = 15;
bearing_length = 45;

// Throtte handle shape

throttle_handle_length = 60; // The length of the center section of the handle

// Case

case_thickness = 3;
case_bottom_gap = 3; // Gap between inside case bottom and throttle base
case_depth = 17; // outer height of the bottom of the case
case_outside = [2 * throttle_offset + throttle_travel + 5, 140];
case_cover_height = 18; // outer height of the top of the case
grooveClearance = 2;

shaft_length = 31; // Length of the shaft of the handle
shaft_intrusion = 11;

detent_ball_offset = 0;
detent_values = [[0.75, 0.5], [0.5, 4]]; //[[0.7, 1.7], [0.5, 4], [0.25, 1.7]];
