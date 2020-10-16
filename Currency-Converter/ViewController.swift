//
//  ViewController.swift
//  Currency-Converter
//
//  Created by Nicholas Lee on 2020-09-19.
//

import UIKit

class ViewController: UIViewController{
    
    // base currency is euro "EUR"
    // convert to euro, then to desired currency
    // math ex: CAD -> EUR -> USD is CAD/rate = EUR -> EUR*rate = USD
    
    var toBeConverted = 1.0
    var firstToEurRate = 1.0{
        didSet{
            toBeConverted /= firstToEurRate
        }
    }
    var eurToSecond = 1.0{
        didSet{
            toBeConverted *= eurToSecond
            result.text = String(round(100*toBeConverted)/100)
        }
    }
    
    let converter = Converter();
    
    @IBOutlet weak var firstCurrency: UITextField!
    @IBOutlet weak var secondCurrency: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var CovertButton: UIButton!
    
    
    @IBAction func convertButton(_ sender: UIButton) {
        guard let firstCurrencyType = firstCurrency.text else{
            return;
        }
        
        guard let secondCurrencyType = secondCurrency.text else {
            return;
        }
        
        guard let numberEntered = amount.text else{
            return;
        }
        
        let convertThisNumber = Double(numberEntered) ?? 0.00
        toBeConverted = convertThisNumber
        
        converter.getRates(firstCurrency: firstCurrencyType, secondCurrency: secondCurrencyType, theViewController: self)
        
        
    }
    
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    
    let currencyTypes = ["AUD", "CAD", "CHF", "CHN", "EUR", "GBP", "HKD", "JPY", "NZD", "MXN", "USD", "BTC"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firstCurrency.inputView = pickerView1
        secondCurrency.inputView = pickerView2
        
        CovertButton.layer.cornerRadius = CovertButton.frame.size.height/2
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView1.tag = 1
        pickerView2.tag = 2
        
    }
    
    public func somethingWrong(error: Error){
        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            firstCurrency.text = currencyTypes[row]
            firstCurrency.resignFirstResponder()
        } else{
            secondCurrency.text = currencyTypes[row]
            secondCurrency.resignFirstResponder()
        }
    }
    
}


