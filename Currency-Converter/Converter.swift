//
//  Converter.swift
//  Currency-Converter
//
//  Created by Nicholas Lee on 2020-09-25.
//

import Foundation
import UIKit


struct Converter{
    
    
    // base currency is euro "EUR"
    // convert to euro, then to desired currency
    // math ex: CAD -> EUR -> USD is CAD/rate = EUR -> EUR*rate = USD
    func getRates(firstCurrency : String, secondCurrency: String, theViewController: ViewController){
        
        
        //what i need to do
        
        //request a session
        //response and data
        //parsing/JSON serialization
        
        
        //request a session
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=dbdb683f51e26b7cf74c5717da4f7423")
        
        //cuz http must change info in plist to allow arbituary loads, see vid
        
        let session = URLSession.shared

        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                theViewController.somethingWrong(error: error!) //send alert to user something went wrong - not 100% sure this is MVC? check later
            } else{
                //response and data
                if data != nil{

                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> //mutable containers like dictionary

                        DispatchQueue.main.sync {
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                if let rate1 = rates[firstCurrency] as? Double{
                                    theViewController.firstToEurRate = rate1
                                }
                                
                                if let rate2 = rates[secondCurrency] as? Double{
                                    theViewController.eurToSecond = rate2
                                }
                            }
                        }

                    }catch{
                        print("error in parsing data")
                    }


                }
            }
        }

        task.resume()
    }
    
}
