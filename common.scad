// Common utilities for building stuff

module flipX() { rotate([180,0,0]) children(); }
module flipY() { rotate([0,180,0]) children(); }
module flipZ() { rotate([0,0,180]) children(); }
module turnX(a) { rotate([a,0,0]) children(); }
module turnY(a) { rotate([0,a,0]) children(); }
module turnZ(a) { rotate([0,0,a]) children(); }
module moveX(l) { translate([l,0,0]) children(); }
module moveY(l) { translate([0,l,0]) children(); }
module moveZ(l) { translate([0,0,l]) children(); }

module sheet_cone(x, y1, y2, h)
{
	points = [[0,0,0],  [0,y1,0],  [0,y1/2+y2/2,h],  [0,y1/2-y2/2,h],
			  [x,0,0], [x,y1,0], [x,y1/2+y2/2,h], [x,y1/2-y2/2,h]];
	faces = [[0,1,2,3],  // bottom
			[4,5,1,0],  // front
			[7,6,5,4],  // top
			[5,6,2,1],  // right
			[6,7,3,2],  // back
			[7,4,0,3]];
	polyhedron(points=points, faces=faces, convexity=10);
}

module tube(radius, length, thickness)
{
    difference ()
    {
        cylinder (r=radius,h=length);
        translate ([0,0,-1])
        cylinder (r=radius-thickness,h=length + 2);
    }
}

module tubeD(dout, din, h)
{
    difference ()
    {
        cylinder (d=dout,h=h);
        translate ([0,0,-1])
        cylinder (d=din,h=h + 2);
    }
}

module tubeD2(dout1, din1, dout2, din2, h)
{
    difference ()
    {
        cylinder (d1=dout1, d2=dout2, h=h);
        translate ([0,0,-1])
        cylinder (d1=din1, d2=din2, h=h + 2);
    }
}


module washer(out, in, h)
{
    difference ()
    {
        cylinder (d=out,h=h);
        translate ([0,0,-1])
        cylinder (d=in-h,h=h + 2);
    }
}

module hole(diameter, length)
{
    translate ([0,0,-1])
    cylinder (r1=diameter/2, r2=diameter/2, h=length + 2);
}

module cube_inside(size, thickness)
{
	translate ([thickness, thickness, thickness])
	cube ([size[0] - thickness*2, size[1] - thickness*2, size[2] - thickness*2]);
}

module DetentPotSpring(dShaft= 9.5, dBolt = 14.5, length = 6, contactLength = 2)
{
	dOut = dBolt + 2.2;
	hull()
	{
		translate([0,dBolt/2+0.4,-contactLength])
		{
			translate([0,0.58,0])
			cylinder(d=1.2, h=contactLength);
		}
		translate([0,dBolt/2+0.6,-contactLength - 1])
		cylinder(d=1.2, h = contactLength + 1);
	}
	// Spring shaft
	difference()
	{
		translate([0,dBolt/2+0.6,-length - contactLength - 0.5])
		cylinder(d=1.2, h = length + contactLength - 0.5);

		translate([0,0,-length - contactLength + 0.2])
		cylinder(d=dBolt, h=4); // bolt
	}

	washerThickness = 0.7;

	// Mounting washer with surface ripples for better grip
	translate([0,0,-length - contactLength - 0.5])
	difference()
	{
		tubeD(dOut, dShaft, washerThickness);

		for (a = [100:15:440])
		{
			translate([0,0,-1.2])
			rotate([45,0,a+7])
			cube([dBolt/2+2,1,1]);
			translate([0,0,0.5])
			rotate([45,0,a])
			cube([dBolt/2+2,1,1]);
		}
	}
}

