//
//  TableViewCell.swift
//  FileManager&TableView
//
//  Created by Felipe Ramírez on 12/1/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_showFullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
