include <common.scad>;
include <special-parts.scad>;
include <commercial-parts.scad>;
include <knobs.scad>;
include <throttle-parameters.scad>;

// --------------------------------------------------
// Some part definitions for easier switch'n'replace
// --------------------------------------------------

module HatSwitch() { Alps688RKJXL100401V(); }
module YAxisPot(cavityOnly=false) { PotentiometerBournsBIP160(cavityOnly=cavityOnly); }
module XAxisPot(cavityOnly=false) { rotate([0,0,180]) PotentiometerBournsBIP160(flip=true,cavityOnly=cavityOnly); }
XYPotKnobSkirt = 3;
module XPotKnob() { PotKnobBristles(22.5, 17.5, 12, 3); }
module YPotKnob() { PotKnobBristles(22.5, 17.5, 12, 3); }

// ----------------------------------
// Global settings and configuration
// ----------------------------------

solidOnly = false; // set true for faster preview rendering
showHandle = true;
showThumb = true;

// Effective values based on the above settings and rendering mode

thumbSeparation = separation;
fnForMinkowskiHull = $preview ? 10 : 15;
draw_other_parts = $preview ? drawOtherParts : false;

// ----------------------------------
// Main handle case parameters
// ----------------------------------

caseThickness = 2;
primaryHandleCylinder = [65, 0]; // diameter, offset

lowerBoxSize = [53,26,85];
lowerBoxPos = [-25,16,-25];
handleAngle = 30;
handleLength = 60; // Main handle length
handleBaseHeight = 0; // level of the base connector plate

// Screw locations and depths for connecting main handle and the thumb side piece
thumb_screws = [ 
	[[21.7,-20.5, -caseThickness], 2*caseThickness, 20],
	[[-25,18,-caseThickness], 2*caseThickness, 20],
	[[25.8,37,-caseThickness], 2*caseThickness, 20]
	];

thumbLength = 100;
thumbDepth = 40;
thumbAngle = 20;
thumbPlateDepth = 77;
thumbPlateAngle = [10, 40, 0];
thumbTipDepth = 57;

thumb_buttons = [
	// x,y,d,z
	[-10.7,-0.5,8,0], // forward
	[9.7,-0.5,8,0], // back
	[-0.5,7,8,0], // down
	[-0.5,-8.2,8,0], // up
	[9.7,14.7,8,0] // low extra
	];

thumbHat = [-2.5, -21, 0, 20-45, 8]; // x,y,z,angle,hole diameter

button_module_supports = [
	[-12.5,-23],// [-13,-24.5], // left top (hat left)
	[7.5,-18.5],// [7,-17], // right top (hat right)
	[7.6,-8.7], // upper right
	[-3.8,0.7], // center
	[14.9,5.7], // right
	[-3.8,18.5] // center low
	];

back_plate_height = 6.3 + 0.4; // ???? Added a bit (0.4) of extra to make sure buttons get to move
backPlatePoints = [
    [4,-14],
    [18,-10], // back button
    [18,20], [-7,20], // down button
    [-17,20], [-17,-3], // forward button
    [-8,-13]
    ];
backPlateOffset = [-2.5, 1.5, -8]; // x, y, angle

backPlateHatPoints = [
    [-23,-14],
    [-23,-18],
    [-18,-25],
    [6,-25],
    [6,-14]
    ];
backPlateHatOffset = [-1.8, -0.8, 20]; // x, y, angle

// Axis pots
axisHoleDiameter = 9.6 + 0.2;

axisYPos = [-3, 31, 0];
axisYRaiserHeight = 1;
axisXPos = [27, 30]; // offset from thumb side bottom, angle
axisXRaiserHeight = 4.5;
axisXRaiserOffset = 0.0;

