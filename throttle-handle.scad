include <common.scad>;
include <special-parts.scad>;
include <commercial-parts.scad>;
include <knobs.scad>;
include <throttle-parameters.scad>;

// --------------------------------------------------
// Some part definitions for easier switch'n'replace
// --------------------------------------------------

module HatSwitch() { AlpsRKJXL100401V(); }
module YAxisPot(cavityOnly=false) { PotentiometerBIP160(cavityOnly=cavityOnly); }
module XAxisPot(cavityOnly=false) { rotate([0,0,180]) PotentiometerBIP160(flip=true,cavityOnly=cavityOnly); }
XYPotKnobSkirt = 3;
module XPotKnob() { PotKnobBristles(22.5, 17.5, 12, 3); }
module YPotKnob() { PotKnobBristles(22.5, 17.5, 12, 3); }

// ----------------------------------
// Global settings and configuration
// ----------------------------------

solidOnly = false; // set true for faster preview rendering

// Effective values based on the above settings and rendering mode

fnForMinkowskiHull = $preview ? 10 : 15;

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

handleCaseSwitch = [0,0,0];

// Screw locations and depths for connecting main handle and the thumb side piece
thumbScrews = [ 
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

backPlateHeight = 6.3 + 0.4; // ???? Added a bit (0.4) of extra to make sure buttons get to move

// Thumb part buttons in the button module
thumbButtons = [
	// x,y,d,z
	[-10.7,-0.5,8,0, [75, 290]], // forward
	[9.7,-0.5,8,0, [100, -30, 183]], // back
	[-0.5,7,8,0, [0, 180]], // down
	[-0.5,-8.2,8,0, [175, 70]], // up
	[9.7,14.7,8,0, [30, 150, 260]], // low extra
	[-10.7-2.54,-0.5+6*2.54,8,0, [285, 30]], // forward extra
	];
backPlatePoints = [
/*    [4,-14],
    [23,-10], // back button
    [23,20], [-7,20], // down button
    [-17,20], [-17,-3], // forward button
    [-8,-13]
    */
    [17,-25],
    [17, -10],
    [23, -10], // back button
    [23,20], [-7,20], // down button
    [-17-2.54,20], [-17-2.54,-8], // forward button
    [-12,-8],
    [-12,-25]
    ];
backPlateOffset = [-5, 0, -8]; // x, y, angle
//blackPlateRasterOffset=[0,0.7]; // x, y
blackPlateRasterOffset=[0, 1.6]; // x, y
buttonModuleSupportDOut=5.2;
buttonModuleButtonSupports = [
	[0.8 + 3*2.54, -0.6 - 3*2.54], // upper right
	[0.8 - 2.54, -0.6], // center
	[0.8 - 2*2.54, -0.6 + 6*2.54], // down
	[0.8 + 5*2.54, -0.6 + 3*2.54] // back
	];

// Thumb hat switch module
//thumbHatOffset = [-2, -10, 0]; // x, y, z
thumbHatOffset = [-3.1, -11.5, 0]; // x, y, z
thumbHatAngle = [0, 0, -8];
thumbHat = [-2.5, -11, 0, 45, 9]; // x,y,z,angle,hole diameter
backPlateHatPoints = [];/*
    [-16,-5],
    [-16,-15],
    [12,-15],
    [14,-13],
    [14,-5]
    ];*/
backPlateHatRasterOffset = [0.8, 0.2]; // x, y
buttonModuleHatSupports = [
	[-5*2.54,-4*2.54+0.4], // hat left
	[4*2.54,-4*2.54+0.4] // hat right
	];

thumbButtonsFront = [[8, 0]]; // offset from thumb side bottom, angle

// Axis pots
axisHoleDiameter = 9.6 + 0.2;

axisYPos = [-3, 31, 0];
axisYRaiserHeight = 1;
axisXPos = [28, 27]; // offset from thumb side bottom, angle
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
        translate(thumbHatOffset) rotate(thumbHatAngle)
        translate ([thumbHat.x, thumbHat.y, thumbHat.z + thumbLength-thumbPlateDepth])
        rotate([0,180,thumbHat[3]])
        union()
        {
            HatSwitch();
            if (showKnobs)
                moveZ(-9)
                flipY()
                turnZ(45)
                hatKnob();
        }
    }
}

plateThickness = 1.6;

module buttonModuleButtons()
{
    for (b = thumbButtons)
    {
        translate ([b[0],b[1],b[3]-0.05])
        {
            color("orange")
            translate ([0,0,1.5+ (backPlateHeight-6.7)])
            %SwitchButtonBall();
        }
    }
}

