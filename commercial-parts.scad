include <common.scad>;

module TeensyPlusPlus()
{
    color ("Green") cube ([51,18,2]);
    
    color ("Snow")
    translate ([0,5,2])
    cube ([9,8,4]);
}

module SlidePotentiometer(range=100, leverWidth=8.0, leverHeight=20,
	sliderEndLength=10, sliderHeight=6.4,
	value=0.5, alignTop=false, alignPin=false, alignLever=false, alignValueMax=false)
{
    slider_length = range + leverWidth + 2 * sliderEndLength;
    slider_width = 8.3;
    lever_thickness = 1.0;
	pin_length = 4.4;
    lever_groove_offset = (slider_length - range - slider_width) / 2;
	lever_offset = sliderEndLength + range * value;

	alignZ = alignTop ? -sliderHeight : (alignPin ? pin_length : 0);
	alignX = alignValueMax ? -sliderEndLength : 0;
	alignY = alignLever ? -slider_width/2 : 0;
	translate([alignX, alignY, alignZ])
	{
		// Slider base
		difference ()
		{
			cube ([slider_length,slider_width,sliderHeight]);
			translate ([lever_groove_offset, (slider_width-lever_thickness*2)/2, 1])
				cube ([range + slider_width,lever_thickness*2,sliderHeight]);
			// Screw places
			translate ([slider_length - 4, slider_width/2, sliderHeight - 3]) cylinder (d=3, h=4);
			translate ([4, slider_width/2, sliderHeight - 3]) cylinder (d=3, h=4);
		}
		// Lever
		translate ([lever_offset, (slider_width-lever_thickness)/2, 0])
		cube ([leverWidth,lever_thickness,leverHeight]);
		// Pins
		color("white") translate ([0, 0, -pin_length])
		{
			translate ([0, slider_width-1, 0]) cube ([0.5,1,pin_length]); // +V
			translate ([slider_length-0.5, 0, 0]) cube ([0.5,1,pin_length]); // GND
			translate ([slider_length-0.5, slider_width-1, 0]) cube ([0.5,1,pin_length]); // R
		}
	}
}

module PotentiometerBourns95A1()
{
	shaft_diameter = 6.3;
	color("blue") cylinder(d1=shaft_diameter, d2=shaft_diameter, h=22.5);
	color("white") cylinder(d1=9.4, d2=9.4, h=9.5);

	base_height = 12.5;
	color ("blue")
	translate ([-17.5/2,-16/2,-base_height])
	cube ([17.5, 16, base_height]);

	// pins
	translate ([-17.5/2-5.5,-7.5/2,-4.5-5.5])
	color("white") cube([5.5, 7.5, 4.5]);
}

module PotentiometerBourns95A1Down()
{
	rotate ([180,0,0])
	PotentiometerBourns95A1();
}

// Bourns PCW1J-B24-CCB103L
module PotentiometerBournsPCW1J()
{
	shaft_diameter = 6.3;
	color("black") cylinder(d1=shaft_diameter, d2=shaft_diameter, h=19);
	color("white") cylinder(d1=8.8, d2=8.8, h=6.5);

	base_height = 7.2;
	color ("black")
	translate ([-22.5/2,-22.5/2,-base_height])
	cube ([22.5, 22.5, base_height]);

	// notches
	translate ([0,22.5/2-1.3,1])
	color("grey") cube([2.7, 1.3, 2], center=true);

	// pins
	translate ([-22.5/2-7,-12/2,2-base_height])
	color("white") cube([7, 12, 0.7]);
}

module PotentiometerBournsPCW1JDown()
{
	rotate ([180,0,0])
	PotentiometerBournsPCW1J();
}

// BI/TT P160 pot with 15mm shaft (e.g. LIN 10kohm pot P160KN-1QC15B10K)
module PotentiometerBIP160(flip = false, cavityOnly = false)
{
    base_diameter = 16.5;
    base_height = 9.4;
    shaft_neck_height = 6.4;
    shaft_neck_diameter = 6.9;
    shaft_diameter = 6.0;
    shaft_length = 24.4 - base_height - shaft_neck_height;
    notch_width = 1.2;
    notch_length = 2.7;
    notch_height = 11.4 - base_height;
    pin_distance = 5.0;
    pin_level = 0.0;
    pin_length = 8.0;

