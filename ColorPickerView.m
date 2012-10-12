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
	CGRect colorMatrixFrame;
	
	CGFloat currentBrightness;
	CGFloat currentHue;
	CGFloat currentSaturation;
	
	UIColor *currentColor;
  
  CGRect gradientRect;
}
@end

@implementation ColorPickerView

@synthesize currentHue;
@synthesize currentSaturation;
@synthesize currentBrightness;

- (id)initWithCoder:(NSCoder*)coder  {
	if (self = [super initWithCoder:coder]) {
    
    gradientRect = CGRectMake(10, 404, 300, 40);
		
		gradientView = [[FCBrightDarkGradView alloc] initWithFrame:gradientRect];
		[self addSubview:gradientView];
		[self sendSubviewToBack:gradientView];
    
		[self setMultipleTouchEnabled:YES];
		colorMatrixFrame = kHueSatFrame;
		UIImageView *hueSatImage = [[UIImageView alloc] initWithFrame:colorMatrixFrame];
		[hueSatImage setImage:[UIImage imageNamed:kHueSatImage]];
		[self addSubview:hueSatImage];
		[self sendSubviewToBack:hueSatImage];
		[hueSatImage release];
    
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
    hueSatPosition.x = (currentHue*kMatrixWidth)+kXAxisOffset;
    hueSatPosition.y = (1.0-currentSaturation)*kMatrixHeight+kYAxisOffset;
    brightnessPosition.x = (1.0+kBrightnessEpsilon-currentBrightness)*gradientView.frame.size.width;
    
    // Original input brightness code (from down below)
    // currentBrightness = 1.0-(position.x/gradientView.frame.size.width) + kBrightnessEpsilon;
    
    brightnessPosition.y = kBrightBarYCenter;
    [gradientView setColor:color];
    showColor.swatchColor = currentColor;
    
    crossHairs.center = hueSatPosition;
    brightnessBar.center = brightnessPosition;
} 


- (void) updateHueSatWithMovement : (CGPoint) position {

	currentHue = (position.x-kXAxisOffset)/kMatrixWidth;
	currentSaturation = 1.0 -  (position.y-kYAxisOffset)/kMatrixHeight;
	
	UIColor *forGradient = [UIColor colorWithHue:currentHue 
									saturation:currentSaturation 
									brightness: kInitialBrightness 
									alpha:1.0];
	
	[gradientView setColor:forGradient];

	currentColor  = [UIColor colorWithHue:currentHue 
									   saturation:currentSaturation 
									   brightness:currentBrightness
									   alpha:1.0];
	
  showColor.swatchColor = currentColor;
}


- (void) updateBrightnessWithMovement : (CGPoint) position {
	
	currentBrightness = 1.0-(position.x/gradientView.frame.size.width) + kBrightnessEpsilon;
	
	UIColor *forColorView  = [UIColor colorWithHue:currentHue 
										saturation:currentSaturation 
										brightness:currentBrightness
											 alpha:1.0];
	
  showColor.swatchColor = forColorView;
}

-(void) dispatchTouchEvent:(CGPoint)position
{
	if (CGRectContainsPoint(colorMatrixFrame,position)) {
    crossHairs.center = position;
    
		[self updateHueSatWithMovement:position];
	}
	else if (CGRectContainsPoint(gradientView.frame, position)) {
    brightnessBar.center = CGPointMake(position.x,gradientRect.origin.y + gradientRect.size.height/2);
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
