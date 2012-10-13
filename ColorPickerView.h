//
//  ColorPickerView.h
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Extended by Fabián Cañas August 2010.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCColorSwatchView.h"

@class FCBrightDarkGradView;
@interface ColorPickerView : UIView

@property (readwrite, nonatomic, retain) IBOutlet FCBrightDarkGradView *gradientView;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *hueSatImage;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *crossHairs;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *brightnessBar;
@property (readwrite, nonatomic, retain) IBOutlet FCColorSwatchView *showColor;
@property (readwrite) CGFloat currentBrightness;
@property (readwrite) CGFloat currentHue;
@property (readwrite) CGFloat currentSaturation;

- (UIColor *) getColorShown;
- (void) setColor:(UIColor *)color;

@end
