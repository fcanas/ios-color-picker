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

#import "GradientView.h"
#import "UIColor+HSV.h"

@implementation GradientView

@synthesize theColor;


//- (id)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        // Initialization code
//    }
//    return self;
//}


// Returns an appropriate starting point for the demonstration of a linear gradient
CGPoint demoLGStart(CGRect bounds)
{
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.25);
}

// Returns an appropriate ending point for the demonstration of a linear gradient
CGPoint demoLGEnd(CGRect bounds)
{
	return CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.75);
}

- (void) setupGradient { 
	// Create a color equivalent to the current color with brightness maximized
	const CGFloat *c = CGColorGetComponents([[UIColor colorWithHue:[theColor hue] 
                                                      saturation:[theColor saturation]
                                                      brightness:1.0
                                                      alpha:1.0] CGColor]);
	CGFloat colors[] =
	{		
		c[0],c[1],c[2],1.00, //THE COLOR with maximized brightness
		0.0/255.0,0.0/255.0,0.0/255.0,1.0, //BLACK
	};
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	
    if (gradient!=nil) {
        CGGradientRelease(gradient);
    }
	gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
	CGColorSpaceRelease(rgb);
	
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// The clipping rects we plan to use, which also defines the locations of each gradient
	CGRect clips[] =
	{
		CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height),
		//self.frame,
	};
	
	CGPoint points[] =
	{
		CGPointMake(0,0),
		CGPointMake(self.frame.size.width,0),
	};
	// Linear Gradients
	CGPoint start, end;
	
	// Clip to area to draw the gradient, and draw it. Since we are clipping, we save the graphics state
	// so that we can revert to the previous larger area.
	CGContextSaveGState(context);
	CGContextClipToRect(context, clips[0]);
	
	start = points[0];
	end = points[1];
	CGContextDrawLinearGradient(context, gradient, start, end, 0);
	CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
}

- (void)dealloc {
	CGGradientRelease(gradient);
    theColor = nil;
    [super dealloc];
}

@end
