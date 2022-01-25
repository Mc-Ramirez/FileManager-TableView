//  ViewControllerRecordLisJson.swift
//  FileManager&TableView
//  Created by Felipe Ramírez on 24/1/22.

import UIKit

class ViewControllerRecordLisJson: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var miTabla: UITableView!
    var defaults = UserDefaults.standard
    var arrayGeneral : [String:String] = [:]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGeneral.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = miTabla.dequeueReusableCell(withIdentifier: "Celda") as! TableViewCell
        celda.lbl_showFullName.text = String()
        return celda
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
