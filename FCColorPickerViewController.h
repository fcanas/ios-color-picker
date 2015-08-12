//
//  ColorPickerViewController.h
//  ColorPicker
//
//  Created by Fabián Cañas
//  Based on work by Gilly Dekel on 23/3/09
//  Copyright 2010-2014. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `FCColorPickerViewController` is a view controller that displays a color picker to the user.

 To use it, instantiate a `FCColorPickerViewController` with one of the class constructors, set a delegate that
 implements the `FCColorPickerViewControllerDelegate` protocol, and present the color picker however you wish,
 *e.g.* modally full screen, modally in a form, in a popover, etc. You are responsible for dismissing the color
 picker when the user finishes picking a color. The delegate methods in the `FCColorPickerViewControllerDelegate`
 protocol and the `color` property of the color picker provide a reference to the color the user picked.
 */
@class FCColorPickerViewController, FCBrightDarkGradView, FCColorSwatchView;

/**
 The delegate of an `FCColorPickerViewController` must adopt the `FCColorPickerViewControllerDelegate` protocol.

 The primary responsibility of the delegate is hiding or dismissing the picker controller when the picker has finished.
 The delegate is the object that is told which color the picker picked.
 */
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

/// @name Initializing a Color Picker object

/**
 Creates and returns a color picker.
 */
+ (nonnull instancetype)colorPicker;

/**
 Creates and returns a color picker initialized with the provided color and delegate.
 @paran color The initial value for the color picker's `color` property. The color picker will represent this color when presented.
 @param delegate An object implementing the `FCColorPickerViewControllerDelegate` protocol to act as the picker's delegate
 @see -color,
 @see -delegate
 */
+ (instancetype)colorPickerWithColor:(nullable UIColor *)color delegate:(nullable id<FCColorPickerViewControllerDelegate>) delegate;

/// @name The Color

/**
 The color that the picker is representing.

 Its value changes as the user interacts with the picker, and changing the property will update the UI accordingly.
 */
@property (readwrite, nonatomic, copy, nullable) UIColor *color;

/// @name Managing the Delegate

/**
 The object that acts as the delegate of the receiving color picker.

 The delegate must adopt the `FCColorPickerViewControllerDelegate` protocol. The delegate is not retained.

 @see FCColorPickerViewControllerDelegate protocol
 */
@property (nonatomic, weak, nullable) id<FCColorPickerViewControllerDelegate> delegate;

/// @name Controlling the Color Picker's Appearance

/**
 The view controller's background color.

 The default value is nil, which results in a dark gray color on iPhones, and a clear color on iPads.
 @see -tintColor
 */
@property (nonatomic, copy, nullable) UIColor *backgroundColor;

/**
 The view controller's tint color.

 Updates to the `tintColor` property are forwarded to the color picker's view. The tint color affects the coloring of the "Choose" and "Cancel" buttons in iOS 7. Below iOS 7, this property has no effect.
 `tintColor` is initially derived from the view hierarchy in the normal way for views iOS 7+. Setting this property to `nil` restores this behavior.
 @see -backgroundColor
 */
@property (nonatomic, copy, null_resettable) UIColor *tintColor;

@end

NS_ASSUME_NONNULL_END
