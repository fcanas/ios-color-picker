//
//  GradientView.m
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Extended by Fabián Cañas August 2010.
//  Copyright 2010 Fabián Cañas. All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//    * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//    * Neither the name of the <organization> nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//    DISCLAIMED. IN NO EVENT SHALL FABIAN CANAS BE LIABLE FOR ANY
//    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//     LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "FCBrightDarkGradView.h"
#import "UIColor+HSV.h"

@interface FCBrightDarkGradView () {
  CGGradientRef gradient;
}

@end

@implementation FCBrightDarkGradView

-(void)setColor:(UIColor *)color {
  if (_color != color) {
    [color retain];
    [_color release];
    _color = color;
    [self setupGradient];
    [self setNeedsDisplay];
  }
}

- (void) setupGradient { 
	// Create a color equivalent to the current color with brightness maximized
	const CGFloat *c = CGColorGetComponents([[UIColor colorWithHue:[_color hue]
                                                      saturation:[_color saturation]
                                                      brightness:1.0
                                                      alpha:1.0] CGColor]);
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
  self.color = nil;
  [super dealloc];
}

@end
