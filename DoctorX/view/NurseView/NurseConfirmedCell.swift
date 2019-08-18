


//
//  NurseConfirmedCell.swift
//  DoctorX
//
//  Created by yasmeen on 7/16/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class NurseConfirmedCell: UITableViewCell {

    @IBOutlet weak var reservationDate: UILabel!
    @IBOutlet weak var patiantAddress: UILabel!
    @IBOutlet weak var patiantPhone: UILabel!
    @IBOutlet weak var patiantAge: UILabel!
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
        

        PatiantName.text = reservation.name
        ReservationTime.text = reservation.reserveTime!
        enterBtn.accessibilityIdentifier = reservation.id
        ReservationType.text = reservation.reserveType
        reservationDate.text = reservation.reserveDate!
        patiantAddress.text = reservation.address
        patiantPhone.text = reservation.phone
        patiantAge.text = "\(reservation.age!) سنه"
    }

}



