//
//  Stock.swift
//  StockMarket
//
//  Created by Danny Navarro on 12/5/18.
//  Copyright © 2018 Daramji. All rights reserved.
//

import SwiftyJSON

class Stock
{
    
}

class CurrencyExchangeRate
{
    var title:String = ""
    var from_currency_code:String = ""
    var from_currency_name:String = ""
    var to_currency_code:String = ""
    var to_currency_name:String = ""
    var exchange_rate:String = ""
    
    init(jdata:JSON)
    {
        title = "CURRENCY EXCHANGE RATE"
        from_currency_code = jdata["1. From_Currency Code"].stringValue
        from_currency_name = jdata["2. From_Currency Name"].stringValue
        to_currency_code = jdata["3. To_Currency Code"].stringValue
        to_currency_name = jdata["4. To_Currency Name"].stringValue
        exchange_rate = jdata["5. Exchange Rate"].stringValue
    }
}
