//
//  ColorPickerViewController.m
//  ColorPicker
//
//  Created by Fabián Cañas
//  Based on work by Gilly Dekel on 23/3/09
//  Copyright 2010-2014. All rights reserved.
//

#import "FCColorPickerViewController.h"
#import "FCBrightDarkGradView.h"
#import "FCColorSwatchView.h"

@interface FCColorPickerViewController () {
	CGFloat currentBrightness;
	CGFloat currentHue;
	CGFloat currentSaturation;
    BOOL viewIsLoaded;
}

@property (readwrite, nonatomic, strong) IBOutlet FCBrightDarkGradView *gradientView;
@property (readwrite, nonatomic, strong) IBOutlet UIImageView *hueSatImage;
@property (readwrite, nonatomic, strong) IBOutlet UIView *crossHairs;
@property (readwrite, nonatomic, strong) IBOutlet UIView *brightnessBar;
@property (readwrite, nonatomic, strong) IBOutlet FCColorSwatchView *swatch;

- (IBAction) chooseSelectedColor;
- (IBAction) cancelColorSelection;

@end

@implementation FCColorPickerViewController

+ (instancetype)colorPicker {
    return [[self alloc] initWithNibName:@"FCColorPickerViewController" bundle:nil];
}

+ (instancetype)colorPickerWithColor:(UIColor *)color delegate:(id<FCColorPickerViewControllerDelegate>) delegate {
    FCColorPickerViewController *picker = [self colorPicker];
    picker.color = color;
    picker.delegate = delegate;
    return picker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:_crossHairs];
    [self.view bringSubviewToFront:_brightnessBar];
    viewIsLoaded = YES;
    
    UIColor *edgeColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    
    self.crossHairs.layer.cornerRadius = 19;
    self.crossHairs.layer.borderColor = edgeColor.CGColor;
    self.crossHairs.layer.borderWidth = 2;
    self.crossHairs.layer.shadowColor = [UIColor blackColor].CGColor;
    self.crossHairs.layer.shadowOffset = CGSizeZero;
    self.crossHairs.layer.shadowRadius = 1;
    self.crossHairs.layer.shadowOpacity = 0.5;
    
    self.brightnessBar.layer.cornerRadius = 9;
    self.brightnessBar.layer.borderColor = edgeColor.CGColor;
    self.brightnessBar.layer.borderWidth = 2;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setColor:_color];
    [self updateBrightnessPosition];
    [self updateGradientColor];
    [self updateCrosshairPosition];
    _swatch.color = _color;
    self.tintColor = self.tintColor;
    self.backgroundColor = self.backgroundColor;
}

- (void)viewWillLayoutSubviews {
    [self updateBrightnessPosition];
    [self updateCrosshairPosition];
}

