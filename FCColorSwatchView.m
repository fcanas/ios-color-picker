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

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupLayers];
  }
  return self;
}

- (id)init {
  self = [super init];
  if (self) {
    [self setupLayers];
  }
  return self;
}

-(void)setupLayers {
  CALayer *layer = self.layer;
  [layer setBackgroundColor:self.color.CGColor];
  [layer setCornerRadius:7];
  [layer setBorderWidth:1.0f];
  [layer setBorderColor:[UIColor grayColor].CGColor];
}

-(void)setColor:(UIColor *)swatchColor {
  if (_color != swatchColor) {
    [swatchColor retain];
    [_color release];
    _color = swatchColor;
    [self.layer setBackgroundColor:_color.CGColor];
  }
}

- (void)dealloc {
    self.color = nil;
    [super dealloc];
}

@end
