//
//  NavItemTitle.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/18/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import Foundation


class NavItemTitle {
    
    class func SetTitleView() -> UIImageView {
        var titleView : UIImageView
        titleView = UIImageView(frame:CGRectMake(0, 0, 120, 33))
        titleView.contentMode = .ScaleAspectFit
        titleView.image = UIImage(named: "mercadoPagoComplete.png")
        
        return titleView
    }
}