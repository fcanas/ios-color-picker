//
//  ColorSwatchView.m
//  ColorPicker
//
//  Created by Fabián Cañas on 9/9/10.
//  Copyright 2010-2014 Fabián Cañas. All rights reserved.
//

#import "FCColorSwatchView.h"
#import <QuartzCore/QuartzCore.h>

@implementation FCColorSwatchView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLayers];
    }
    return self;
}

-(void)setupLayers {
    CALayer *layer = self.layer;
    UIColor *edgeColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    [layer setBackgroundColor:self.color.CGColor];
    [layer setCornerRadius:7];
    [layer setBorderWidth:2.0f];
    [layer setBorderColor:edgeColor.CGColor];
}

-(void)setColor:(UIColor *)swatchColor {
    if (_color != swatchColor) {
        _color = [swatchColor copy];
        [self.layer setBackgroundColor:_color.CGColor];
    }
}

@end