module xyPots()
{
	if (draw_other_parts == true)
	{
		// X-axis pot
        rotate([0,thumbAngle,0])
        rotate ([0,0,axisXPos.y])
        translate ([-primaryHandleCylinder[0]/2 - caseThickness + axisXRaiserHeight - axisXRaiserOffset, 0, axisXPos.x-9])
        rotate ([0,90,0])
        union ()
        {
            XAxisPot();
            if (showKnobs)
                translate ([0,0,-8])
                rotate ([180,0,0])
                XPotKnob();
        }

		// Y-axis pot
        rotate (thumbPlateAngle)
        translate ([axisYPos.x,axisYPos.y,thumbLength-thumbPlateDepth - axisYRaiserHeight])
        rotate([0,0,axisYPos.z])
        union ()
        {
		    YAxisPot();
            if (showKnobs)
                translate ([0,0,8])
                YPotKnob();
        }

        rotate (thumbPlateAngle)
        translate ([thumbHat.x, thumbHat.y, thumbHat.z + thumbLength-thumbPlateDepth])
        rotate([0,180,thumbHat[3]])
        HatSwitch();
    }
}


module buttonModule()
{
    plateThickness = 1.6;
    translate([backPlateOffset.x, backPlateOffset.y, 0])
    rotate([0, 0, backPlateOffset.z])
    {
        color("orange")
        {       
            translate ([0, 0, -plateThickness])
            CircuitBoard(backPlatePoints);
        }

        translate ([0,0,plateThickness + 3])
        for (b = thumb_buttons)
        {
            translate ([b[0],b[1],b[3]-0.5])
            {
                Switch();
                %translate ([0,0,1.5])
                SwitchButtonBall();
            }
        }
    }

    translate([backPlateHatOffset.x, backPlateHatOffset.y, 0])
    rotate([0, 0, backPlateHatOffset.z])
    {
        color("orange")
        {       
            translate ([0, 0, -plateThickness])
            CircuitBoard(backPlateHatPoints);
        }
    }
}

module buttonHoles()
{
    translate([backPlateOffset.x, backPlateOffset.y, 0])
    rotate([0, 0, backPlateOffset.z])
	for (b = thumb_buttons)
	{
		translate ([b[0],b[1],-0.5])
		SwitchButton(d=b[2],cavityOnly=true);
	}
}

// -------------------------------------------
// Main handle
// -------------------------------------------

module handleLowerBox()
{
    difference()
    {
        translate(lowerBoxPos)
        cube(lowerBoxSize);
    }
}


module handleSection(l, h1, h2)
{
    intersection()
    {
        union()
        {
            cylinder(d=primaryHandleCylinder[0],h=l);
            rotate([0,20,20]) scale([1.064,1,1]) translate([5,0,-35]) cylinder(d1=90,d2=60,h=35);
        }
        // Cone cut straight
        translate([-100, -100, h1-0.01])
        cube([200, 200, h2-h1]);

        // Cone cut angled
        rotate([0,45,20])
        translate([-100, -100, -40])
        cube([200, 200, 200]);
    }
}


module handleLimitCuts(extra = 0)
{
    // Cut the extra plate off
    translate([-50,-50, handleLength - caseThickness])
    cube([100, 150, 100]);

    // Base connector plane
    rotate([-handleAngle,0,0])
    translate([-30, handleBaseHeight + extra,0])
    translate(lowerBoxPos)
    cube([100, 100, 100]);
}

module handleSolidBody()
{
    difference()
    {
        union()
        {
            hull() handleSection(90 + caseThickness, -25, 1);
            hull() handleSection(90 + caseThickness, 0, handleLength + caseThickness);

            handleLowerBox();
        }

        handleLimitCuts();
    }
}

shaftOuterDiameter = 20;
shaftConnectorPos = [0,50,0];
shaftConnectorAngle = [90 - handleAngle,0,0];

handle_case_print_offset_z = 25 + caseThickness;

