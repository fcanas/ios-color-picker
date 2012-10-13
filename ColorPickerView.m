//
//  ColorPickerView.m
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Extended by Fabián Cañas August 2010.
//  Copyright 2010. All rights reserved.
//

#import "ColorPickerView.h"
#import "FCBrightDarkGradView.h"
#import "Constants.h"
#import "UIColor+HSV.h"

@interface ColorPickerView () {
	
	CGFloat currentBrightness;
	CGFloat currentHue;
	CGFloat currentSaturation;
	
	UIColor *currentColor;
  
}
@end

@implementation ColorPickerView

@synthesize currentHue;
@synthesize currentSaturation;
@synthesize currentBrightness;

- (UIColor *) getColorShown {
	return [UIColor colorWithHue:currentHue saturation:currentSaturation brightness:currentBrightness alpha:1.0];
}

- (void)dealloc {
    [super dealloc];
	
}

@end
