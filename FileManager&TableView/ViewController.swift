//  ViewController.swift
//  FileManager&TableView
//  Created by Felipe Ramírez on 12/1/22.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_show: UITextView!
    var datos = [String]()
    var defaults = UserDefaults.standard
    private let myKey = "mykey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func btn_Json(_ sender: Any) {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            let array = getData()
            datos = array
        }else{
            print ("No existe el archivo")
        }
        txt_show.text = datos.description
    }
    
    @IBAction func btn_save(_ sender: Any) {
        guard let text_name = txt_name.text else {return}
        guard let text_lastName = txt_lastName.text else {return}
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: getFullPath().absoluteString){
            let array = getData()
            datos = array
        }else{
            print ("No existe")
        }
        
        datos.append(text_name)
        datos.append(text_lastName)
        
        do{
            let datosEnJson = try JSONSerialization.data(withJSONObject: datos)
            try datosEnJson.write(to: getFullPath())
        }catch let error {
            print("ERROR: \(error)")
        }
    }
    
    //Guardar en xml
    @IBAction func btn_saveXML(_ sender: Any) {
        defaults.set(datos, forKey: myKey)
        defaults.synchronize()
    }
    
    private func getDocumentPath() -> URL{
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return URL(string: "")!}
        return path
    }
    
    private func getFullPath() -> URL {
        let path = getDocumentPath()
        let fileURL =  path.appendingPathComponent("datos.json")
        return fileURL
    }
    
    private func getData() -> [String]{
        do{
            let data = try Data(contentsOf: getFullPath())
            guard let array = try JSONSerialization.jsonObject(with: data) as? [String] else {return[]}
            datos = array
        } catch let error {
            print("ERROR: \(error)")
        }
        return datos
    }
}

