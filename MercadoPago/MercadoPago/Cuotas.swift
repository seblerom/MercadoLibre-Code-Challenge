//
//  Cuotas.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/15/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import SwiftyJSON

class Cuotas: UITableViewController {

    var itemBancos:Banco? = nil
    var itemMetodoDePago:PaymentMethod? = nil
    var amount = String()
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        DownloadCuotas()
    }
    
    func DownloadCuotas(){
        
        let payment_method_id = itemMetodoDePago!.id as String!
        let issuer_id = itemBancos?.id as String!
        let parameters = ["public_key":public_key,"payment_method_id":String(payment_method_id),"issuer.id":String(issuer_id),"amount":amount]
        LoadingAnimations.showProgressHUD(self.view)
        Connection.networkingCallsMaster(installments, parameters: parameters) { response in
            LoadingAnimations.hideProgressHUD(self.view)
            self.createArrayWithInstallments(response)
        }
    }
    
    func createArrayWithInstallments(data:(JSON)){
        
        for (index,subJson):(String, JSON) in data {
            print(index)
            
            var payment_method_id = ""
            if subJson["payment_method_id"].exists(){
                payment_method_id = subJson["payment_method_id"].stringValue
            }
            
            var payment_type_id = ""
            if subJson["payment_type_id"].exists(){
                payment_type_id = subJson["payment_type_id"].stringValue
            }
            
            print(payment_method_id)
            print(payment_type_id)
            
        }
    }
}
