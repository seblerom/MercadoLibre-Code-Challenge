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
    var issuer:CuotaModel.IssuerStruct
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
        var installment_rate:Double?
        var discount_rate:Double?
        var labels:String?
        var min_allowed_amount:Double?
        var max_allowed_amount:Double?
        var recommended_message:String?
        var installment_amount:Double?
        var total_amount:Double?
        
        init(installments:Int,installment_rate:Double,discount_rate:Double,labels:String,min_allowed_amount:Double,max_allowed_amount:Double,recommended_message:String,installment_amount:Double,total_amount:Double){
            
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
    
    init(payment_method_id:String,payment_type_id:String,issuer:CuotaModel.IssuerStruct,payer_costs:[Any]){
        
        self.payment_method_id = payment_method_id
        self.payment_type_id = payment_type_id
        self.issuer = issuer
        self.payer_costs = payer_costs
        
    }
}