module handleCase()
{
    difference()
    {
        union()
        {
            difference()
            {
                if (solidOnly == false)
                {
                    minkowski()
                    {
                        handleSolidBody();
                        sphere(caseThickness, $fn=fnForMinkowskiHull);
                        //cube([caseThickness * 2, caseThickness * 2, caseThickness * 2], center = true);
                    }
                }
                handleSolidBody();

                translate([0,0,-0.01])
                handleLimitCuts(caseThickness);
            }

            // Screw thred supports on the Main Handle
            rotate ([0,0,0])
            translate([0,0,handleLength])
            union()
            {
                for (item = thumb_screws)
                    translate(item[0]) ScrewThreadSupport3m(12);
            }

            // Tilted shaft connector
            translate (shaftConnectorPos)
            rotate (shaftConnectorAngle)
            translate ([0,0,20 - caseThickness])
            cylinder (d1=30,d2=48,h=8);
        }

        // Screw locking holes
        rotate ([0,0,0])
        translate([0,0,handleLength-1.3])
        for (item = thumb_screws)
            translate(item[0]) cylinder(d=4.5, h=2);

        // Tilted shaft hole
        translate (shaftConnectorPos)
        rotate (shaftConnectorAngle)
        cylinder (d=shaftOuterDiameter,h=30);

        // Shaft fixing screw hole
        translate (shaftConnectorPos)
        rotate (shaftConnectorAngle)
        translate ([-9,0,23.5 - caseThickness])
        rotate([-90,0,90])
        {
            cylinder (d=3,h=30);
            translate ([0,0,5])
            cylinder (d=5,h=30);
        }
    }
}

// -------------------------------------------
// Thumb side of the handle
// -------------------------------------------

module thumbLimitCuts(extra = 0)
{
    // Cut off the tip
    rotate([0,thumbAngle-40,0])
    translate([-100,-100, thumbLength - thumbTipDepth + extra])
    cube([200,200,100]);

    // Cut off the box
    rotate(thumbPlateAngle)
    translate([-100,-100, thumbLength - thumbPlateDepth + extra])
    cube([200,200,100]);
    
    // Cut off to fit the main handle
    translate([-100,-100,-thumbLength])
    cube([200,200,thumbLength + extra]);
}

module thumbSolidBody()
{
    difference()
    {
        scale([cos(thumbAngle), 1, 1])
        union()
        {
            rotate([0,thumbAngle,0])
            translate([0,0,-thumbDepth])
            hull()
            {
                cylinder(d=primaryHandleCylinder[0],h=thumbLength);
                //translate([secondaryHandleCylinder[2],0,0]) cylinder(d1=secondaryHandleCylinder[0], d2=secondaryHandleCylinder[1] ,h=thumbLength);
            }

            rotate([0,thumbAngle,0])
            translate(lowerBoxPos)
            cube(lowerBoxSize);
        }

        thumbLimitCuts();
    }
}

module thumbScrewHoles()
{
    translate([0,0,caseThickness])
    union ()
    {
        for (item = thumb_screws)
           translate(item[0]) ScrewCavity3m(item[1], capDepth=thumbLength);
    }
}

module thumbHoles()
{
	// Thumb button holes
    rotate(thumbPlateAngle)
    translate ([0,0,thumbLength-thumbPlateDepth])
    buttonHoles();

    // Y-axis pot hole
    rotate (thumbPlateAngle)
    translate ([axisYPos.x,axisYPos.y,thumbLength-thumbPlateDepth - axisYRaiserHeight-0.01])
    YAxisPot(cavityOnly=true);

    // X-axis pot hole
    rotate([0,thumbAngle,0])
    rotate ([0,0,axisXPos.y])
    translate ([-primaryHandleCylinder[0]/2 - caseThickness + axisXRaiserHeight - axisXRaiserOffset, 0, axisXPos.x-9])
    rotate ([0,90,0])
    XAxisPot(cavityOnly=true);

    // Hat shaft hole
    rotate (thumbPlateAngle)
    translate ([thumbHat.x, thumbHat.y, thumbLength-thumbPlateDepth + 2])
    rotate([0,180,thumbHat[3]])
    cylinder (d2=thumbHat[4]*0.7, d1=thumbHat[4], h=4);
}

module thumbSupports()
{
	// Thumb button hole rim risers
	raiser_height = 0.6;
    raiser_width = 3;
    rotate(thumbPlateAngle)
    translate ([0,0,thumbLength-thumbPlateDepth-raiser_height])
    translate([backPlateOffset.x, backPlateOffset.y, 0])
    rotate([0, 0, backPlateOffset.z])
	for (b = thumb_buttons)
	{
		translate ([b[0],b[1],0])
		difference()
		{
			cylinder(h=raiser_height,d=b[2] + raiser_width);
			translate ([0,0,-0.1])
			cylinder(h=raiser_height+0.2,d=b[2]);
		}
	}

