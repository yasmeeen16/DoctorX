


//
//  NurseConfirmedCell.swift
//  DoctorX
//
//  Created by yasmeen on 7/16/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class NurseConfirmedCell: UITableViewCell {

    @IBOutlet weak var ReservationTime: UILabel!
    @IBOutlet weak var PatiantName: UILabel!
    @IBOutlet weak var ReservationType: UILabel!
    
    @IBOutlet weak var enterBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCellEn(reservation: PatiantData) {
        
        PatiantName.text = "Request from \(reservation.name!)"
        ReservationTime.text = "at \(reservation.reserveTime!)  \(reservation.reserveDate!)"
        enterBtn.accessibilityIdentifier = reservation.id
        ReservationType.text = reservation.reserveType
//        if (reservation.reserveType! == "1"){
//            ReservationType.text = "normal Booking"
//        }else if (reservation.reserveType! == "2"){
//            ReservationType.text = "Quick booking"
//
//        }else if (reservation.reserveType! == "3"){
//            ReservationType.text = "Re-revealed"
//        }else if (reservation.reserveType! == "4"){
//            ReservationType.text = "consultation"
//        }else if (reservation.reserveType! == "5"){
//            ReservationType.text = "Visit home"
//
//        }
        
    }

}
