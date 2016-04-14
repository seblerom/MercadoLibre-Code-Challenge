//
//  Connection.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/14/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Connection: NSObject {
    
   class func networkingCallsMaster(base_url:String,parameters:[String:String],completion:((JSON))-> Void){
        
        Alamofire.request(.GET,base_url,parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value{
                    let json = JSON(value)
                    completion(json)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}
