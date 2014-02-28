//
//  FCBrightDarkGradView.h
//  ColorPicker
//
//  Created by Fabián Cañas
//  Copyright 2010-2014. All rights reserved.
//

#import "FCBrightDarkGradView.h"

@interface FCBrightDarkGradView () {
    CGGradientRef gradient;
}

@end

@implementation FCBrightDarkGradView

-(void)setColor:(UIColor *)color {
    if (_color != color) {
        _color = [color copy];
        [self setupGradient];
        [self setNeedsDisplay];
    }
}

- (void)setupGradient {
	// Create a color equivalent to the current color with brightness maximized
	const CGFloat *c = CGColorGetComponents([_color CGColor]);
	CGFloat colors[] =
	{
		c[0],c[1],c[2],1.0,
		0.0/255.0,0.0/255.0,0.0/255.0,1.0, // black
	};
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
    if (gradient!=nil) {
        CGGradientRelease(gradient);
    }
	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// The clipping rects we plan to use, which also defines the locations of each gradient
	CGRect clippingRect = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
	
	CGPoint endPoints[] =
	{
		CGPointMake(0,0),
		CGPointMake(self.frame.size.width,0),
	};
	
	// Clip to area to draw the gradient, and draw it. Since we are clipping, we save the graphics state
	// so that we can revert to the previous larger area.
	CGContextSaveGState(context);
	CGContextClipToRect(context, clippingRect);
	
	CGContextDrawLinearGradient(context, gradient, endPoints[0], endPoints[1], 0);
	CGContextRestoreGState(context);
}

- (void)dealloc {
    CGGradientRelease(gradient);
}

@end
