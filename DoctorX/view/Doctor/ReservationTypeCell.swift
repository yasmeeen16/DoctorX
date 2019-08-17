//
//  ReservationTypeCell.swift
//  DoctorX
//
//  Created by yasmeen on 7/22/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class ReservationTypeCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var DeactivateBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func DeactivateBtn(_ sender: Any) {
    }
    
}
