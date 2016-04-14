//
//  MetodoDePago.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/14/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import SwiftyJSON

class MetodoDePago: UIViewController {
    

    override func viewDidLoad() {
        let parameters = ["public_key":public_key]
        Connection.networkingCallsMaster(paymentMethods, parameters: parameters) { response in
            print(response)
            self.CreateArrayWithPaymentMethods(response)
        }
    }
    
    func CreateArrayWithPaymentMethods(data:(JSON)){
        
        for (index,subJson):(String, JSON) in data {
            let id = subJson["id"].stringValue
            let deferred_capture = subJson["deferred_capture"].stringValue
            
            
            var additionalInfoNeeded = [String]()
            if !subJson["additional_info_needed"].isEmpty {
                for item in subJson["additional_info_needed"] {
                    additionalInfoNeeded.append(String(item))
                }
            }
            
        
            
            
            
            
            
        }
    }
}


/*
 
 var id:String?
 var deferred_capture:String?
 var additional_info_needed = [String]()
 var payment_type_id:String?
 var accreditation_time:Int?
 var settings = [String]()
 
 var max_allowed_amount:Int?
 var min_allowed_amount:Int?
 var secure_thumbnail:String?
 var thumbnail:String?
 var name:String?
 var status:String?
 */