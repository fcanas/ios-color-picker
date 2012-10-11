//
//  ColorSwatchView.m
//  ColorPicker
//
//  Created by Fabián Cañas on 9/9/10.
//  Copyright 2010 Fabián Cañas. All rights reserved.
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
  [layer setBackgroundColor:self.swatchColor.CGColor];
  [layer setCornerRadius:7];
  [layer setBorderWidth:1.0f];
  [layer setBorderColor:[UIColor grayColor].CGColor];
}

-(void)setSwatchColor:(UIColor *)swatchColor {
  if (_swatchColor != swatchColor) {
    [swatchColor retain];
    [_swatchColor release];
    _swatchColor = swatchColor;
    [self.layer setBackgroundColor:_swatchColor.CGColor];
  }
}

- (void)dealloc {
    self.swatchColor = nil;
    [super dealloc];
}

@end