    // Hat switch raiser
    rotate (thumbPlateAngle)
    translate ([thumbHat.x, thumbHat.y, thumbLength-thumbPlateDepth])
    rotate([0,180,thumbHat[3]])
    difference()
    {
        cylinder(h=raiser_height,d=thumbHat[4] + 4);
        translate ([0,0,-0.1])
        cylinder(h=raiser_height+0.2,d=thumbHat[4]-1);
    }

    // Backplate supports
    rotate(thumbPlateAngle)
    translate ([0,0,thumbLength-thumbPlateDepth-2*back_plate_height])
    {
        for (b = button_module_supports)
        {
            translate ([b[0],b[1],back_plate_height])
            difference()
            {
                union()
                {
                    translate([0,0,back_plate_height-1])
                    cylinder(d1=5.2, d2=6.5, h=1);
                    cylinder(d=5.2, h=back_plate_height);
                }
                translate([0,0,-0.9])
                cylinder(d=2.5, h=back_plate_height+1);
            }
        }

        if (draw_other_parts)
        {
            translate ([0,0,back_plate_height])
            buttonModule();
        }
    }
    // X-axis pot support
    rotate([0,thumbAngle,0])
    rotate ([0,0,axisXPos.y])
    translate ([-primaryHandleCylinder[0]/2-1, 0, axisXPos.x-9])
    rotate ([0,90,0])
    cylinder (d1=axisHoleDiameter+10, d2=axisHoleDiameter+10, h=caseThickness*2-1);

    // Y-axis pot support
    rotate (thumbPlateAngle)
    translate ([axisYPos.x,axisYPos.y,thumbLength - thumbPlateDepth - axisYRaiserHeight])
    tubeD(dout=axisHoleDiameter+10, din=axisHoleDiameter, h=axisYRaiserHeight);
}

module thumbScrewSupports()
{
    translate([0,0, 5-caseThickness])
    union ()
    {
        for (item = thumb_screws)
           translate(item[0]) ScrewEntrySupport3m(4, item[2]);
    }
}

module thumbConnectors()
{
    l = lowerBoxSize.x * cos(thumbAngle) + caseThickness + 1;
    translate([-l/2 + caseThickness, 43 - caseThickness, -3])
    cube([l, 1, 6]);

    translate([0,-primaryHandleCylinder[0]/2 + 0.1,-3])
    cube([4, 1, 6]);
}

thumb_print_offset_z = 24.5;

module thumbCase()
{
    difference()
    {
        union()
        {
                translate([-2*sin(thumbAngle),0,0])
                difference()
                {
                    union()
                    {
                        difference()
                        {
                            if (solidOnly == false)
                            {
                                minkowski()
                                {
                                    thumbSolidBody();
                                    sphere(caseThickness, $fn=fnForMinkowskiHull);
                                }
                            }
                            thumbSolidBody();
                        }
                        translate([2*sin(thumbAngle),0,0])
                        thumbScrewSupports();
                    }
                    thumbLimitCuts(caseThickness-0.1);
                }

                // Screw locking extrudes
                translate([0,0, 5-caseThickness])
                for (item = thumb_screws)
                    translate(item[0]) tubeD(din=3, dout=4.2, h=1);

                translate([-2*sin(thumbAngle),0,0])
                {
                    thumbSupports();
                    thumbConnectors();

                    xyPots();
                }
        }
        translate([-2*sin(thumbAngle),0,0])
        thumbHoles();
    }
}

module handleThumbPart()
{
    difference()
    {
        thumbCase();
        thumbScrewHoles();
    }
}

// -------------------------------------------
// All handle parts together
// -------------------------------------------

module handle()
{
    if (showHandle)
        handleCase();

    if (showThumb)
    {
        translate([0,0, handleLength + thumbSeparation])
        handleThumbPart();
    }
}
