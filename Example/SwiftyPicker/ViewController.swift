//
//  ViewController.swift
//  SwiftyPicker
//
//  Created by Fabian Canas on 9/14/15.
//  Copyright © 2015 Fabián Cañas. All rights reserved.
//

import UIKit
import iOS_Color_Picker

class ViewController: UIViewController, FCColorPickerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickColor(sender :AnyObject) {
        let colorPicker = FCColorPickerViewController.colorPicker()
        colorPicker.color = UIColor.blueColor()
        colorPicker.delegate = self
        presentViewController(colorPicker, animated: true, completion: nil)
    }
    
    func colorPickerViewController(colorPicker: FCColorPickerViewController, didSelectColor color: UIColor) {
        
    }

    func colorPickerViewControllerDidCancel(colorPicker: FCColorPickerViewController) {
        
    }
    
}

