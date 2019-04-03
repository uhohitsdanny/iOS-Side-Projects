//
//  StockManager.swift
//  StockMarket
//
//  Created by Danny Navarro on 12/2/18.
//  Copyright © 2018 Daramji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class StockManager
{
    let apikey = AppDelegate().alphaVApiKey
}

extension StockManager
{
    func getExchangeRates(from f_curr:String, to t_curr:String, completion:@escaping (Bool?, CurrencyExchangeRate?)->Void)
    {
        guard let url = URL(string: "https://www.alphavantage.co/query?")
        else
        {
            completion (nil,nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: ["function" : "CURRENCY_EXCHANGE_RATE",
                                       "from_currency" : f_curr,
                                       "to_currency" : t_curr,
                                       "apikey" : apikey])
        .responseJSON
        { (response) in
            print(response.result.isSuccess)
            guard response.result.isSuccess, let value = response.result.value
            else
            {
                print("Error in the get request to https://www.alphavantage.co/")
                print(response.error?.localizedDescription as Any)
                completion (nil,nil)
                return
            }
            let xchg_rate = CurrencyExchangeRate(jdata: JSON(value)["Realtime Currency Exchange Rate"])
            
            completion (true,xchg_rate)
        }
    }
    
    func getWeeklySeries()
    {
        
    }
}
