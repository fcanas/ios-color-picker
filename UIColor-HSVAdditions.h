//
//  UIColor-HSVAdditions.h
//
//  Created by Matt Reagan (bravobug.com) on 12/31/09.
//  
//

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


#import <UIKit/UIKit.h>

#import "UIColor-Expanded.h"
//  get it here:
//  http://github.com/ars/uicolor-utilities

#define MIN3(x,y,z)  ({\
__typeof__ (x) _x = (x);\
__typeof__ (y) _y = (y);\
__typeof__ (z) _z = (z);\
(_y) <= (_z) ? \
((_x) <= (_y) ? (_x) : (_y)) \
: \
((_x) <= (_z) ? (_x) : (_z)); })

#define MAX3(x,y,z)  ({\
__typeof__ (x) _x = (x);\
__typeof__ (y) _y = (y);\
__typeof__ (z) _z = (z);\
(_y) >= (_z) ? \
((_x) >= (_y) ? (_x) : (_y)) \
: \
((_x) >= (_z) ? (_x) : (_z)); })

struct rgb_color {
    CGFloat r, g, b;
};

struct hsv_color {
    CGFloat hue;        
    CGFloat sat;        
    CGFloat val;        
};

@interface UIColor (UIColor_HSVAdditions)

@property (nonatomic, readonly) CGFloat hue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat saturation; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat brightness; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat value; // (same as brightness, added for naming consistency)


//workhorse method, does conversion:
+(struct hsv_color)HSVfromRGB:(struct rgb_color)rgb;
//individual value accessors:
-(CGFloat)hue;
-(CGFloat)saturation;
-(CGFloat)brightness;
-(CGFloat)value;
@end
