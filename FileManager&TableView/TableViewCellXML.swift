//
//  TableViewCellXML.swift
//  FileManager&TableView
//
//  Created by Felipe Ramírez on 26/1/22.
//

import UIKit

class TableViewCellXML: UITableViewCell {

    @IBOutlet weak var lbl_apellido: UILabel!
    @IBOutlet weak var lbl_nombre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
