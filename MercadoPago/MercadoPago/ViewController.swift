//
//  ViewController.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/14/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var textfieldMonto: UITextField!
    @IBAction func buttonSiguiente(sender: AnyObject) {
        
        let text = Double(textfieldMonto.text!)
        if text >= 1 {
            self.tapGesture(self)
            self.performSegueWithIdentifier("metodoDePagoSegue", sender: self)
        }else{
            AlertViews.SingleAlert("Atencion", message: "El importe ingresado debe ser mayor a cero", buttonTitle: "Entendido!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = NavItemTitle.SetTitleView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.ShowMessage), name: notificationKey, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapGesture(sender: AnyObject) {
        textfieldMonto.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let metodosDePago = segue.destinationViewController as! MetodosDePago
        metodosDePago.amount = self.textfieldMonto.text
    }
    
    func ShowMessage(notification:NSNotification){
        
        let model = notification.object as! MessageModel
        var mensaje = "Monto: " + model.amount + "\n"
        mensaje += "Banco: " + model.banco + "\n"
        mensaje += "Metodo de pago: " + model.paymentMethod + "\n"
        mensaje += "Cuotas: " + model.cuotas
        
        AlertViews.SingleAlert("Usted seleccionó", message: mensaje, buttonTitle: "Genial!")
        
    }
}




