//  TableViewControllerRecordListXML.swift
//  FileManager&TableView
//  Created by Felipe Ramírez on 25/1/22.

import UIKit

class TableViewControllerRecordListXML: UITableViewController,XMLParserDelegate {
    @IBOutlet var miTabla: UITableView!
    var posts = [Post]()
    var nombre = String()
    var apellido = String()
    var nombreElemento = String()
    var parser : XMLParser = XMLParser()
    var urlXML = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: urlXML) else {return}
        guard let parser = XMLParser(contentsOf: url) else {return}
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombreElemento = elementName
        if nombreElemento == "itemFullName" {
            nombre = String()
            apellido = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if nombreElemento == "itemName" {
         nombre += caracter
        }else if nombreElemento == "itemLastName" {
            apellido += caracter
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "itemFullName" {
            let datosPost = Post(nombre: nombre, apellido: apellido)
            print(nombre)
            posts.append(datosPost)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = posts[indexPath.row].nombre
        return cell
    }
}