module buttonModuleSprings(d=8, h=backPlateHeight - 2)
{
    f = 0.0;
    color("green")
    moveZ(-0.9 + f + (backPlateHeight - 6.7))
    {
        for (b = thumbButtons)
        {
            translate ([b[0],b[1],b[3]])
            {
                moveZ(+0.7-f)
                tubeD(din=d-1, dout=d+2, h=0.4);
                for (s = b[4])
                {
                    translate([0,0,-backPlateHeight+1.1+plateThickness])
                    {
                        rotate(s)
                        {
                            translate([4,-1.5/2,h-f])
                            cube([d-4, 1.5, 0.4]);
                            translate([d,0,0.3-f])
                            //cylinder(d=1.5, h=h+0.1 + (backPlateHeight-h-0.1));
                            cylinder(d=1.5, h=h+0.1);
                        }
                    }
                }
            }
        }

        for (s = [buttonModuleButtonSupports[3]])
        {
            translate([0,0,1.1 + plateThickness - 2 - f])
            translate(s)
            {
                tubeD(din=buttonModuleSupportDOut+0.25, dout=buttonModuleSupportDOut+0.25+1, h=0.4);
                moveX(-buttonModuleSupportDOut/2-3)
                moveY(-1)
                cube([2.7,2,0.4]);
            }
        }

        for (s = [buttonModuleButtonSupports[2]])
        {
            translate([0,0, 1.1+plateThickness - 2 - f])
            translate(s)
            {
                difference()
                {
                    tubeD(din=buttonModuleSupportDOut+0.25, dout=buttonModuleSupportDOut+0.25+1, h=0.4);
                    turnZ(30)
                    moveY(-4.5)
                    moveX(-3.5)
                    moveZ(-0.5)
                    cube([7,3,1]);
                }
                moveY(2)
                moveX(-2)
                turnZ(30)
                cube([2,1.5,0.4]);
            }
        }
    }
}

module buttonModuleSwitches()
{
    for (b = thumbButtons)
    {
        translate ([b[0],b[1],b[3]-0.5])
        Switch();
    }
}

module buttonModuleFront(supports = false, holes = false)
{
    raiser = caseThickness+0.4;
    for (b = thumbButtonsFront)
    {
        rotate([0,thumbAngle,0])
        rotate ([0,0,b.y])
        translate ([-primaryHandleCylinder[0]/2 + raiser, 0, b.x-9])
        rotate ([0,90,0])
        flipX()
        {
            if (supports == true)
            {
                cylinder(d=10, h=2);
                moveZ(-backPlateHeight+0.8)
                moveX(1.25)
                {
                    moveY(3*2.54)
                    ScrewSupport(din=2.5, dout=buttonModuleSupportDOut, dbase=6.5, h=backPlateHeight-0.4);
                    moveY(-3*2.54)
                    ScrewSupport(din=2.5, dout=buttonModuleSupportDOut, dbase=6.5, h=backPlateHeight-0.4);
                }
            }
            if (holes == true)
            {
                moveZ(-0.9)
                cylinder(d=8, h=5);
            }
            if (draw_other_parts)
            {
                moveZ(-1.4)
                Switch();
                %SwitchButtonBall();
                translate([-3*2.54, -4*2.54, -backPlateHeight])
                CircuitBoard(py=8, px=6, rasterOffset=[1.25,0]);
            }
        }
    }
}


module buttonModule()
{
    translate([backPlateOffset.x, backPlateOffset.y, 0])
    rotate([0, 0, backPlateOffset.z])
    {
        color("orange")
        {       
            translate ([0, 0, -plateThickness])
            CircuitBoard(backPlatePoints, rasterOffset=blackPlateRasterOffset);
        }

        translate ([0,0,plateThickness + 3])
        {
            buttonModuleButtons();
            // buttonModuleSprings();
            buttonModuleSwitches();
        }
    }

    translate(thumbHatOffset) rotate(thumbHatAngle)
    {
        color("orange")
        {       
            translate ([0, 0, -plateThickness])
            CircuitBoard(backPlateHatPoints, rasterOffset=backPlateHatRasterOffset);
        }
    }
}

