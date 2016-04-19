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
    
    @IBOutlet var tableview: UITableView!
    var itemBancos:Banco? = nil
    var itemMetodoDePago:PaymentMethod? = nil
    var amount = String()
    var cuotasModelArray:[CuotaModel] = []
    var payer_costs_array:[CuotaModel.payer_costs] = []
    let basicCellIdentifier = "metodosDePagoCell"
    
    
    
    override func viewDidLoad() {
        self.navigationItem.titleView = NavItemTitle.SetTitleView()
        DownloadCuotas()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: notificationKey, object: nil)
        
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
        
        for (_,subJson):(String, JSON) in data {
            
            var payment_method_id = ""
            if subJson["payment_method_id"].exists(){
                payment_method_id = subJson["payment_method_id"].stringValue
            }
            
            var payment_type_id = ""
            if subJson["payment_type_id"].exists(){
                payment_type_id = subJson["payment_type_id"].stringValue
            }
            
            var id = ""
            if subJson["issuer"]["id"].exists(){
                id = subJson["issuer"]["id"].stringValue
            }
            
            var name = ""
            if subJson["issuer"]["name"].exists(){
                name = subJson["issuer"]["name"].stringValue
            }
            
            var secure_thumbnail = ""
            if subJson["issuer"]["secure_thumbnail"].exists(){
                secure_thumbnail = subJson["issuer"]["secure_thumbnail"].stringValue
            }
            
            var thumbnail = ""
            if subJson["issuer"]["thumbnail"].exists(){
                thumbnail = subJson["issuer"]["thumbnail"].stringValue
            }
            
            let issuerStruct = CuotaModel.IssuerStruct(id: id, name: name, secure_thumbnail: secure_thumbnail, thumbnail: thumbnail)
            
            var payerCosts:[Any] = []
            
            let payer = subJson["payer_costs"]
            for (_,payer_costs):(String, JSON) in payer {
                
                
                var installments = 0
                if payer_costs["installments"].exists() {
                    installments = payer_costs["installments"].intValue
                }
                
                var installment_rate = 0.0
                if payer_costs["installment_rate"].exists() {
                    installment_rate = payer_costs["installment_rate"].doubleValue
                }
                
                var discount_rate = 0.0
                if payer_costs["discount_rate"].exists() {
                    discount_rate = payer_costs["discount_rate"].doubleValue
                }
                
                var min_allowed_amount = 0.0
                if payer_costs["min_allowed_amount"].exists() {
                    min_allowed_amount = payer_costs["min_allowed_amount"].doubleValue
                }
                
                var max_allowed_amount = 0.0
                if payer_costs["max_allowed_amount"].exists() {
                    max_allowed_amount = payer_costs["max_allowed_amount"].doubleValue
                }
                
                var installment_amount = 0.0
                if payer_costs["installment_amount"].exists() {
                    installment_amount = payer_costs["installment_amount"].doubleValue
                }
                
                var total_amount = 0.0
                if payer_costs["total_amount"].exists() {
                    total_amount = payer_costs["total_amount"].doubleValue
                }
                
                var recommended_message = ""
                if payer_costs["recommended_message"].exists(){
                    recommended_message = payer_costs["recommended_message"].stringValue
                }
                
                var labels = ""
                if payer_costs["labels"].exists(){
                    if !payer_costs["labels"].isEmpty {
                        labels = payer_costs["labels"].stringValue
                    }
                }
                
                let payer_costs_struct = CuotaModel.payer_costs(installments: installments, installment_rate: installment_rate, discount_rate: discount_rate, labels: labels, min_allowed_amount: min_allowed_amount, max_allowed_amount: max_allowed_amount, recommended_message: recommended_message, installment_amount: installment_amount, total_amount: total_amount)
                
                payerCosts.append(payer_costs_struct)
                self.payer_costs_array.append(payer_costs_struct)
            }
            let modelCuotas = CuotaModel(payment_method_id: payment_method_id, payment_type_id: payment_type_id, issuer: issuerStruct, payer_costs: payerCosts)
            
            self.cuotasModelArray.append(modelCuotas)
            self.reloadTableViewContent()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Seleccione cantidad de cuotas"
        return title
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.payer_costs_array.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return basicCellAtIndexPath(indexPath)
    }
    
    func basicCellAtIndexPath(indexPath:NSIndexPath) -> MetodosDePagoCell {
        let cell = tableview.dequeueReusableCellWithIdentifier(basicCellIdentifier) as! MetodosDePagoCell
        setNameForCell(cell, indexPath: indexPath)
        setImageForCell(cell, indexPath: indexPath)
        return cell
    }
    func setNameForCell(cell:MetodosDePagoCell,indexPath:NSIndexPath){
        let item = self.payer_costs_array[indexPath.row]
        cell.labelName.text = item.recommended_message! ?? "[No subject]"
    }
    
    func setImageForCell(cell:MetodosDePagoCell,indexPath:NSIndexPath){
        let item = self.cuotasModelArray[0]
        if !(item.issuer.thumbnail?.isEmpty)!{
            Connection.downloadThumbnails(item.issuer.thumbnail!, completion: { (image) in
                cell.imageCreditCard.image = image
            })
        }
    }
    
    func SentPostNotification(object:MessageModel){
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey, object: object)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let paymentMethod = itemMetodoDePago!.id as String!
        let banco = itemBancos?.name as String!
        let item = self.payer_costs_array[indexPath.row]
        let cuotas = item.recommended_message as String!
        let messageModel = MessageModel(amount: amount, paymentMethod: paymentMethod, banco: banco, cuotas: cuotas)
        self.navigationController?.popToRootViewControllerAnimated(true)
        SentPostNotification(messageModel)
    }
    
}