    rotate([0,flip ? 180 : 0,0])
    {
        if (cavityOnly == false)
        {
            translate([0,0,shaft_neck_height])
            color("silver") cylinder(d=shaft_diameter, h=shaft_length);
            color("silver") cylinder(d=shaft_neck_diameter, h=shaft_neck_height);

            color ("silver")
            translate ([0,0,-base_height])
            cylinder (d=base_diameter, h=base_height);

            // pins
            translate ([0,-pin_distance,pin_level - 2.0])
            color("silver") cube([base_diameter/2 + pin_length, 2*pin_distance, 2.0]);

            // Notch
            rotate([0,0,-90])
            translate ([base_diameter / 2 - notch_width, -notch_length/2, 0])
            color("silver") cube([notch_width, notch_length, notch_height]);
        }
        else
        {
            tolerance = 0.4;
            // Shaft hole
            color("silver") cylinder(d=shaft_neck_diameter + tolerance, h=shaft_length + shaft_neck_height);
            // Notch cavity
            rotate([0,0,-90])
            translate ([base_diameter / 2 - notch_width - tolerance/2, -notch_length/2 - tolerance/2, 0])
            color("silver") cube([notch_width + tolerance, notch_length + tolerance, notch_height + tolerance]);
        }
    }
}

// 8-direction + push button switch
module AlpsRKJXL100401V()
{
	color("brown")
	{
		// Case
		rotate([0,0,45])
		difference()
		{
			rotate([0,0,22.5])
			cylinder(d=14.4, h=6.4, $fn=8);

			// Cover markings
			translate([0,4,0]) cube([0.5,2,1], center = true);
			translate([0,-4,0]) cube([0.5,2,1], center = true);
			translate([4,0,0]) cube([2,0.5,1], center = true);
			translate([-4,0,0]) cube([2,0.5,1], center = true);

			rotate([0,0,-45])
			translate([7,0,-0.5]) rotate([0,0,60]) cylinder(d=4, h=1, $fn=3);
		}

		// Shaft
		difference()
		{
			translate([0,0,-7])
			cylinder(d=2.2, h=7);

			translate([0.3,-1.1,-7.01])
			cube([0.81, 2.20, 3.51]);
		}

		// Installation guides at the bottom
		rotate([0,0,-12.5])
		{
			translate([-6.4+0.8,0,6]) cylinder(d=1.6, h=2.5);
			translate([6.1-0.5,0,6]) cylinder(d=1, h=2);
		}
	}
	// Pins
	translate([0,0,6.4])
	color("white")
	{
		translate([0,7.5,0]) PinFlat(text="C1"); // C1
		translate([0,-7.5,0]) PinFlat(text="C2", d=180); // C2

		translate([7.5,2,0]) PinFlat(text="1", d=-90); // 1
		translate([-7.5,-2,0]) PinFlat(text="2", d=90); // 2

		rotate([0,0,45])
		{
			translate([7.5,1.2,0]) PinFlat(text="G", d=-90); // A
			translate([7.5,-1.2,0]) PinFlat(text="H", d=-90); // B
			translate([-7.5,1.2,0]) PinFlat(text="D", d=90); // A
			translate([-7.5,-1.2,0]) PinFlat(text="C", d=90); // B

			translate([1.2,7.5,0]) PinFlat(text="F", d=0); // A
			translate([-1.2,7.5,0]) PinFlat(text="E", d=0); // B
			translate([1.2,-7.5,0]) PinFlat(text="A", d=180); // A
			translate([-1.2,-7.5,0]) PinFlat(text="B", d=180); // B
		}
	}

	// Instruction texts
	module t(text, d=0)
	{		
		rotate([0,0,d]) translate([0,-5,0]) rotate([180,0,0]) text(text,size=1,halign="center");
	}

	rotate([0,0,90])
	{
		translate([0,7.5,0]) t("1-2",0);
		t("A",0);
		t("E",180);
		t("H",45);
		t("G",90);
		t("F",135);
		t("D",-135);
		t("C",-90);
		t("B",-45);
	}
}

module Gt2Pulley(d=12.5,dShaft=5, l=14, w=6)
{
	color("silver")
	difference()
	{
		cylinder(d=d,h=l);

		translate([0,0,-0.01])
		cylinder(d=dShaft,h=l+0.02);

		translate([0,0,1])
		difference()
		{
			cylinder(d=d+0.01,h=w);
			cylinder(d=d-2,h=w);
		}
	}
}

module DcMotor()
{
	color("silver")
	cylinder(d=15,h=30);
}

module Gt2BeltCircular(l,d=12.5,width=6)
{
	color("brown")
	{
		cube([l, d, 2]);
		translate([0,0,0]) cylinder(d=d,h=width);
		translate([l,0,0]) cylinder(d=d,h=width);
		for (a = [360/16 : 360/16 : 360])
		{
			rotate([0, a, 0]) translate([d/2-2,0,0]) cylinder(d=2,h=width);
		}
	}
}


module SlideSwitch(l=12, w=5, h=5, screwDistance = 16)
{
	translate([-l/2,-w/2,-h])
	cube([l,w,h]);

	difference()
	{
		translate([-screwDistance/2-2,-w/2,-0.5])
		cube([screwDistance+4,w,0.5]);

		translate([-screwDistance/2,0,-1])
		cylinder(d=2, h=2);
		translate([screwDistance/2,0,-1])
		cylinder(d=2, h=2);
	}

	lever = [2, 2, 4];
	translate([-lever.x/2, -lever.y/2, 0])
	cube(lever);
}
