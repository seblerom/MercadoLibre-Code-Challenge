//
//  PaymentMethod.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/14/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation

class PaymentMethod{
    
    
    var id:String?
    var deferred_capture:String?
    var additional_info_needed = [String]()
    var payment_type_id:String?
    var accreditation_time:Int?
    var settings = [Any]()
    
    var max_allowed_amount:Int?
    var min_allowed_amount:Int?
    var secure_thumbnail:String?
    var thumbnail:String?
    var name:String?
    var status:String?
    
    struct bin {
        var pattern:String?
        var installments_pattern:String?
        var exclusion_pattern:String?
        
        init(pattern:String,installments_pattern:String,exclusion_pattern:String){
            self.pattern = pattern
            self.installments_pattern = installments_pattern
            self.exclusion_pattern = exclusion_pattern
        }
    }
    
    struct card_number {
        var validation:String?
        var length:Int?
        
        init(validation:String,length:Int){
            self.validation = validation
            self.length = length
        }
    }
    
    struct security_code {
        var mode:String?
        var card_location:String?
        var length:Int?
        
        init(mode:String,card_location:String,length:Int){
            self.mode = mode
            self.card_location = card_location
            self.length = length
        }
    }
    
    init(id:String,deferred_capture:String,additional_info_needed:([String]),payment_type_id:String,accreditation_time:Int,settings:([Any]),max_allowed_amount:Int,min_allowed_amount:Int,secure_thumbnail:String,thumbnail:String,name:String,status:String){
    
        self.id = id
        self.deferred_capture = deferred_capture
        self.additional_info_needed = additional_info_needed
        self.payment_type_id = payment_type_id
        self.accreditation_time = accreditation_time
        self.settings = settings
        self.max_allowed_amount = max_allowed_amount
        self.min_allowed_amount = min_allowed_amount
        self.secure_thumbnail = secure_thumbnail
        self.thumbnail = thumbnail
        self.name = name
        self.status = status
    }
}
