//
//  ListTableViewController.swift
//  Biloba
//
//  Created by admin on 31/5/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, NSXMLParserDelegate {
    
    var eventos: [Eventos] = []
    var eName: String = String()
    var id = String()
    var nombre = String()
    var foto = String()
    var desripcion = String()
    
    var fila = 0
    var isNotError: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //xarxa
        
        let parser = NSXMLParser(contentsOfURL: (NSURL(string: "http://oracle.ilerna.com:8126/projectdam/servei.php?db=DAM2_PROJECTE_ANCHOR&user=DAM2_PROJECTE_ANCHOR&pass=anchor&tipo=2&consulta=select%20id_evento,%20nombre,%20imagen_vertical,%20descripcion%20from%20evento"))! )!
        parser.delegate =  self
        parser.parse()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let event = eventos[indexPath.row]
        
        let strurl = NSURL(string: event.foto)!
        let dtinternet = NSData(contentsOfURL:strurl)!
        let bongtuyet:UIImageView = UIImageView(frame:CGRectMake(CGFloat(160),CGFloat(130),60,60));
        
        bongtuyet.image = UIImage(data:dtinternet)
        cell.imageView?.image = bongtuyet.image
        cell.textLabel?.text = event.nombre
        
        return cell
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
                id = String()
                nombre = String()
                foto = String()
                desripcion = String()
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(isNotError){
            if elementName == "registre" {
                
                let EventoElemento = Eventos()
                EventoElemento.id = id
                EventoElemento.nombre = nombre
                EventoElemento.foto = foto
                EventoElemento.descripcion = desripcion
                
                eventos.append(EventoElemento)
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        let data = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if(isNotError){
            if (!data.isEmpty) {
                if eName == "field00" {
                    id += data
                } else if eName == "field01" {
                    nombre += data
                }else if eName == "field02" {
                    foto += data
                }else if eName == "field03" {
                    desripcion += data
                }

            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        print("You selected cell#\(indexPath.row)!")
        
        fila = indexPath.row
        print(fila)
        
        //Llama a otra pagina con la funcion de abajo
        self.performSegueWithIdentifier("DetallesEvento", sender: self)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetallesEvento"){
            var detailView: DetallesEvento = segue.destinationViewController as! DetallesEvento
            
            detailView.nombre = eventos[fila].nombre
            detailView.descripcion = eventos[fila].descripcion
            detailView.id = eventos[fila].id
            
            
            
        }
    }
    

    
    
}

