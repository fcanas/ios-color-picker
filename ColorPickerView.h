//
//  ColorPickerView.h
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Extended by Fabián Cañas August 2010.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorSwatchView.h"

@class GradientView;
@interface ColorPickerView : UIView {
	GradientView *gradientView;
	IBOutlet ColorSwatchView *showColor;
	IBOutlet UIImageView *crossHairs;
	IBOutlet UIImageView *brightnessBar;
}

@property (readwrite) CGFloat currentBrightness;
@property (readwrite) CGFloat currentHue;
@property (readwrite) CGFloat currentSaturation;

- (UIColor *) getColorShown;
- (void) setColor:(UIColor *)color;
- (void) animateView:(UIImageView *)theView toPosition:(CGPoint) thePosition;

@end
