//
//  ColorPickerViewController.h
//  ColorPicker
//
//  Created by Fabián Cañas
//  Based on work by Gilly Dekel on 23/3/09
//  Copyright 2010-2014. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCColorPickerViewController, FCBrightDarkGradView, FCColorSwatchView;

@protocol FCColorPickerViewControllerDelegate <NSObject>

/**
 Called on the delegate of `colorPicker` when the user has finished selecting a color.
 
 @param colorPicker The `FCColorPickerViewController` that has finished picking a color.
 @param color The color that was picked by the user.
 */
- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color;

/**
 Called on the delegate of `colorPicker` when the user has canceled selecting a color.
 
 @param colorPicker The `FCColorPickerViewController` that has canceled picking a color.
 */
- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker;

@end

@interface FCColorPickerViewController : UIViewController

/**
 The color that the picker is representing.
 
 Its value changes as the user interacts with the picker, and changing the property will update the UI accordingly.
 */
@property (readwrite, nonatomic, copy) UIColor *color;

/**
 The object that acts as the delegate of the receiving color picker.
 
 The delegate must adopt the `FCColorPickerViewControllerDelegate` protocol. The delegate is not retained.
 */
@property (nonatomic,assign) id<FCColorPickerViewControllerDelegate> delegate;

/**
 The view controller's background color.
 
 The default value is nil, which results in a dark gray color on iPhones, and a clear color on iPads.
 @see -tintColor
 */
@property (nonatomic, copy) UIColor *backgroundColor;

/**
 The view controller's tint color.
 
 Updates to the `tintColor` property are forwarded to the color picker's view. The tint color affects the coloring of the "Choose" and "Cancel" buttons in iOS 7. Below iOS 7, this property has no effect.
 `tintColor` is initially nil, and not setting it leaves the color picker to inherit its tint color in the normal way for iOS 7.
 @see -backgroundColor
 */
@property (nonatomic, copy) UIColor *tintColor;


+ (instancetype)colorPicker;

@end

