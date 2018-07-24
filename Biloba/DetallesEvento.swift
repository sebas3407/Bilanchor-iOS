//
//  DetallesEvento.swift
//  Biloba
//
//  Created by admin on 31/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class DetallesEvento: UIViewController, NSXMLParserDelegate {
    
    var eName: String = String()
    var foto = String()

    var isNotError: Bool = false
    
   
    @IBOutlet weak var cartelEvento: UIImageView!
    @IBOutlet weak var labelnombreEvento: UILabel!
    @IBOutlet weak var textDescripcion: UITextView!
    
    
    var nombre: String = ""
    var descripcion: String = ""
    var id: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelnombreEvento.text = nombre
        self.textDescripcion.text = descripcion
        
        
        let parser = NSXMLParser(contentsOfURL: (NSURL(string: "http://oracle.ilerna.com:8126/projectdam/servei.php?db=DAM2_PROJECTE_ANCHOR&user=DAM2_PROJECTE_ANCHOR&pass=anchor&tipo=2&consulta=select%20imagen_horizontal%20from%20evento%20where%20id_evento%20=%20%27\(id)%27"))! )
        
        
        parser!.delegate =  self
        parser!.parse()
        
        
        
        let strurl = NSURL(string: foto)!
        let dtinternet = NSData(contentsOfURL:strurl)!
        let bongtuyet:UIImageView = UIImageView(frame:CGRectMake(CGFloat(160),CGFloat(130),60,60));
        
        bongtuyet.image = UIImage(data:dtinternet)
        cartelEvento.image = bongtuyet.image

        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                foto = String()
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(isNotError){
            if elementName == "registre" {
               
        
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if(isNotError){
            if (!data.isEmpty) {
                if eName == "field00" {
                    foto += data
                }
            }
        }
    }


}
