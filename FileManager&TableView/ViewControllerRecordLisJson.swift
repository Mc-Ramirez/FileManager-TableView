//  ViewControllerRecordLisJson.swift
//  FileManager&TableView
//  Created by Felipe Ramírez on 24/1/22.

import UIKit

class ViewControllerRecordLisJson: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var miTabla: UITableView!
    var defaults = UserDefaults.standard
    var arrayGeneral : [String:String] = [:]
    var arrayNombres = ["Nombre", "Nombre 2", "Nombre 3", "Nombre 4", "Nombre 5", "Nombre 6"]
    var arrayNombres2 = ["Nombre", "Nombre 2", "Nombre 3", "Nombre 4", "Nombre 5", "Nombre 6"]
    var arraySubNombres = ["SubNombre 1", "SubNombre 2", "SubNombre 3", "SubNombre 4", "SubNombre 5", "SubNombre 6"]
    var arraySubNombres2 = ["SubNombre 1", "SubNombre 2", "SubNombre 3", "SubNombre 4", "SubNombre 5", "SubNombre 6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "titulo"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "pie"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNombres.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = miTabla.dequeueReusableCell(withIdentifier: "Celda") as! TableViewCell
        celda.lbl_name.text = arrayNombres [indexPath.row]
        celda.lbl_lastname.text = arrayNombres [indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("He pulsado \(arrayNombres[indexPath.row])")
    }
    
    
    //por defecto (nota: la funcion es la que lleva commit)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        arrayNombres.remove(at: indexPath.row)
        arraySubNombres.remove(at: indexPath.row)
        miTabla.reloadData()
    }
    
    //personalizada
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let opBorrar = UIContextualAction(style: .normal, title: "Borrar") { _,_,_ in
            if indexPath.section == 0{
                self.arrayNombres.remove(at: indexPath.row)
                self.arraySubNombres.remove(at: indexPath.row)
            }else{
                self.arrayNombres2.remove(at: indexPath.row)
                self.arraySubNombres2.remove(at: indexPath.row)
            }
            self.miTabla.deleteRows(at: [indexPath], with: .fade)
        }

        opBorrar.image = UIImage(systemName: "trash")
        opBorrar.backgroundColor = UIColor.red
    
    let opEditar = UIContextualAction(style: .normal, title: "Editar") { _,_,_ in
        print("Has pulsado editar")
    }
    
    opEditar.backgroundColor = UIColor.yellow
    
    let configurarBotones = UISwipeActionsConfiguration(actions: [opBorrar, opEditar])
        return configurarBotones
}
}

//table cell instanciado