module buttonHoles()
{
    // Thumb-side button holes
    translate([backPlateOffset.x, backPlateOffset.y, 0])
    rotate([0, 0, backPlateOffset.z])
	for (b = thumbButtons)
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
shaftConnectorPos = [0, 30.5 + caseThickness,0];
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
                for (item = thumbScrews)
                    translate(item[0]) ScrewThreadSupport3m(12);
            }

            // Tilted shaft connector
            translate (shaftConnectorPos)
            rotate (shaftConnectorAngle)
            translate ([0,0,caseThickness + 10])
            cylinder (d1=48+5,d2=30,h=10);
        }

        // Tilted shaft hole
        translate (shaftConnectorPos)
        rotate (shaftConnectorAngle)
        cylinder (d=shaftOuterDiameter,h=30);

        // Swtich holes
        translate([lowerBoxSize.x/2, lowerBoxPos.y + lowerBoxSize.y - 14, -lowerBoxPos.z + 22 - 9])
        switch_cavity();

        // Case screw holes
        rotate ([0,0,0])
        translate([0,0,handleLength-1.3])
        for (item = thumbScrews)
            translate(item[0]) cylinder(d=4.5, h=2);

        // Shaft fixing screw hole
        translate (shaftConnectorPos)
        rotate (shaftConnectorAngle)
        translate ([-9,0,19 - caseThickness])
        rotate([-90,0,90])
        {
            cylinder (d=2.5,h=30);
            translate ([0,0,5])
            cylinder (d=5,h=30);
        }
    }
}

module switch_cavity(w=11, h=6, depth=5, screw_distance=15)
{
    translate([-0.1, 0, 0])
    {
        cube([depth + 0.2, h, w]);

        moveZ(-(screw_distance - w)/2)
        turnY(90)
        moveY(h/2)
        cylinder(d=1.5, h=depth + 0.2);

        moveZ((screw_distance + w)/2)
        turnY(90)
        moveY(h/2)
        cylinder(d=1.5, h=depth + 0.2);
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
        for (item = thumbScrews)
           translate(item[0]) ScrewCavity3m(item[1], capDepth=thumbLength);
    }
}

module thumbHoles()
{
	// Thumb button holes
    rotate(thumbPlateAngle)
    translate ([0,0,thumbLength-thumbPlateDepth])
    buttonHoles();

    buttonModuleFront(holes=true);

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
    translate(thumbHatOffset) rotate(thumbHatAngle)
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
	for (b = thumbButtons)
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
    translate(thumbHatOffset) rotate(thumbHatAngle)
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
    translate ([0,0,thumbLength-thumbPlateDepth-2*backPlateHeight])
    {
        translate([backPlateOffset.x, backPlateOffset.y, 0])
        rotate([0, 0, backPlateOffset.z])
        for (b = buttonModuleButtonSupports)
        {
            translate ([b[0],b[1],backPlateHeight])
            ScrewSupport(din=2.5, dout=buttonModuleSupportDOut, dbase=6.5, h=backPlateHeight);
        }

        translate(thumbHatOffset) rotate(thumbHatAngle)
        for (b = buttonModuleHatSupports)
        {
            translate ([b[0],b[1],backPlateHeight])
            ScrewSupport(din=2.5, dout=buttonModuleSupportDOut, dbase=6.5, h=backPlateHeight);
        }

        if (draw_other_parts)
        {
            translate ([0,0,backPlateHeight])
            buttonModule();
        }      
    }

    buttonModuleFront(supports=true);

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
        for (item = thumbScrews)
           translate(item[0]) ScrewEntrySupport3m(4, item[2]);
    }
}

module thumbConnectors()
{
    l = lowerBoxSize.x * cos(thumbAngle) + caseThickness + 1;
    translate([-l/2 + caseThickness, 43 - caseThickness, 0])
    cube([l, 1, 4]);
    
    moveX(0.6)
    difference()
    {
        tubeD(din=primaryHandleCylinder[0]-1.5, dout=primaryHandleCylinder[0]+1, h=3);
        moveY(65)
        cube([100,100,100], center=true);

        for (item = thumbScrews)
           translate(item[0]) cylinder(d=12, h=5);

        // Make sure it fits to the main handle part
        difference()
        {
            cube([100,100,30], center=true);
            translate([0,0, -handleLength + 2*caseThickness - 0.1])
            moveZ(5)
            handleSolidBody();
        }
    }
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
                for (item = thumbScrews)
                    translate(item[0]) tubeD(din=3, dout=4.2, h=1);

                translate([-2*sin(thumbAngle),0,0])
                {
                    thumbSupports();
                    thumbConnectors();
                }
        }
        translate([-2*sin(thumbAngle),0,0])
        thumbHoles();
    }

    translate([-2*sin(thumbAngle),0,0])
    xyPots();
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

module handle(showHandle = true, showThumb = true)
{
    if (showHandle)
        handleCase();

    if (showThumb)
    {
        moveZ(handleLength + separation)
        handleThumbPart();
    }
}
