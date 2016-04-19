//
//  Banco.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/15/16.
//  Copyright © 2016 seblerom. All rights reserved.
//


import Foundation

class Banco{
    
    var id:String?
    var name:String?
    var secure_thumbnail:String?
    var thumbnail:String?
    
    init(id:String,name:String,secure_thumbnail:String,thumbnail:String) {
        self.id = id
        self.name = name
        self.secure_thumbnail = secure_thumbnail
        self.thumbnail = thumbnail
    }
    
}
