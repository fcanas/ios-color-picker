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
}
@end

@implementation ColorPickerView

@synthesize currentHue;
@synthesize currentSaturation;
@synthesize currentBrightness;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder  {
	if (self = [super initWithCoder:coder]) {
		
		gradientView = [[FCBrightDarkGradView alloc] initWithFrame:kBrightnessGradientPlacent];
		//[gradientView setTheColor:[UIColor yellowColor]];
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
		
		currentColor = [[UIColor alloc]init];
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
    [gradientView setTheColor:color];
    //[showColor setBackgroundColor:currentColor];
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
	
	[gradientView setTheColor:forGradient];
	[gradientView setupGradient];
	[gradientView setNeedsDisplay];

	currentColor  = [UIColor colorWithHue:currentHue 
									   saturation:currentSaturation 
									   brightness:currentBrightness
									   alpha:1.0];
	
	//[showColor setBackgroundColor:currentColor];
    showColor.swatchColor = currentColor;
    [showColor setNeedsDisplay];
}


- (void) updateBrightnessWithMovement : (CGPoint) position {
	
	currentBrightness = 1.0-(position.x/gradientView.frame.size.width) + kBrightnessEpsilon;
	
	UIColor *forColorView  = [UIColor colorWithHue:currentHue 
										saturation:currentSaturation 
										brightness:currentBrightness
											 alpha:1.0];
	
	//[showColor setBackgroundColor:forColorView];
    showColor.swatchColor = forColorView;
    [showColor setNeedsDisplay];
}

//Touch parts : 

// Scales down the view and moves it to the new position. 
- (void)animateView:(UIImageView *)theView toPosition:(CGPoint) thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kAnimationDuration];
	// Set the center to the final postion
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}

-(void) dispatchTouchEvent:(CGPoint)position
{
	if (CGRectContainsPoint(colorMatrixFrame,position))
	{
		[self animateView:crossHairs toPosition: position];
		[self updateHueSatWithMovement:position];
		
	}
	else if (CGRectContainsPoint(gradientView.frame, position))
	{
		CGPoint newPos = CGPointMake(position.x,kBrightBarYCenter);
		[self animateView:brightnessBar toPosition: newPos];
		[self updateBrightnessWithMovement:position];
	}
	else
	{
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

- (void)drawRect:(CGRect)rect {
	
	[gradientView setupGradient];
	[gradientView setNeedsDisplay];
	[self sendSubviewToBack:showColor];

}

- (UIColor *) getColorShown {
	return [UIColor colorWithHue:currentHue saturation:currentSaturation brightness:currentBrightness alpha:1.0];
}

- (void)dealloc {
    [super dealloc];
	
}

@end
