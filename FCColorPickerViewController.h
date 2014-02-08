//
//  ColorPickerViewController.h
//  ColorPicker
//
//  Created by Fabián Cañas
//  Based on work by Gilly Dekel on 23/3/09
//  Copyright 2010-2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCColorPickerViewController, FCBrightDarkGradView, FCColorSwatchView;

@protocol ColorPickerViewControllerDelegate <NSObject>

- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color;
- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker;

@end

@interface FCColorPickerViewController : UIViewController

@property (readwrite, nonatomic, copy) UIColor *color;
@property (nonatomic,assign)	id<ColorPickerViewControllerDelegate> delegate;

/**
 The view controller's background color.
 Changes to this property can be animated. The default value is nil, which results in a dark gray color on iPhones, and a clear color on iPads.
 */
@property (nonatomic, copy) UIColor *backgroundColor;

+ (instancetype)colorPicker;

@end

