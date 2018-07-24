//
//  CustomTableViewCell.swift
//  Biloba
//
//  Created by admin on 4/6/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imagenActividad: UIImageView!
    
    @IBOutlet weak var tituloActividad: UILabel!
    
    
    @IBOutlet weak var descripcionActividad: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
