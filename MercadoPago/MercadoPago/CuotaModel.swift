//
//  CuotaModel.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/17/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation

class CuotaModel {
    
    var payment_method_id:String?
    var payment_type_id:String?
    var issuer = CuotaModel.IssuerStruct.self
    var payer_costs = [Any]()
    
    struct IssuerStruct {
        var id:String?
        var name:String?
        var secure_thumbnail:String?
        var thumbnail:String?
        
        
        init(id:String,name:String,secure_thumbnail:String,thumbnail:String){
            
            self.id = id
            self.name = name
            self.secure_thumbnail = secure_thumbnail
            self.thumbnail = thumbnail
        }
    }
    
    struct payer_costs {
        
        var installments:Int?
        var installment_rate:Int?
        var discount_rate:Int?
        var labels:String?
        var min_allowed_amount:Int?
        var max_allowed_amount:Int?
        var recommended_message:String?
        var installment_amount:Int?
        var total_amount:Int?
        
        init(installments:Int,installment_rate:Int,discount_rate:Int,labels:String,min_allowed_amount:Int,max_allowed_amount:Int,recommended_message:String,installment_amount:Int,total_amount:Int){
            
            self.installments = installments
            self.installment_rate = installment_rate
            self.discount_rate = discount_rate
            self.labels = labels
            self.min_allowed_amount = min_allowed_amount
            self.max_allowed_amount = max_allowed_amount
            self.recommended_message = recommended_message
            self.installment_amount = installment_amount
            self.total_amount = total_amount
            
        }
    }
}