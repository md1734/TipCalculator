//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mitch Dorfner on 1/21/17.
//  Copyright © 2017 Mitchell Dorfner. All rights reserved.
//

import UIKit

let SPLIT_KEY = "SPLIT_KEY"
let TIP_KEY = "TIP_KEY"

class ViewController: UIViewController {
    
    var dollars = 0.0
    var tipPercentage = 0
    var totalCheck = 0.0
    var tipAmount = 0.0
    var splitNum = 1
    var splitTip = 0.0
    var splitCheck = 0.0
    var tipPercentDef = 15
    var splitSizeDef = 1
    
    //let splitDef =
    //let tipDef = 15
    
    let fmt = NumberFormatter()
    let defaults = UserDefaults.standard

    @IBOutlet weak var checkAmount: UITextField!
    @IBOutlet weak var tipPercent: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipAmt: UITextField!
    @IBOutlet weak var checkTotal: UITextField!
    @IBOutlet weak var tipSplit: UITextField!
    @IBOutlet weak var checkSplit: UITextField!
    @IBOutlet weak var splitDefault: UISegmentedControl!
    
    
    @IBAction func calcButton(_ sender: UIButton) {
        checkAmount.resignFirstResponder()
        tipCalc()
        updateUI()
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        checkAmount.text = nil
        tipPercentage = tipPercentDef
        tipPercent.text = String(tipPercentage) + "%"
        tipAmt.text = nil
        checkTotal.text = nil
        tipSplit.text = nil
        checkSplit.text = nil
        splitDefault.selectedSegmentIndex = splitSizeDef
        tipSlider.value = Float(tipPercentage)
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        splitNum = sender.selectedSegmentIndex + 1
        tipCalc()
        updateUI()
    }
    
    
    @IBAction func tipSlider(_ sender: Any) {
        tipPercentage = Int(tipSlider.value)
        tipPercent.text = String(tipPercentage) + "%"
        tipCalc()
        updateUI()
    }
    
    func tipCalc() {
        let checkAmt = checkAmount.text!
        if let temp = Double(checkAmt) {
            dollars = temp
        } else {
            dollars = 0.0
        }
        totalCheck = dollars * (Double(tipPercentage)/100) + dollars
        tipAmount = totalCheck - dollars
        splitTip = (tipAmount)/Double(splitNum)
        splitCheck = (totalCheck)/Double(splitNum)
    }
    
    func updateUI() {
        tipAmt.text = fmt.string(for: tipAmount)
        checkTotal.text = fmt.string(for: totalCheck)
        tipSplit.text = fmt.string(for: splitTip)
        checkSplit.text = fmt.string(for: splitCheck)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fmt.numberStyle = .currency
        tipPercentage = Int(tipSlider.value)
        tipPercent.text = String(tipPercentage) + "%"
        //getDefaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDefaults()
    }

    func getDefaults() {
        if  let tipD = defaults.string(forKey: TIP_KEY),
            let splitD = defaults.string(forKey: SPLIT_KEY),
            let t = Int(splitD), let s = Int(tipD){
            splitDefault.selectedSegmentIndex = t - 1
            tipSlider.value = Float(s)
            tipPercent.text = tipD + "%"
            tipPercentDef = Int(tipD)!
            splitSizeDef = splitDefault.selectedSegmentIndex
        } else {
            tipPercentage = 15
            tipSlider.value = 15
            splitDefault.selectedSegmentIndex = splitSizeDef
            defaults.set(tipSlider.value, forKey: TIP_KEY)
            defaults.set(splitSizeDef, forKey: SPLIT_KEY)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

