//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        self.fruitPicker.delegate = self
        self.fruitPicker.dataSource = self
        for component in 0..<self.fruitPicker.numberOfComponents {
            let row = Int(arc4random_uniform(UInt32(390))+10)
            self.fruitPicker.selectRow(row, inComponent: component, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       // return self.fruitsArray.count
        return 400
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let index = row % fruitsArray.count
        return self.fruitsArray[index]
    }
    
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        self.resultLabel.alpha = 1
        var resultArray = [String]()
        for component in 0..<fruitPicker.numberOfComponents {
            let row = Int(arc4random_uniform(UInt32(400)))
            fruitPicker.selectRow(row, inComponent: component, animated: true)
            resultArray.append(fruitsArray[row%fruitsArray.count])
           
        }
        if resultArray[0] == resultArray[1] && resultArray[1] == resultArray[2] {
            
            self.resultLabel.text = "WINNER!"
        }
        else{
            self.resultLabel.text = "TRY AGAIN"
            
        }
      animateTheLabel()
    }
    
    func animateTheLabel() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.repeat,.autoreverse], animations: {
        UIView.setAnimationRepeatCount(6)
            self.resultLabel.alpha = 0
        })
    }
    
}

// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



