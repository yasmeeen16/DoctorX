//
//  nursecell.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class nursecell: UITableViewCell {
    
       @IBOutlet weak var NurseName: UILabel!
   @IBOutlet weak var phone: UILabel!
       @IBOutlet weak var clinicName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
