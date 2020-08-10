//
//  ViewController.swift
//  Trainer
//
//  Created by Andreas Svedstedt on 2020-06-17.
//  Copyright © 2020 Andreas Svedstedt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var color = true
    var index : Int = 1
    var timer : Timer?
    var stopped = true
    var useNumbers = true
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var interval: UISlider!
    @IBOutlet weak var amount: UISlider!
    @IBOutlet weak var startbut: UIButton!
    @IBOutlet weak var useColor: UISwitch!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    @IBAction func stopPressed(_ sender: UIButton) {
        if let timer = self.timer
            {
                startbut.setTitle("Start", for: .normal)
                timer.invalidate()
                stopped = true
                index = 1
            }
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        
        if stopped{
            startbut.setTitle("Running..", for: .normal)
            stopped = false
            index = 1
            if useNumbers {number.text = "1"}
            if color{self.view.backgroundColor = UIColor.green}
            let inte = round(interval.value)
            let interv = Double(inte)
            timer = Timer.scheduledTimer(timeInterval: interv, target: self, selector: #selector(ViewController.updateLabel), userInfo: nil, repeats: true)
            }
        }
    
    @objc func updateLabel(){
        index += 1
        if index <= Int(amount.value){
            if useNumbers{
                number.text = String(index)
                
            }
            if !useNumbers{
                number.text = " "
            }
            if color {
            self.view.backgroundColor = switchColor(index: index)
            }
         
        }
        else {
            index = 1
            if useNumbers {number.text = String(index)}
            if color {
                self.view.backgroundColor = switchColor(index: index)}
        }
    }
    
    func switchColor(index:Int) -> UIColor{
        switch(index){
            case 1 : return UIColor.green
            case 2 : return UIColor.red
            case 3 : return UIColor.blue
            case 4 : return UIColor.yellow
            case 5 : return UIColor.brown
            default: return UIColor.white
        }
    }
    
    func manStop() {
        if let timer = self.timer
            {
                timer.invalidate()
                 startbut.setTitle("Start", for: .normal)
                stopped = true
            }
    }
    //amount slider
    @IBAction func slidingSlider(_ sender: UISlider) {
        let val = Int(amount.value)
        let valStr = String(val)
        amountLabel.text = valStr
    }
    
    @IBAction func slidingIntSlider(_ sender: UISlider) {
    let a = round(interval.value)
    let val = Int(a)
    let valStr = String(val)
    intervalLabel.text = valStr + " sec"
    manStop()
    }
    
    @IBAction func switchedCol(_ sender: UISwitch) {
    color = !color
        if color && stopped {
        self.view.backgroundColor = switchColor(index: 1)
        }
        else if color && !stopped{
            self.view.backgroundColor = switchColor(index: index)
        }
        else{
        self.view.backgroundColor = UIColor.white
        }
        
    }
    @IBAction func UseNumSwitched(_ sender: UISwitch) {
        useNumbers = !useNumbers
        if !useNumbers {
            number.text = " "
        }
        else{number.text = String(index)}
    }
}

