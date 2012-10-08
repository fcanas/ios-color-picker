//
//  ColorSwatchView.m
//  ColorPicker
//
//  Created by Fabián Cañas on 9/9/10.
//  Copyright 2010 Fabián Cañas. All rights reserved.
//

#import "ColorSwatchView.h"
#import <QuartzCore/QuartzCore.h>

// Fill and stroke a round-rect with corner-radius=7 in a context.
// The context's current colors are used.
void drawRoundRect(CGContextRef context, CGRect rect) {
    CGFloat radius = 7;
    CGContextBeginPath(context);
	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);	
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@implementation ColorSwatchView

@synthesize swatchColor;

- (void)drawRect:(CGRect)rect {
    // We only draw when we're drawing the whole swatch. Maybe there's a problem with this?
    if (rect.size.width==self.frame.size.width){

        CGContextRef currentContext = UIGraphicsGetCurrentContext();

        CGColorSpaceRef rgba = CGColorSpaceCreateDeviceRGB();
        
        CGColorRef borderColor = [[UIColor grayColor] CGColor];
        
        CGFloat channelsFill[] = {1.0,1.0,1.0,1.0};

        CGColorRef backgroundFill;
        if (swatchColor!=nil) {
            backgroundFill = [swatchColor CGColor];
        } else {
            backgroundFill = CGColorCreate(rgba, channelsFill);
        }
        
        CGContextSetFillColorWithColor(currentContext, backgroundFill);
        CGContextSetLineWidth(currentContext, 1);
        CGContextSetStrokeColorWithColor(currentContext, borderColor);
        
        CGRect newRect = CGRectMake(rect.origin.x+1, rect.origin.y+1, rect.size.width-2, rect.size.height-2);
        drawRoundRect(currentContext, newRect);
        
        //
        // Clean-up
        //
        CGColorSpaceRelease(rgba);
        
        if (swatchColor==nil) {
            CGColorRelease(backgroundFill);
        }
        // I don't think we need to release the border color since we didn't really create it
        // Releasing causes a fault, so I think we don't really own this ColorRef.
        //CGColorRelease(borderColor);
    }
}


- (void)dealloc {
    self.swatchColor = nil;
    [super dealloc];
}


@end
