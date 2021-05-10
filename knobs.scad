include <common.scad>;
include <throttle-parameters.scad>;

// Recommend 0.20mm layer on 0.4mm nozzle
module hatKnob()
{
    width = 9;
    step_multiplier = 3.5;
    translate([0,0,-(6-2*1.6-0.2)])
	difference()
	{
        union()
		{
			for (z = [0.6:0.2:1.6])
			{
				s = width - z*step_multiplier;
				minkowski()
				{
					translate([-s/2, -s/2,z-0.6])
					cube ([s, s, z]);
					cylinder(d=6-z*2,h=0.01);
				}
			}

            translate([0,0,-4.8])
            cylinder (d1=3.7, d2=5,h=4.8);
		}

        difference()
        {
            translate([0,0,-4.8 - 0.01])
            cylinder (d=2.5,h=4.8);

            rotate([0,0,45])
            translate([1.1-0.6,-1.5,-3.6])
            cube([3,3,3.6]);
        }
	}
}

// Kobs and knob holes (D/T)
module PotKnobD(d1, d2, length, skirt=5, detent = false, testDetent = false)
{
    shaftD = 6.4;
    difference()
    {
    union()
    {
        // Pot shaft holder
        difference()
        {
            translate([0,0,0])
            cylinder (d1=d2, d2=d2, h=length);

            translate([0,0,-0.01])
            cylinder (d=shaftD, h=length+0.01);
        }

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
                translate([0,d1/2-1,0])
                cylinder(d=1.5, h=skirt);
            }
        }
    }

    if (testDetent == true)
    {
        translate([0,0,1])
        cylinder (d=d1, h=length);
    }
    }
    if (testDetent == true)
    {
        translate([0,0,0])
        tubeD(d1, shaftD, 1);
    }
}


module PotDetentSpring(dShaft= 9.5, dBolt = 14.5, length = 6, contactLength = 2, rim=20)
{
	dOut = rim - 2;
	washerThickness = 0.4;

	// Spring shaft
    translate([0,0,-length - contactLength - 0.2])
    difference()
    {
        intersection()
        {
            translate([0,dOut/3,0])
            tubeD(dOut/3-0.5, dOut/3 - 3, contactLength);
            rotate([0,0,45])
            translate([4,4,0])
            cube([rim,rim,contactLength]);
        }
        translate([0, rim/2 - 1.0, -0.01])
        cylinder(d=1.7, h=contactLength+0.02);
    }

	// Mounting washer with surface ripples for better grip
	translate([0,0,-length - contactLength - 0.5])
	difference()
	{
		tubeD(dOut-0.6, dShaft, washerThickness);

		*for (a = [100:15:440])
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
module PotKnobBristles(d1, d2, length, skirt=5)
{
    shaftD = 6;
    difference()
    {
        union()
        {
            // Pot shaft holder
            difference()
            {
                translate([0,0,0])
                cylinder (d=shaftD + 4, h=length);

                translate([0,0,-0.01])
                cylinder (d=shaftD, h=length+0.01);
            }

            // Outer shell
            difference ()
            {
                cylinder (d1=d1, d2=d2, h=length);
                translate([0,0,-1])
                cylinder (d1=d1-1.5, d2=d2-1.5, h=length-2);
            }

            // Skirt
            translate([0,0,-skirt])
            {
                tube (d1/2, skirt, 1);
            }

            // T-slot
            translate([0,0,length-4])
            cube([shaftD, 0.8, 2], center=true);

            for (a = [20:20:360])
            {
                rotate([0,-3,a])
                rotate([90,16,0])
                translate([-5.3,1.3,0])
                rotate_extrude(angle=46,convexity = 10)
                translate([15.9, 0, 0])
                circle(r = 0.6);
            }
        }
    }
}
