# iOS Color Picker

A reusable color picker component for iOS. Works for iPhone, iPad, in modal sheets, popovers... just about anywhere.

# Using iOS-Color-Picker

## Installation

The easiest way to use iOS-Color-Picker is with [CocoaPods](http://cocoapods.org). Add the following line to your `Podfile`.

```
pod 'iOS-Color-Picker'
```

## Using a Color Picker from a View Controller

Suppose you have a view controller with a `color` property you'd like to let the user pick. 
Make your view controller implement the `FCColorPickerViewControllerDelegate` protocol. Handle the color picked and the cancelled methods, and make a method that triggers showing the view controller.

```
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

# Screenshots

### iPhone

![](/Screenshots/color-picker-iphone-5.png) 

![](/Screenshots/color-picker-iphone-4.png)

### iPad

![](/Screenshots/color-picker-ipad.png) 

![](/Screenshots/color-picker-ipad-landscape.png)

# Dependencies

[UIColor-Utilities](https://github.com/fcanas/uicolor-utilities)

When using [CocoaPods](http://cocoapods.org), the `UIColor-Utilities` dependency is handled automatically.

# Example Project

[iOS Color Picker Example](https://github.com/fcanas/ios-color-picker-example)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/fcanas/ios-color-picker/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