#pragma mark - Appearance

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = [tintColor copy];
    if (!viewIsLoaded) {
        return;
    }
    if ([self.view respondsToSelector:@selector(setTintColor:)]) {
        [self.view setTintColor:_tintColor];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = [backgroundColor copy];
    if (viewIsLoaded) {
        if (_backgroundColor != nil) {
            self.view.backgroundColor = _backgroundColor;
        } else {
            self.view.backgroundColor = [[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone?[UIColor darkGrayColor]:[UIColor clearColor];
        }
    }
}

#pragma mark - Color Manipulation

- (void)_setColor:(UIColor *)newColor {
    if (![_color isEqual:newColor]) {
        
        CGFloat brightness;
        [newColor getHue:NULL saturation:NULL brightness:&brightness alpha:NULL];
        CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(CGColorGetColorSpace(newColor.CGColor));
        if (colorSpaceModel==kCGColorSpaceModelMonochrome) {
            const CGFloat *c = CGColorGetComponents(newColor.CGColor);
            _color = [UIColor colorWithHue:0
                                saturation:0
                                brightness:c[0]
                                     alpha:1.0];
        } else {
            _color = [newColor copy];
        }
        
        _swatch.color = _color;
    }
}

- (void)setColor:(UIColor *)newColor {
    
    CGFloat hue, saturation;
    [newColor getHue:&hue saturation:&saturation brightness:NULL alpha:NULL];

    currentHue = hue;
    currentSaturation = saturation;
    [self _setColor:newColor];
    [self updateGradientColor];
    [self updateBrightnessPosition];
    [self updateCrosshairPosition];
}

- (void)updateBrightnessPosition {
    [_color getHue:NULL saturation:NULL brightness:&currentBrightness alpha:NULL];
    
    CGPoint brightnessPosition;
    brightnessPosition.x = (1.0-currentBrightness)*_gradientView.frame.size.width + _gradientView.frame.origin.x;
    brightnessPosition.y = _gradientView.center.y;
    _brightnessBar.center = brightnessPosition;
}

- (void)updateCrosshairPosition {
    CGPoint hueSatPosition;
    
    hueSatPosition.x = (currentHue*_hueSatImage.frame.size.width)+_hueSatImage.frame.origin.x;
    hueSatPosition.y = (1.0-currentSaturation)*_hueSatImage.frame.size.height+_hueSatImage.frame.origin.y;
    
    _crossHairs.center = hueSatPosition;
    [self updateGradientColor];
}

- (void)updateGradientColor {
    UIColor *gradientColor = [UIColor colorWithHue: currentHue
                                        saturation: currentSaturation
                                        brightness: 1.0
                                             alpha:1.0];
	
    _brightnessBar.layer.backgroundColor = _color.CGColor;
    _crossHairs.layer.backgroundColor = gradientColor.CGColor;
    
	[_gradientView setColor:gradientColor];
}

- (void)updateHueSatWithMovement:(CGPoint) position {
    
	currentHue = (position.x-_hueSatImage.frame.origin.x)/_hueSatImage.frame.size.width;
	currentSaturation = 1.0 -  (position.y-_hueSatImage.frame.origin.y)/_hueSatImage.frame.size.height;
    
	UIColor *_tcolor = [UIColor colorWithHue:currentHue
                                  saturation:currentSaturation
                                  brightness:currentBrightness
                                       alpha:1.0];
    UIColor *gradientColor = [UIColor colorWithHue: currentHue
                                        saturation: currentSaturation
                                        brightness: 1.0
                                             alpha:1.0];
	
    
    _crossHairs.layer.backgroundColor = gradientColor.CGColor;
    [self updateGradientColor];
    
    [self _setColor:_tcolor];
	
    _swatch.color = _color;
    _brightnessBar.layer.backgroundColor = _color.CGColor;
}

- (void)updateBrightnessWithMovement:(CGPoint) position {
	
	currentBrightness = 1.0 - ((position.x - _gradientView.frame.origin.x)/_gradientView.frame.size.width) ;
	
	UIColor *_tcolor = [UIColor colorWithHue:currentHue
                                  saturation:currentSaturation
                                  brightness:currentBrightness
                                       alpha:1.0];
    [self _setColor:_tcolor];
    
	_brightnessBar.layer.backgroundColor = _color.CGColor;
    _swatch.color = _color;
}

#pragma mark - Touch Handling

// Handles the start of a touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches) {
		[self dispatchTouchEvent:[touch locationInView:self.view]];
    }
}

// Handles the continuation of a touch.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in touches){
		[self dispatchTouchEvent:[touch locationInView:self.view]];
	}
}

- (void)dispatchTouchEvent:(CGPoint)position {
	if (CGRectContainsPoint(_hueSatImage.frame,position)) {
        _crossHairs.center = position;
		[self updateHueSatWithMovement:position];
	} else if (CGRectContainsPoint(_gradientView.frame, position)) {
        _brightnessBar.center = CGPointMake(position.x, _gradientView.center.y);
		[self updateBrightnessWithMovement:position];
	}
}

#pragma mark - IBActions

- (IBAction)chooseSelectedColor {
    [_delegate colorPickerViewController:self didSelectColor:self.color];
}

- (IBAction)cancelColorSelection {
    [_delegate colorPickerViewControllerDidCancel:self];
}

@end
