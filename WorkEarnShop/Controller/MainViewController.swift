//
//  MainViewController.swift
//  WorkEarnShop
//
//  Created by Saif Khan on 3/14/18.
//  Copyright © 2018 SaifSide Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var hourlyWageTextField: CurrencyTextField!
    @IBOutlet weak var itemCostTextField: CurrencyTextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Private Constants
    fileprivate let maxLengthTextFieldCharacters = 10
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hourlyWageTextField.delegate = self
        self.itemCostTextField.delegate = self
        self.createCalculateButton()
    }
    
    // MARK: - Other
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBAction
    @IBAction func didTapReset(_ sender: UIButton) {
        self.performResetLogic()
    }
    
    // MARK: - Private Methods
    fileprivate func createCalculateButton() {
        
        // Set Button Display Attributes
        let calculateButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 60.0))
        calculateButton.backgroundColor = #colorLiteral(red: 0.3430748697, green: 0.4879504691, blue: 1, alpha: 1)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        // Point to Tap Functionality Method
        calculateButton.addTarget(self, action: #selector(MainViewController.didTapCalculate), for: .touchUpInside)
        
        // Set Input Accessory View to Show Calculate UIButton
        self.hourlyWageTextField.inputAccessoryView = calculateButton
        self.itemCostTextField.inputAccessoryView = calculateButton
    }
    
    @objc fileprivate func didTapCalculate() {
        guard let wageText = self.hourlyWageTextField.text, let costText = itemCostTextField.text else { return }
        
        // Error Checking for 0 Input Value - Crash Prevention
        guard wageText != "0" else { return }
        guard costText != "0" else { return }
        
        // Convert Text into Double(number)
        guard let wage = Double(wageText), let cost = Double(costText) else { return }
        
        // Perform UI Modifications
        self.performAfterCalculationUIDisplayModifications()
        
        // Populate Result
        self.pointsFormatter(resultLabelText: &self.resultLabel.text!, numberOfHours: Wage.getHours(wage: wage, cost: cost))
    }
    
    // Format Number to Include Commas as Resulting Int Increases
    fileprivate func pointsFormatter(resultLabelText: inout String, numberOfHours: Int) {
        let numberOfHours = numberOfHours
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        guard let formattedHours = numberFormatter.string(from: NSNumber(value: numberOfHours)) else { return }
        resultLabelText = formattedHours
    }
    
    fileprivate func performAfterCalculationUIDisplayModifications() {
        // Dismiss Decimal Pad
        self.view.endEditing(true)
        
        // Unhide Labels
        self.resultLabel.isHidden = false
        self.hoursLabel.isHidden = false
        
        // Unhide UIButton
        self.resetButton.isHidden = false
    }
    
    fileprivate func performResetLogic() {
        // Hide Reset UIButton
        self.resetButton.isHidden = true
        
        // Hide UILabels
        self.resultLabel.isHidden = true
        self.hoursLabel.isHidden = true
        
        // Clear UITextFields
        self.hourlyWageTextField.text = ""
        self.itemCostTextField.text = ""
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    // Check if a UITextField is Empty
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !(textField.text?.isEmpty)! {
            self.resetButton.isHidden = false
        } else {
            print("Required UITextFields are empty. Do not show reset button")
        }
    }
    
    // Restrict UITextField Max Length Character Limit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        guard let stringRange = Range(range, in: text) else { return false }
        let newLength = text.replacingCharacters(in: stringRange, with: string)
        return newLength.count <= self.maxLengthTextFieldCharacters
    }
}

