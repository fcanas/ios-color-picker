//
//  ColorPickerViewController.m
//  ColorPicker
//
//  Created by Fabián Cañas
//  Based on work by Gilly Dekel on 23/3/09
//  Copyright 2010-2012. All rights reserved.
//

#import "FCColorPickerViewController.h"
#import "FCBrightDarkGradView.h"
#import "FCColorSwatchView.h"
#import "UIColor+HSV.h"

@interface FCColorPickerViewController () {
	
	CGFloat currentBrightness;
	CGFloat currentHue;
	CGFloat currentSaturation;
  
  UIColor *_color;
}

@end


@implementation FCColorPickerViewController

@synthesize color = _color;

-(void)viewDidLoad {
  [super viewDidLoad];
  [self.view bringSubviewToFront:_crossHairs];
  [self.view bringSubviewToFront:_brightnessBar];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self setColor:_color];
  [self updateBrightnessPosition];
  [self updateGradientColor];
  [self updateCrosshairPosition];
  _colorSwatch.swatchColor = _color;
}

-(void)viewWillLayoutSubviews {
  [self updateBrightnessPosition];
  [self updateCrosshairPosition];
}

#pragma mark -
#pragma mark Color Manipulation

- (UIColor *) color {
  return _color;
}

-(void) _setColor:(UIColor *)newColor {
  if (_color != newColor) {
    [newColor retain];
    [_color release];
    _color = newColor;
    _colorSwatch.swatchColor = _color;
    [self updateGradientColor];
  }
}

-(void) setColor:(UIColor *)newColor {
  [self _setColor:newColor];
  [self updateBrightnessPosition];
  [self updateCrosshairPosition];
}

-(void)updateBrightnessPosition {
  currentBrightness = _color.brightness;
  CGPoint brightnessPosition;
  brightnessPosition.x = (1.0-currentBrightness)*_gradientView.frame.size.width + _gradientView.frame.origin.x;
  brightnessPosition.y = _gradientView.center.y;
  _brightnessBar.center = brightnessPosition;
}

-(void)updateCrosshairPosition {
  currentHue = _color.hue;
  currentSaturation = _color.saturation;
  
  CGPoint hueSatPosition;
  
  hueSatPosition.x = (currentHue*_hueSatImage.frame.size.width)+_hueSatImage.frame.origin.x;
  hueSatPosition.y = (1.0-currentSaturation)*_hueSatImage.frame.size.height+_hueSatImage.frame.origin.y;
  
  _crossHairs.center = hueSatPosition;
}

-(void)updateGradientColor {
  UIColor *gradientColor = [UIColor colorWithHue: currentHue
                                      saturation: currentSaturation
                                      brightness: 0.5
                                           alpha:1.0];
	
	[_gradientView setColor:gradientColor];
}

- (void) updateHueSatWithMovement : (CGPoint) position {
  
	currentHue = (position.x-_hueSatImage.frame.origin.x)/_hueSatImage.frame.size.width;
	currentSaturation = 1.0 -  (position.y-_hueSatImage.frame.origin.y)/_hueSatImage.frame.size.height;
  
	UIColor *_tcolor = [UIColor colorWithHue:currentHue
                                saturation:currentSaturation
                                brightness:currentBrightness
                                     alpha:1.0];
  [self _setColor:_tcolor];
	
  _colorSwatch.swatchColor = _color;
}

- (void) updateBrightnessWithMovement : (CGPoint) position {
	
	currentBrightness = 1.0 - ((position.x - _gradientView.frame.origin.x)/_gradientView.frame.size.width) ;
	
	UIColor *_tcolor = [UIColor colorWithHue:currentHue
                                saturation:currentSaturation
                                brightness:currentBrightness
                                     alpha:1.0];
  [self _setColor:_tcolor];
	
  _colorSwatch.swatchColor = _color;
}

#pragma mark -
#pragma mark Touch Handling

// Handles the start of a touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	for (UITouch *touch in touches) {
		[self dispatchTouchEvent:[touch locationInView:self.view]];
  }
}

// Handles the continuation of a touch.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
	for (UITouch *touch in touches){
		[self dispatchTouchEvent:[touch locationInView:self.view]];
	}
	
}

-(void) dispatchTouchEvent:(CGPoint)position
{
	if (CGRectContainsPoint(_hueSatImage.frame,position)) {
    _crossHairs.center = position;
    
		[self updateHueSatWithMovement:position];
	}
	else if (CGRectContainsPoint(_gradientView.frame, position)) {
    _brightnessBar.center = CGPointMake(position.x, _gradientView.center.y);
		[self updateBrightnessWithMovement:position];
	}
}

#pragma mark -
#pragma mark IBActions

- (IBAction) chooseSelectedColor {
  [_delegate colorPickerViewController:self didSelectColor:self.color];
}

- (IBAction) cancelColorSelection {
  [_delegate colorPickerViewControllerDidCancel:self];
}

@end
