//  ViewController.swift
//  FileManager&TableView
//  Created by Felipe Ramírez on 12/1/22.

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    //var defaults = UserDefaults.standard
    //private let myKey = "mykey"
    
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_show: UITextView!
    var nom = String()
    var apel = String()
    var nombreElemento = String()
    //quisar falte el uitableview
    
    var arrayDiccionarioDatos = [[String: String]]()
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //  let array = getData()
        //  arrayDiccionarioDatos = array
        
    }
    
    func getDataXML(){
        guard let parseador: XMLParser = XMLParser(contentsOf: getFullPath2()) else {return}
        parseador.delegate = self
        parseador.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        nombreElemento = elementName
        if nombreElemento == "item" {
            nom = String()
            apel = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let caracter = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if caracter.isEmpty == false {
            if nombreElemento == "nombre"{
                nom += caracter
            }
            if nombreElemento == "apellido"{
                apel += caracter
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let diccionarioNuevo = ["nombre": nom, "apellido": apel]
            arrayDiccionarioDatos.append(diccionarioNuevo)
        }
    }
    
    @IBAction func btnGuardar(_ sender: Any) {
        guard let valor1 = txt_name.text, let valor2 = txt_lastName.text else {return}
        
        
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            //  let array = getData()
            //  arrayDiccionarioDatos = array
        }else{
            print ("No existe")
        }
        
        var diccionario:[String: String] = ["nombre": valor1, "apellido": valor2]
        arrayDiccionarioDatos.append(diccionario)
        //defaults.set(arrayDiccionarioDatos, forKey: "arrayDiccionarioDatos")
        
        do{
            let info = try JSONSerialization.data(withJSONObject: arrayDiccionarioDatos)
            try info.write(to: getFullPath())
        }catch let error {
            print("error : \(error)")
        }
    }
    
    @IBAction func btn_saveAsJson(_ sender: Any) {
        guard let text_name = txt_name.text else {return}
        guard let text_lastName = txt_lastName.text else {return}
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            // let array = getData()
            // arrayDiccionarioDatos = array
        }else{
            print ("No existe")
        }
        
        do{
            let datosEnJson = try JSONSerialization.data(withJSONObject: arrayDiccionarioDatos)
            try datosEnJson.write(to: getFullPath())
        }catch let error {
            print("ERROR: \(error)")
        }
    }
    
    @IBAction func btn(_ sender: Any) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            //let array = getData()
            //arrayDiccionarioDatos = array
        }else{
            print ("No existe el archivo")
        }
        txt_show.text = arrayDiccionarioDatos.description
    }
    
    //Guardar en xml
    @IBAction func btn_saveXML(_ sender: Any) {
        guard let text_name = txt_name.text else {return}
        guard let text_lastName = txt_lastName.text else {return}
        let diccionarioNuevo = ["nombre": text_name, "apellido": text_lastName]
        arrayDiccionarioDatos.append(diccionarioNuevo)
        print(diccionarioNuevo)
        let fileManager = FileManager.default
        
        let returnString = stringXML()
        
        do{
            try returnString.write(to: getFullPath2(), atomically: true, encoding: .utf8)
        }catch{
            print("error grabando xml")
        }
        arrayDiccionarioDatos = [[String: String]]()
        getDataXML()
        
    }
    
    func stringXML() -> String{
        var stringXml: String = "<itemFullName>\n"
        var user2: [[String: String]] = arrayDiccionarioDatos
        for i in user2{
            stringXml.append("<item>\n")
            for j in i{
                if j.key == "nombre" {
                    stringXml.append("<nombre>\n \(j.value)</nombre>\n")
                }
                if j.key == "apellido" {
                    stringXml.append("<apellido>\n \(j.value)</apellido>\n")
                }
            }
            stringXml.append("</item>\n")
        }
        stringXml.append("</itemFullName>\n")
        return stringXml
        
    }
    
    /*    private func getData() -> [[String: String]]{
     do{
     let data = try Data(contentsOf: getFullPath2())
     guard let array = try JSONSerialization.jsonObject(with: data) as? [[String: String]] else {return[]}
     arrayDiccionarioDatos = array
     } catch let error {
     print("ERROR: \(error)")
     }
     return arrayDiccionarioDatos
     }
     */
    
    private func getDocumentPath() -> URL{
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return URL(string: "")!}
        return path
    }
    
    private func getFullPath() -> URL {
        let path = getDocumentPath()
        let fileURL =  path.appendingPathComponent("datos.json")
        return fileURL
    }
    
    private func getFullPath2() -> URL {
        let path = getDocumentPath()
        let fileURL =  path.appendingPathComponent("datos.xml")
        return fileURL
    }
    
    
    
}

