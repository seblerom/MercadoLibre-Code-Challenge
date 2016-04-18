//
//  Bancos.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/15/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import SwiftyJSON

class Bancos: UITableViewController {

    @IBOutlet var tableview: UITableView!
    var itemPaymentMethod: PaymentMethod? = nil
    var amount = String()
    var modelArray:[Banco] = []
    let basicCellIdentifier = "metodosDePagoCell"

    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.title = ""
        DownloadPaymentMethods()
    }
    
    func DownloadPaymentMethods(){
        
        let payment_method_id = itemPaymentMethod!.id as String!
        let parameters = ["public_key":public_key,"payment_method_id":String(payment_method_id)]
        LoadingAnimations.showProgressHUD(self.view)
        Connection.networkingCallsMaster(creditCardIssuers, parameters: parameters) { response in
            LoadingAnimations.hideProgressHUD(self.view)
            self.createArrayWithBanks(response)
        }
    }
    

    func createArrayWithBanks(data:(JSON)){
        
        for (_,subJson):(String, JSON) in data {
            
            var id = ""
            if subJson["id"].exists(){
                id = subJson["id"].stringValue
            }
            
            var name = ""
            if subJson["name"].exists(){
                name = subJson["name"].stringValue
            }
            
            var secure_thumbnail = ""
            if subJson["secure_thumbnail"].exists(){
                secure_thumbnail = subJson["secure_thumbnail"].stringValue
            }
            
            var thumbnail = ""
            if subJson["thumbnail"].exists(){
                thumbnail = subJson["thumbnail"].stringValue
            }
            
            let  model = Banco(id: id, name: name, secure_thumbnail: secure_thumbnail, thumbnail: thumbnail)
            self.modelArray.append(model)
        }
        reloadTableViewContent()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Seleccione el banco"
        return title
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
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
        let item = self.modelArray[indexPath.row]
        cell.labelName.text = item.name! ?? "[No subject]"
    }
    
    func setImageForCell(cell:MetodosDePagoCell,indexPath:NSIndexPath){
        let item = self.modelArray[indexPath.row]
        if !(item.thumbnail?.isEmpty)!{
            Connection.downloadThumbnails(item.thumbnail!, completion: { (image) in
                cell.imageCreditCard.image = image
            })
        }
    }
    
    func reloadTableViewContent() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            self.tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForSelectedRow
        let itemBanco = self.modelArray[indexPath!.row]
        let cuotas = segue.destinationViewController as! Cuotas
        cuotas.itemBancos = itemBanco
        cuotas.itemMetodoDePago = itemPaymentMethod
        cuotas.amount = amount
        
    }

}
