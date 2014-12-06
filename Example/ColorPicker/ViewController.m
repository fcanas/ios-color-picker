//
//  ViewController.m
//  ColorPicker
//
//  Created by Fabian Canas on 12/6/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "ViewController.h"

#import <iOS-Color-Picker/FCColorPickerViewController.h>

@interface ViewController () <FCColorPickerViewControllerDelegate>
@property (nonatomic, copy) UIColor *color;
@end

@implementation ViewController

- (IBAction)pickColor:(id)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPickerWithColor:self.color
                                                                                        delegate:self];
    colorPicker.tintColor = [UIColor whiteColor];
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker
                       animated:YES
                     completion:nil];
}

- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setColor:(UIColor *)color
{
    _color = [color copy];
    [self.view setBackgroundColor:_color];
}

@end
