//
//  ViewController.swift
//  StockMarket
//
//  Created by Danny Navarro on 12/2/18.
//  Copyright © 2018 Daramji. All rights reserved.
//

import UIKit

class Stock_VC: UIViewController {

    // local interface variables
    @IBOutlet weak var fr_pickerview : UIPickerView!
    @IBOutlet weak var to_pickerview : UIPickerView!
    @IBOutlet weak var xchg_label : UILabel!
    @IBOutlet weak var xchg_descrip1_label : UILabel!
    @IBOutlet weak var xchg_descrip2_label : UILabel!

    var stock_manager : StockManager? = nil
    var currencies : [String]!
    var fr_currency : String!
    var to_currency : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mSetup()
    }


}

extension Stock_VC
{
    func mSetup()
    {
        self.stock_manager = StockManager()
        self.currencies = ["USD", "EUR","JPY", "KRW"]
        
        self.xchg_descrip1_label.text = ""
        self.xchg_descrip2_label.text = ""
        // Set the value so it aligns with the first picker view value displayed
        self.fr_currency = self.currencies[0]
        self.to_currency = self.currencies[0]
    }
    
    @IBAction func getXchngData()
    {
        self.stock_manager?.getExchangeRates(from: fr_currency, to: to_currency,completion: { (success,xchg_rate) in
            if let _ = success
            {
                self.xchg_label.text = xchg_rate!.exchange_rate
                self.xchg_descrip1_label.text = xchg_rate!.from_currency_name
                self.xchg_descrip2_label.text = xchg_rate!.to_currency_name
                return
            }
            else
            {
                print("ITS NOT WORKING")
                return
            }
        })
    }
}

// PickerView Delegate Functions
extension Stock_VC : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view {
            label = v as! UILabel
        }
        label.font = UIFont(name: "Tamil Sangam MN", size: 12)
        label.text = currencies[row]
        label.textAlignment = .center
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.fr_pickerview
        {
            self.fr_currency = currencies[row]
        }
        else if pickerView == self.to_pickerview
        {
            self.to_currency = currencies[row]
        }
    }
}