// Kobs and knob holes (D/T)
module Knob(d1, d2, length, skirt=5, detent = false)
{
	aargh = true;
	difference()
	{
		union()
	{
	// Pot shaft holder
	translate([0,0,0])
	cylinder (d1=d2, d2=d2, h=length);

	// Outer shell
	difference ()
	{
		cylinder (d1=d1, d2=d2, h=length);
		translate([0,0,-1])
		cylinder (d1=d1-1.5, d2=d2-1.5, h=length-2);
	}

	// Skirt and detent
	translate([0,0,-skirt])
	{
		tube (d1/2, skirt, 1);

		if (detent == true)
		{
			translate([-1,d1/2-1,0])
			cylinder(d=1.5, h=skirt);
			translate([1,d1/2-1,0])
			cylinder(d=1.5, h=skirt);
		}
	}

	for (a = [40:40:360])
	{
		if (aargh == true)
		{
			rotate([0,0,a])
			rotate([90,2,0])
			translate([-5.7,-2.4,0])
			rotate_extrude(angle=60,convexity = 10)
			translate([15.7, 0, 0])
			circle(r = 0.55);
		}
		else
		{
			rotate([0,0,a])
			rotate([90,-9,0])
			translate([-16.9+6.2,-1.2,0])
			rotate_extrude(angle=33,convexity = 10)
			translate([20, 0, 0])
			circle(r = 0.5);
		}
	}
	
	for (a = [20:40:360])
	{
		if (aargh == true)
		{
			rotate([0,0,a])
			rotate([90,-2,0])
			translate([-13.8,-3,0])
			rotate_extrude(angle=41,convexity = 10)
			translate([23.5, 0, 0])
			circle(r = 0.55);
		}
		else
		{
			rotate([0,0,a])
			rotate([90,-9.1,0])
			translate([-16.75,-1.27,0])
			rotate_extrude(angle=30.5,convexity = 10)
			translate([26, 0, 0])
			circle(r = 0.5);
		}
	}
	}
	translate([-15,-15,-20-skirt])
	cube([30,30,20]);
	}
}

module KnobHoleD(diameter = 6, length = 12)
{
	actualD = diameter + 0.2;
	difference ()
	{
		cylinder (d1=actualD, d2=actualD, h=length);
		translate ([actualD / 2 - 1.4,-5,-1])
		cube ([10,10,length + 2]);
		
		// Tightening dips
		for (a = [-1.8:3.6:1.8])
		{
			rotate([0,0,180])
			translate([-7.6,a,5])
			rotate([90,45,0])
			rotate_extrude(angle=90,convexity = 10)
			translate([diameter-0.1, 0, 0])
			circle(r = 0.4);
		}
	}
}

module KnobHoleT(diameter = 6.3, lengthNoSkirt = 12, skirt = 1)
{
	actualD = diameter + 0.2;
	length = lengthNoSkirt + skirt;
	difference ()
	{
		cylinder (d1=actualD, d2=actualD, h=length);
		translate ([-0.6,-actualD,length - 1.8])
		cube ([1.2,2*actualD,2.5]);
		
		// Tightening dips
		translate ([0,0,skirt])
		for (a = [45:90:360])
		{
			rotate([0,0,90 + a])
			translate([-9.4,0,4])
			rotate([90,45,0])
			rotate_extrude(angle=90,convexity = 10)
			translate([diameter-0.1, 0, 0])
			circle(r = 0.4);
		}
	}
}

module KnobT(d1, d2, length, skirt=1, detent=false)
{
	difference ()
	{
		Knob(d1, d2, length, skirt, detent);
		translate ([0,0,-0.2-skirt])
		KnobHoleT(6.4, 12.2, skirt);
	}
}

module KnobD(d1, d2, length)
{
	difference ()
	{
		Knob(d1, d2, length);
		translate ([0,0,-0.2])
		KnobHoleD(6, length=12.2);
	}
}

module ScrewCavity3m(thruDepth, capDepth = 20, capDiameter = 7, thruDiameter = 3.2, thickness=2)
{
	translate([0,0,thruDepth])
	cylinder (d1=capDiameter, d2=capDiameter, h=capDepth);
	translate([0,0,-thickness])
	cylinder (d1=thruDiameter, d2=thruDiameter, h=thruDepth+thickness*2);
}

module ScrewThreadSupport3m(length, angle = [0,0,0])
{
	difference()
	{
		translate([0,0,-length])
		tube (3, length, 1.8);

		rotate(angle)
		translate([-5, -5, 0])
		cube ([10,10,10]);
	}
}

module ScrewEntrySupport3m(thruDepth, capDepth = 20, capDiameter = 7, thickness=2, thruDiameter = 3.2)
{
	translate([0,0,thruDepth-thickness])
	cylinder (d1=capDiameter+thickness, d2=capDiameter+thickness, h=capDepth-thickness);

	translate([0,0,-10])
	cylinder (d1=thruDiameter+thickness, d2=thruDiameter+thickness, h=capDepth-thickness);
}

module Switch()
{
	color("black")
	translate ([-3,-3,-4])
	cube([6,6,3]);

