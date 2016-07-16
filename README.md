# iOS Color Picker

[![Version](https://img.shields.io/cocoapods/v/iOS-Color-Picker.svg?style=flat)](http://cocoadocs.org/docsets/iOS-Color-Picker)
[![License](https://img.shields.io/cocoapods/l/iOS-Color-Picker.svg?style=flat)](http://cocoadocs.org/docsets/iOS-Color-Picker)
[![Platform](https://img.shields.io/cocoapods/p/iOS-Color-Picker.svg?style=flat)](http://cocoadocs.org/docsets/iOS-Color-Picker)

A reusable color picker component for iOS. Works for iPhone, iPad, in modal sheets, popovers... just about anywhere.

# Using iOS-Color-Picker

## Installation

The easiest way to use iOS-Color-Picker is with [CocoaPods](http://cocoapods.org). Add the following line to your `Podfile`.

```ruby
pod 'iOS-Color-Picker'
```

Otherwise, you need to include the following files in your project:

* `FCColorPickerViewController.h`
* `FCColorPickerViewController.m`
* `FCColorPickerViewController.xib`
* `Resources/colormap.png`

## Using a Color Picker from a View Controller

Suppose you have a view controller with a `color` property you'd like to let the user pick. 
Make your view controller implement the `FCColorPickerViewControllerDelegate` protocol. Handle the color picked and the cancelled methods, and make a method that triggers showing the view controller.

```objc
-(IBAction)chooseColor:(id)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPicker];
    colorPicker.color = self.color;
    colorPicker.delegate = self;
    
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker animated:YES completion:nil];
}

#pragma mark - FCColorPickerViewControllerDelegate Methods

-(void)colorPickerViewController:(FCColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
```

The color picker has `tintColor` and `backgroundColor` properties for configuring its appearance.

# Screenshots

### iPhone
<img src="https://raw.github.com/fcanas/ios-color-picker/master/Screenshots/color-picker-iphone-5.png" alt="iPhone 5" width="414" />
<!--![](/Screenshots/color-picker-iphone-5.png) -->

<img src="https://raw.github.com/fcanas/ios-color-picker/master/Screenshots/color-picker-iphone-4.png" alt="iPhone 5" width="396" />
<!--![](/Screenshots/color-picker-iphone-4.png)-->

### iPad
<img src="https://raw.github.com/fcanas/ios-color-picker/master/Screenshots/color-picker-ipad.png" alt="iPhone 5" width="1136" />
<!--![](/Screenshots/color-picker-ipad.png) -->

<img src="https://raw.github.com/fcanas/ios-color-picker/master/Screenshots/color-picker-ipad-landscape.png" alt="iPhone 5" width="1136" />
<!--![](/Screenshots/color-picker-ipad-landscape.png)-->

# Example Project

An example project is included in `/Example`. Run `pod install` in the example directory to configure the project, then open the Xcode workspace.

