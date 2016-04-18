//
//  MetodosDePago.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/15/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit
import SwiftyJSON

class MetodosDePago: UITableViewController{

    @IBOutlet var tableview: UITableView!
    var amount:String? = nil
    let basicCellIdentifier = "metodosDePagoCell"
    var modelArray:[PaymentMethod] = []
    override func viewDidLoad() {
        self.navigationItem.titleView = NavItemTitle.SetTitleView()
        DownloadPaymentMethods()
    }
    
    func DownloadPaymentMethods(){
        let parameters = ["public_key":public_key]
        LoadingAnimations.showProgressHUD(self.view)
        Connection.networkingCallsMaster(paymentMethods, parameters: parameters) { response in
            LoadingAnimations.hideProgressHUD(self.view)
            self.CreateArrayWithPaymentMethods(response)
        }
    }
    
    func CreateArrayWithPaymentMethods(data:(JSON)){
        
        for (_,subJson):(String, JSON) in data {

            var id = ""
            if subJson["id"].exists(){
                id = subJson["id"].stringValue
            }
            
            var deferred_capture = ""
            if subJson["deferred_capture"].exists() {
                deferred_capture = subJson["deferred_capture"].stringValue
            }
            
            var additional_info_needed = [String]()
            if !subJson["additional_info_needed"].isEmpty {
                for item in subJson["additional_info_needed"] {
                    additional_info_needed.append(String(item))
                }
            }
            
            var payment_type_id = ""
            if subJson["payment_type_id"].exists() {
                payment_type_id = subJson["payment_type_id"].stringValue
            }
            
            var accreditation_time = 0
            if subJson["accreditation_time"].exists() {
                accreditation_time = subJson["accreditation_time"].intValue
            }
            
            var bin = [String:AnyObject]()
            var card_number = [String:AnyObject]()
            var security_code = [String:AnyObject]()
            if subJson["settings"].exists() {
                if subJson["settings"][0].exists() {
                    //bin
                    if subJson["settings"][0]["bin"].exists() {
                        if subJson["settings"][0]["bin"]["pattern"].exists() {
                            bin["pattern"] = subJson["settings"][0]["bin"]["pattern"].stringValue
                        }else{
                            bin["pattern"] = ""
                        }
                        if subJson["settings"][0]["bin"]["installments_pattern"].exists() {
                            bin["installments_pattern"] = subJson["settings"][0]["bin"]["installments_pattern"].stringValue
                        }else{
                            bin["installments_pattern"] = ""
                        }
                        if subJson["settings"][0]["bin"]["exclusion_pattern"].exists() {
                            bin["exclusion_pattern"] = subJson["settings"][0]["bin"]["exclusion_pattern"].stringValue
                        }else{
                            bin["exclusion_pattern"] = ""
                        }
                    }
                    //card_number
                    if subJson["settings"][0]["card_number"].exists() {
                        if subJson["settings"][0]["card_number"]["validation"].exists() {
                            card_number["validation"] = subJson["settings"][0]["card_number"]["validation"].stringValue
                        }else{
                            card_number["validation"] = ""
                        }
                        if subJson["settings"][0]["card_number"]["length"].exists() {
                            card_number["length"] = subJson["settings"][0]["card_number"]["length"].intValue
                        }else{
                            card_number["length"] = 0
                        }
                    }
                    //security_code
                    if subJson["settings"][0]["security_code"].exists() {
                        if subJson["settings"][0]["security_code"]["mode"].exists() {
                            security_code["mode"] = subJson["settings"][0]["security_code"]["mode"].stringValue
                        }else{
                            security_code["mode"] = ""
                        }
                        if subJson["settings"][0]["security_code"]["card_location"].exists() {
                            security_code["card_location"] = subJson["settings"][0]["security_code"]["card_location"].stringValue
                        }else{
                            security_code["card_location"] = ""
                        }
                        if subJson["settings"][0]["security_code"]["length"].exists() {
                            security_code["length"] = subJson["settings"][0]["security_code"]["length"].intValue
                        }else{
                            security_code["length"] = 0
                        }
                    }
                    
                }
            }
            
            //            let bin_Struct = PaymentMethod.bin(pattern: (bin["pattern"]?.stringValue)! , installments_pattern: (bin["installments_pattern"]?.stringValue)!, exclusion_pattern: (bin["exclusion_pattern"]?.stringValue)!)
            //
            let bin_Struct = PaymentMethod.bin(pattern: String(bin["pattern"] as! String), installments_pattern: String(bin["installments_pattern"] as! String), exclusion_pattern: String(bin["exclusion_pattern"] as! String))
            
            let card_number_Struct = PaymentMethod.card_number (validation: String(card_number["validation"] as! String), length: Int(card_number["length"] as! Int))
            
            let security_code_Struct = PaymentMethod.security_code(mode: String(security_code["mode"] as! String), card_location: String(security_code["card_location"] as! String), length: Int(security_code["length"] as! Int))
            
            let settings:[Any] = [bin_Struct,card_number_Struct,security_code_Struct]
            
            var max_allowed_amount = 0
            if subJson["max_allowed_amount"].exists() {
                max_allowed_amount = subJson["max_allowed_amount"].intValue
            }
            
            var min_allowed_amount = 0
            if subJson["min_allowed_amount"].exists() {
                min_allowed_amount = subJson["min_allowed_amount"].intValue
            }
            
            var secure_thumbnail = ""
            if subJson["secure_thumbnail"].exists() {
                secure_thumbnail = subJson["secure_thumbnail"].stringValue
            }
            
            var thumbnail = ""
            if subJson["thumbnail"].exists() {
                thumbnail = subJson["thumbnail"].stringValue
            }
            
            var name = ""
            if subJson["name"].exists() {
                name = subJson["name"].stringValue
            }
            
            var status = ""
            if subJson["status"].exists() {
                status = subJson["status"].stringValue
            }
            
            
            let model = PaymentMethod(id: id, deferred_capture: deferred_capture, additional_info_needed: additional_info_needed, payment_type_id: payment_type_id, accreditation_time: accreditation_time, settings: settings, max_allowed_amount: max_allowed_amount, min_allowed_amount: min_allowed_amount, secure_thumbnail: secure_thumbnail, thumbnail: thumbnail, name: name, status: status)
            
            self.modelArray.append(model)
        }
        self.reloadTableViewContent()
    }
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Seleccione el metodo de pago"
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

    //Mark Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPath = tableView.indexPathForSelectedRow
        let item = self.modelArray[indexPath!.row]
        let bancos = segue.destinationViewController as! Bancos
        bancos.itemPaymentMethod = item
        bancos.amount = amount!
    }
}
