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

    var color = UIColor.blue {
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

    @IBAction func pickColor(_ sender :AnyObject) {
        let colorPicker = FCColorPickerViewController()
        colorPicker.color = color
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    func colorPickerViewController(_ colorPicker: FCColorPickerViewController, didSelect color: UIColor) {
        self.color = color
        dismiss(animated: true, completion: nil)
    }

    func colorPickerViewControllerDidCancel(_ colorPicker: FCColorPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

