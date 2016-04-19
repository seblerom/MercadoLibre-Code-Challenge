//
//  MessageModel.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/18/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation


class MessageModel{
    
    var amount:String
    var paymentMethod:String
    var banco:String
    var cuotas:String
    
    init(amount:String,paymentMethod:String,banco:String,cuotas:String){
        
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.banco = banco
        self.cuotas = cuotas
        
    }
}