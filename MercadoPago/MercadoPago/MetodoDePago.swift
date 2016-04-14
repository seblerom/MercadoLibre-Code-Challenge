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
        }
    }
}
