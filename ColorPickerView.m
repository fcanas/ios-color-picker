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

- (id)initWithCoder:(NSCoder*)coder  {
	if (self = [super initWithCoder:coder]) {
        
		[self setMultipleTouchEnabled:YES];
    
		currentBrightness = kInitialBrightness;
	}
	return self;
}

- (void) setColor:(UIColor *)color {
    currentColor = color;
    currentHue = color.hue;
    currentSaturation = color.saturation;
    currentBrightness = color.brightness;
    CGPoint hueSatPosition;
    CGPoint brightnessPosition;
    hueSatPosition.x = (currentHue*_hueSatImage.frame.size.width)+_hueSatImage.frame.origin.x;
    hueSatPosition.y = (1.0-currentSaturation)*_hueSatImage.frame.size.height+_hueSatImage.frame.origin.y;
    brightnessPosition.x = (1.0+kBrightnessEpsilon-currentBrightness)*_gradientView.frame.size.width;
    
    // Original input brightness code (from down below)
    // currentBrightness = 1.0-(position.x/gradientView.frame.size.width) + kBrightnessEpsilon;
    
    brightnessPosition.y = _gradientView.center.y;
    [_gradientView setColor:color];
    _showColor.swatchColor = currentColor;
    
    _crossHairs.center = hueSatPosition;
    _brightnessBar.center = brightnessPosition;
} 


- (void) updateHueSatWithMovement : (CGPoint) position {

	currentHue = (position.x-_hueSatImage.frame.origin.x)/_hueSatImage.frame.size.width;
	currentSaturation = 1.0 -  (position.y-_hueSatImage.frame.origin.y)/_hueSatImage.frame.size.height;
	
	UIColor *gradientColor = [UIColor colorWithHue:currentHue 
									saturation:currentSaturation 
									brightness: kInitialBrightness 
									alpha:1.0];
	
	[_gradientView setColor:gradientColor];

	currentColor  = [UIColor colorWithHue:currentHue 
									   saturation:currentSaturation 
									   brightness:currentBrightness
									   alpha:1.0];
	
  _showColor.swatchColor = currentColor;
}


- (void) updateBrightnessWithMovement : (CGPoint) position {
	
	currentBrightness = 1.0-(position.x/_gradientView.frame.size.width) + kBrightnessEpsilon;
	
	UIColor *forColorView  = [UIColor colorWithHue:currentHue 
										saturation:currentSaturation 
										brightness:currentBrightness
											 alpha:1.0];
	
  _showColor.swatchColor = forColorView;
}

-(void) dispatchTouchEvent:(CGPoint)position
{
	if (CGRectContainsPoint(_hueSatImage.frame,position)) {
    _crossHairs.center = position;
    
		[self updateHueSatWithMovement:position];
	}
	else if (CGRectContainsPoint(_gradientView.frame, position)) {
    _brightnessBar.center = CGPointMake(position.x,_gradientView.frame.origin.y + _gradientView.frame.size.height/2);
		[self updateBrightnessWithMovement:position];
	}
}


// Handles the start of a touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	for (UITouch *touch in touches) {
		[self dispatchTouchEvent:[touch locationInView:self]];
		}	
}

// Handles the continuation of a touch.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  

	for (UITouch *touch in touches){
		[self dispatchTouchEvent:[touch locationInView:self]];
	}
	
}

- (UIColor *) getColorShown {
	return [UIColor colorWithHue:currentHue saturation:currentSaturation brightness:currentBrightness alpha:1.0];
}

- (void)dealloc {
    [super dealloc];
	
}

@end
