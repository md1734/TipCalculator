//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Mitch Dorfner on 2/1/17.
//  Copyright © 2017 Mitchell Dorfner. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var tips = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    var splits = ["1","2","3","4","5"]
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var pickerView: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return tips.count
        } else {
            return splits.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return tips[row]
        } else {
            return splits[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print(tips[row])
        } else {
            print(splits[row])
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButton(_ sender: UIButton) {
        let tip = tips[pickerView.selectedRow(inComponent: 0)]
        let split = splits[pickerView.selectedRow(inComponent: 1)]
        defaults.set(tip, forKey: TIP_KEY)
        defaults.set(split, forKey: SPLIT_KEY)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //fillArr()
    }
    
    
    

}
