/*
Copyright 2021 Michael Brohl

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

/*
Parametric Bonsai Nebari groundplate for root development.

See README for further explanations. 
*/

// === change the parameters for your needs here ===
// the diameter of the groundplate
groundPlateDia = 150;
// the thickness of the groundplate and dividers
thickness = 1.5;
// the space between two opposite long dividers
centerSpaceDia = 30;
// number of each long and short dividers
dividerCount = 8;
// height of dividers
dividerHeight = 10;
// should we drill a center hole?
drillCenterHole = false;
// the diameter of the center hole
centerHoleDia = 10;

// === don't change anything below ===
$fn = $preview ? 32 : 80;
groundPlateRadius = groundPlateDia / 2;
centerSpaceRadius = centerSpaceDia / 2;

dividerAngle = 360/dividerCount;

longDividerLength = groundPlateRadius - centerSpaceRadius;
shortDividerLength = longDividerLength / 2;

centerHolegroundPlateRadius = centerHoleDia / 2;

// the groundplate
module groundPlate() {
   cylinder(h = thickness, r1 = groundPlateRadius, r2 = groundPlateRadius, center = true);
}

// a long divider
module longDivider() {
   translate([longDividerLength / 2, 0, dividerHeight / 2])
     cube([longDividerLength, thickness, dividerHeight], center = true);
}

// a short divider
module shortDivider() {
    translate([shortDividerLength / 2, 0, dividerHeight / 2])
      cube([shortDividerLength, thickness, dividerHeight], center = true);
}

// the center hole
module centerHole() {
   cylinder(h = thickness * 2, r1 = centerHolegroundPlateRadius, r2 = centerHolegroundPlateRadius, center = true);
}

// the complete nebari plate
module nebariPlate() {
    union () {
        groundPlate();

        for(i = [0 : dividerCount]) {
            rotate([0, 0, i * dividerAngle]) 
              translate([centerSpaceRadius - 0.05, 0, 0])
                longDivider();

            rotate([0, 0, i * dividerAngle + dividerAngle/2 ])
              translate([centerSpaceRadius + shortDividerLength - 0.05, 0, 0])
                shortDivider();
        }
    }    
}

// putting everything together
if (drillCenterHole) {
    difference() {
        nebariPlate();
        centerHole();
    }
} else {
    nebariPlate();
}
