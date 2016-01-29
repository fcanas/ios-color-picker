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

    var color = UIColor.blueColor() {
        didSet {
            self.view?.backgroundColor = color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickColor(sender :AnyObject) {
        let colorPicker = FCColorPickerViewController()
        colorPicker.color = color
        colorPicker.delegate = self
        presentViewController(colorPicker, animated: true, completion: nil)
    }
    
    func colorPickerViewController(colorPicker: FCColorPickerViewController, didSelectColor color: UIColor) {
        self.color = color
        dismissViewControllerAnimated(true, completion: nil)
    }

    func colorPickerViewControllerDidCancel(colorPicker: FCColorPickerViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

