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

@property (readwrite, nonatomic, retain) UIColor *color;
@property (nonatomic,assign)	id<ColorPickerViewControllerDelegate> delegate;

@property (readwrite, nonatomic, retain) IBOutlet FCBrightDarkGradView *gradientView;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *hueSatImage;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *crossHairs;
@property (readwrite, nonatomic, retain) IBOutlet UIImageView *brightnessBar;
@property (readwrite, nonatomic, retain) IBOutlet FCColorSwatchView *swatch;

- (IBAction) chooseSelectedColor;
- (IBAction) cancelColorSelection;

@end

