//
//  ViewController.swift
//  MercadoPago
//
//  Created by alvaro sebastian leon romero on 4/14/16.
//  Copyright © 2016 seblerom. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var textfieldMonto: UITextField!

    @IBAction func buttonSiguiente(sender: AnyObject) {
        
        let text = Double(textfieldMonto.text!)
        if text > 0 {
            self.tapGesture(self)
            self.performSegueWithIdentifier("metodoDePagoSegue", sender: self)
        }else{
            AlertViews.SingleAlert("Atencion", message: "El importe ingresado debe ser mayor a cero", buttonTitle: "Entendido!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldMonto.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapGesture(sender: AnyObject) {
        textfieldMonto.resignFirstResponder()
    }

//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        
//        let text = textField.text
//        var newText = text!.stringByReplacingCharactersInRange(range.toRange(text!), withString: string)
//        newText = newText.stringByReplacingOccurrencesOfString(".", withString: "")
//        let numericValue:Double = (Double(newText)! * 0.01)
//        textField.text = String(numericValue)
//        return false
//        
//    }
}

//extension NSRange {
//    func toRange(string: String) -> Range<String.Index> {
//        let startIndex = string.startIndex.advancedBy(location)
//        let endIndex = string.startIndex.advancedBy(length)
//        return startIndex..<endIndex
//    }
//}

