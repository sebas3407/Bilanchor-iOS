//
//  ActivityTableViewController.swift
//  Biloba
//
//  Created by admin on 1/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController, NSXMLParserDelegate {
    
    var actividades: [Actividades] = []
    var eName: String = String()
    var id = String()
    var titulo = String()
    var foto = String()
    var descripcion = String()
    
    var fila = 0
    var isNotError: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //xarxa
        
        let parser = NSXMLParser(contentsOfURL: (NSURL(string: "http://oracle.ilerna.com:8126/projectdam/servei.php?db=DAM2_PROJECTE_ANCHOR&user=DAM2_PROJECTE_ANCHOR&pass=anchor&tipo=2&consulta=select%20id_actividad,%20titulo_actividad,%20foto_actividad,%20descripcion%20from%20actividad"))! )!
        parser.delegate =  self
        parser.parse()
        
        //locl
        /*
         if let parser = NSXMLParser(contentsOfURL: path){
         parser.delegate = self
         parser.parse()
         }*/
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return actividades.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell") as! CustomTableViewCell
        
        let activity = actividades[indexPath.row]
        
        let strurl = NSURL(string: activity.foto)!
        let dtinternet = NSData(contentsOfURL:strurl)!
        let bongtuyet:UIImageView = UIImageView(frame:CGRectMake(CGFloat(160),CGFloat(130),60,60));
        
        bongtuyet.image = UIImage(data:dtinternet)
        
        cell.imagenActividad.image = bongtuyet.image
        cell.tituloActividad.text = activity.titulo
        cell.descripcionActividad.text = activity.descripcion
        
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
                titulo = String()
                foto = String()
                descripcion = String()
            }
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(isNotError){
            if elementName == "registre" {
                
                let ActividadElemento = Actividades()
                ActividadElemento.id = id
                ActividadElemento.titulo = titulo
                ActividadElemento.foto = foto
                ActividadElemento.descripcion = descripcion
                
                actividades.append(ActividadElemento)
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
                    titulo += data
                }else if eName == "field02" {
                    foto += data
                }else if eName == "field03" {
                    descripcion += data
                }
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        print("You selected cell#\(indexPath.row)!")
        
        fila = indexPath.row
        print(fila)
        

        
    }
    
    
    
}