	color("yellow")
	translate ([0,0,-1])
	cylinder(d=3.2,h=1);

	r = 2.54;
	w = 0.8;
	wire_height = 4;
	d = 3 * r / 2;
	color("white")
	translate([-w/2,-w/2,-4-wire_height])
	{
		translate ([-d,-r,wire_height+1]) cube([2*w,w,1]);
		translate ([-d,-r,0]) cube([w,w,wire_height + 1]);

		translate ([d-w,-r,wire_height+1]) cube([2*w,w,1]);
		translate ([d,-r,0]) cube([w,w,wire_height + 1]);

		translate ([-d,r,wire_height+1]) cube([2*w,w,1]);
		translate ([-d,r,0]) cube([w,w,wire_height + 1]);

		translate ([d-w,r,wire_height+1]) cube([2*w,w,1]);
		translate ([d,r,0]) cube([w,w,wire_height + 1]);
	}
}

module SwitchButton(d=8, h=7, cavityOnly=false)
{
	if (cavityOnly == false)
	{
		difference()
		{
			union ()
			{
				intersection()
				{
					translate([0,0,-0.8])
					cylinder(d=d, h=h+0.8);
					translate([0,0,1.6])
					sphere(r=h-0.7);
				}
				translate([0,0,-1])
				cylinder(d=d+1.6, h=0.8);
			}
			translate([0,0,-2])
			cylinder(d=d-1, h=h);
		}

		translate([0,0,-1.4])
		tube(radius=2, length=h, thickness=1);
	}
	else
	{
		translate([0,0,-0.5])
		{
			cylinder(d=d, h=10);
		}
	}
}

SwitchButtonBallOffsetZ = 1.2;
module SwitchButtonBall(d=8, h=7)
{
	difference()
	{
		union ()
		{
			intersection()
			{
				translate([0,0,-1.2])
				cylinder(d=d, h=h+0.8);
				union()
				{
					translate([0,0,h - 4])
					sphere(d=d);
					translate([0,0,6-d])
					cylinder(d=d, h=h-2);
				}
			}
			translate([0,0,-1.2])
			cylinder(d=d+1.6, h=1.2);
		}
		translate([0,0,-d/2])
		cylinder(d=d-1, h=h);
		translate([0,0,-1.25])
		cylinder(d1=d+0.8, d2=d-1, h=1);

		// Top inner cavity
		translate([0,0,h - 4])
		sphere(d=d-1);
	}

	// Center shaft
	translate([0,0,-1.2])
	cylinder(d=2.4,h=h+0.6);
}


module SwitchButtonSpring()
{

}

// Hat Switch with 4 directions and center push with 2x2x2mm shaft
// and a case and a knob for it.

module Hat5Switch()
{
	{
		// Slot for the hat switch
		color("grey")
		intersection()
		{
			translate([-4.3,-4.3,0])
			cube ([8.6, 8.6, 3]);

			rotate([0,0,45])
			translate([-4,-4,0])
			cube ([8, 8, 1.8]);
		}
		color("grey")
		translate([0,0,1.8]) cylinder (d1=4.3, d2=3.3, h=0.2);

		color("black")
		{
			// Shaft and base
			translate([-1,-1,2])
			cube ([2, 2, 3]);
			translate([0,0,1.8]) cylinder (d1=3, d2=3, h=0.3);

			// Dimples
			translate([-2.5,-2.5,1.8]) cylinder (d=0.7, h=0.2);
			translate([2.5,2.5,1.8]) cylinder (d=0.7, h=0.2);
			translate([2.5,-2.5,1.8]) cylinder (d=0.7, h=0.2);
			translate([-2.5,2.5,1.8]) cylinder (d=0.7, h=0.2);
		}
	}
	// Soldering pads
	color("white")
	rotate([0,0,45])
	{
		translate([-2,-4.2,-0.2]) cube ([4, 1, 1]);
		translate([-2,4.2-1,-0.2]) cube ([4, 1, 1]);
	}
}

// Printing: Use layer height 0.15

