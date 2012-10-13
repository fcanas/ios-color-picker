//
//  ColorPickerViewController.h
//  ColorPicker
//
//  Created by Gilly Dekel on 23/3/09.
//  Extended by Fabián Cañas August 2010.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorPickerViewController, FCBrightDarkGradView, FCColorSwatchView;


@protocol ColorPickerViewControllerDelegate <NSObject>

- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color;
- (void)colorPickerViewControllerDidCancel:(ColorPickerViewController *)colorPicker;

@end


@interface ColorPickerViewController : UIViewController

@property (readwrite, nonatomic, retain) UIColor *color;
@property (nonatomic,assign)	id<ColorPickerViewControllerDelegate> delegate;

@property (readwrite, nonatomic, retain) IBOutlet FCBrightDarkGradView *gradientView;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *hueSatImage;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *crossHairs;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *brightnessBar;
@property (readwrite, nonatomic, retain) IBOutlet FCColorSwatchView *colorSwatch;

- (IBAction) chooseSelectedColor;
- (IBAction) cancelColorSelection;

@end

