//
//  AppointmentCell.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class AppointmentCell: UITableViewCell {

    @IBOutlet weak var patiantName: UILabel!
    @IBOutlet weak var reservationDate: UILabel!
    
    @IBOutlet weak var reservationclinic: UILabel!
    
    @IBOutlet weak var reservationTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
