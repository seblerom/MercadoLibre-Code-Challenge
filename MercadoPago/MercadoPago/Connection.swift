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
import AlamofireImage

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
                let value = response.result.value
                let json = JSON(value!)
                completion(json)
            }
        }
    }
    
    class func downloadThumbnails(base_url:String,completion:(UIImage)->Void){
        Alamofire.request(.GET,base_url).responseImage { response in
            guard let img = response.result.value else{
                completion(UIImage())
                return
            }
            completion(img)
        }
        
    }
}
