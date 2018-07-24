//
//  ViewController.swift
//  Biloba
//
//  Created by admin on 9/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {

    
    var usuarios: [Usuarios] = []
    var eName: String = String()
    var dni = String()
    var clave = String()
    var isNotError: Bool = false
    
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var botonAcceder: UIButton!
    @IBOutlet weak var claveTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usuarios.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        
        dni = usuarioTextField.text!
        clave = claveTextField.text!
        
        
        
        
        let parser = NSXMLParser(contentsOfURL: (NSURL(string: "http://oracle.ilerna.com:8126/projectdam/servei.php?db=DAM2_PROJECTE_ANCHOR&user=DAM2_PROJECTE_ANCHOR&pass=anchor&tipo=2&consulta=select%20dni,%20clave%20from%20usuario%20where%20dni%20=%20%27\(dni)%27%20and%20clave%20=%20%27\(clave)%27"))! )!
        parser.delegate =  self
        parser.parse()
      
        
        if (usuarios.count == 1){
            performSegueWithIdentifier("datosCorrectos", sender: self)
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "datosCorrectos"){
            var finView: UITabBarController = segue.destinationViewController as! UITabBarController
            
        }
    }

    
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        //atribut
        if(elementName as NSString).isEqualToString("registres"){
            var resultat = attributeDict["estat"]! as String
            
            if(resultat == "200"){
                isNotError = true
            } else{
                print("Error")
            }
        }
        if(isNotError){
            eName = elementName
            if elementName == "registre" {
                dni = String()
                clave = String()
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(isNotError){
            if elementName == "registre" {
                
                let usuarioElemento = Usuarios()
                usuarioElemento.dni = dni
                usuarioElemento.clave = clave
                
                usuarios.append(usuarioElemento)
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if(isNotError){
            if (!data.isEmpty) {
                if eName == "field00" {
                    dni += data
                } else if eName == "field01" {
                    clave += data
                }
            }
        }
    }


}