module Hat5Case()
{
	switch_height = 2.0;
	difference()
	{
		// Outer casing
		case_height = 1.5 + switch_height;
		union ()
		{
			rotate([0,0,45])
			translate([-5.5, -6.5, 0])
			cube ([11, 13, case_height]);
		}

		// Slot for the hat switch
		intersection()
		{
			translate([-4.3,-4.3,-0.1])
			cube ([8.6, 8.6, 3]);

			rotate([0,0,45])
			translate([-4,-4,-0.1])
			cube ([8, 8, switch_height+0.1]);
		}

		Hat5CaseWireHoles();

		// Dimple groove
		rotate([0,0,-45])
		translate([-0.55,-3,1])
		cube ([1.1, 6, 5]);
	}
}

module Hat5CaseTop(height = 0.6)
{
	{
		rotate([0,0,45])
		difference()
		{
			union ()
			{
				translate([-5.5, -6.5, 0])
				cube ([11, 13, height]);

				rotate([0,0,-45])
				{
				translate([-4, -1.3, height])
				cube ([8, 2.6, 0.4]);

				translate([-1.3, -4, height])
				cube ([2.6, 8, 0.4]);
				}
			}

		translate([0, 0, height-0.7])
		cylinder (d1=7, d2=5.5, h=1.11);
		translate([0, 0, -0.69])
		cylinder (d1=9.5, d2=7, h=height);
		}
	}
}


module Hat5CaseWireHoles()
{
	rotate([0,0,45])
	translate([-2.5,2,-3])
	cube ([5, 3, 13]);

	rotate([0,0,45])
	translate([-2.5,-5,-3])
	cube ([5, 3, 13]);
}

module Hat5Shaft(height = 2)
{
	top_h = height + 2;
	h = height + 2.5 + 1.5 + 2 + 2.5;
	cavity_tolerance = 0.4; // depends on how well the printer does the cavity

	translate([0,0,h])
	{
		difference ()
		{
			union()
			{
				translate([-2,-2,-4])
				cube ([4, 4, 1]);
				rotate([0,0,45])
				translate([0,0,-3])
				cylinder (d1=4*1.42, d2=5, h=0.4,$fn=4);

				translate([0,0,-h])
				difference()
				{
					cylinder (d=5,h=h-5);

					translate([-0.95,-0.95,-0.1])
					cube ([1.9, 1.9, 2.2 + cavity_tolerance]);
				}
				translate([0,0,-5])
				cylinder (d1=5,d2=5.7,h=1);
			}
		translate([0,0,-5.6])
		cylinder (d=1.8,h=3.2);
		}
	}
}

module Hat5Shaft1(height = 2)
{
	top_h = 5;
	h = height + 2.5 + 1.5 + 2 + 2.5;
	cavity_tolerance = 0.5; // depends on how well the printer does the cavity

	translate([0,0,h])
	{
		difference ()
		{
			union()
			{
				translate([0,0,-(2.5 + 1.5 + 2)])
				cylinder (d1=5, d2=6.5,h=2);

				translate([-2,-2,-4])
				cube ([4, 4, 1.5]);

				translate([0,0,-h])
				difference()
				{
					union()
					{
						cylinder (d=5,h=h-top_h);

						translate([0,0,0.3])
						cylinder (d1=9, d2=5, h=0.7);
						cylinder (d1=9, d2=9, h=0.3);
					}

					translate([-0.95,-0.95,-0.1])
					cube ([1.9, 1.9, 2.3 + cavity_tolerance]);
				}
			}
		translate([0,0,-4.5-height])
		cylinder (d=2,h=8+height);
		}
	}
}


module Hat5Knob(width = 9, step_multiplier=3.5)
{
	difference()
	{
		translate([0,0,1])
		{
			for (z = [0.4:0.4:1.6])
			{
				s = width - z*step_multiplier;
				minkowski()
				{
					translate([-s/2, -s/2,z-0.4])
					cube ([s, s, z + 1]);
					cylinder(d=6-z*2,h=0.01);
				}
			}
		}

	translate([0,0,0])
	cylinder (d=2.1,h=8);
	translate([0,0,2.29])
	rotate([0,0,0])
	cylinder (d1=3.7,d2=2.1,h=0.8);
	translate([0,0,3.8])
	cylinder (d=3.7,h=2);

	rotate([0,0,45])
	translate([0,0,1.989])
	cylinder (d1=4.2*1.42, d2=5, h=0.4,$fn=4);
	translate([-2.1,-2.1,0.99])
	cube ([4.2, 4.2, 1]);
	}
}


