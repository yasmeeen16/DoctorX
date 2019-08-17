//
//  EditDeleteCell.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class EditDeleteCell: UITableViewCell {

    @IBOutlet weak var nurseName: UILabel!
    @IBOutlet weak var nursePhone: UILabel!
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