module Hat5KnobComplete(shaft_length = 3, width = 9, step_multiplier=3.5)
{
	translate([0,0,1])
	{
		for (z = [0.4:0.4:1.6])
		{
			s = width - z*step_multiplier;
			minkowski()
			{
				translate([-s/2, -s/2,z])
				cube ([s, s, z + 1]);
				cylinder(d=6-z*2,h=0.01);
			}
		}
	}

	translate([0,0,-0.5])
	cylinder (d1=5, d2=12,h=2);
	
	translate([0,0,-shaft_length])
	difference()
	{
		cylinder (d=5,h=shaft_length);

		translate([-0.95,-0.95,-0.1])
		cube ([1.9, 1.9, 2.2]);
	}
}

// Circuit Board with inch (2.54mm) raster.
// Define either polygon points or a square in millimeter (x,y) or full pins (px, py).
// Use of square holes is faster to render.
module CircuitBoard(
	points = [],
	x = 0, y = 0,
	h = 1.6,
	px = 0, py = 0,
	raster = 2.54, rasterOffset = [0, 0])
{
	if (len(points) > 0)
	{
		CircuitBoardPoly(points, h, raster, rasterOffset);
	}
	else if (px > 0 && py > 0)
	{
		x = px * 2.54;
		y = py * 2.54;
		poly = [ [0,0], [x,0], [x,y], [0,y] ];
		CircuitBoardPoly(poly, h, raster, rasterOffset);
	}
	else if (x > 0 && y > 0)
	{
		poly = [ [0,0], [x,0], [x,y], [0,y] ];
		CircuitBoardPoly(poly, h, raster, rasterOffset);
	}
}

function minAt(m, i) = min([ for (c = m) c[i] ]);
function maxAt(m, i) = max([ for (c = m) c[i] ]);

module CircuitBoardPoly(poly, h, raster = 2.54, , rasterOffset = [0, 0], use_square_holes = true)
{
	min_x = minAt(poly, 0) + rasterOffset[0];
	max_x = maxAt(poly, 0) + rasterOffset[0];
	min_y = minAt(poly, 1) + rasterOffset[1];
	max_y = maxAt(poly, 1) + rasterOffset[1];
	color("orange")
	difference()
	{
		union()
		{
			linear_extrude(height=h)
			polygon(poly);
		}
		for (pin_y = [min_y:raster:max_y])
		{
			for (pin_x = [min_x:raster:max_x])
			{
				if (use_square_holes == true)
				{
					translate([pin_x-0.5,pin_y-0.5,-0.1])
					cube([1, 1, h+0.2]);
				}
				else
				{
					translate([pin_x,pin_y,-0.1]) cylinder(d=1, h=h+0.2);
				}
			}
		}
	}
}

// A flat pin (1.0 x 0.2) with inwards moving connecting hook. Turn around with <d>
module PinFlat(h=3.5,d=0,overshoot=0.4,text="")
{
	thickness = 0.2;
	rotate([0,0,d])
	{
		translate([-0.5,-thickness,-overshoot]) cube([1,thickness,h + overshoot]);
		translate([-0.5,-1,-overshoot]) cube([1,1,thickness]);
		if (text != "")
		translate([0,-0.1,-overshoot])
			rotate([180,0,0])
			linear_extrude(height = 0.2)
			text(text,size=0.5,halign="center");
	}
}


module KnurledShaftCavity(d, h, c = 18, includeT=true, tolerance=0.25)
{
    difference()
    {
        rotate([0,0,180/c])
        cylinder(d=d+tolerance, h=h, $fn=c);
        if (includeT == true)
        {
            tWidth = 1;
            translate([0,0,h-0.3])
            cube([d*1.5,tWidth,tWidth], center=true);
        }
    }
}

module spring(d,l)
{
	%cylinder(d=d, h=l);
}

module cutRectRimZ(x, y, thickness, tolerance=0.0)
{
	difference()
	{
		translate([-thickness, -thickness, -0.1])
		cube([x + thickness * 2, y + thickness * 2, thickness + 0.2]);

		translate([tolerance, tolerance, -1])
		cube([x ,y, thickness + 2]);
	}
}

module roundCube(d=3, size=[1, 1, 1], offset=[0, 0, 0], extended=0)
{
	intersection()
	{
		children();
		size2 = [size.x - 2*d + offset.x, size.y - 2*d + offset.y, size.z - 2*d + offset.z];
		minkowski()
		{
			translate(-offset) translate([d, d, d]) cube(size2);
			sphere(d + extended, $fn=50);
		}
	}
}
