//
//  NClinicCell.swift
//  DoctorX
//
//  Created by yasmeen on 7/7/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import MapKit
class NClinicCell: UICollectionViewCell {
        @IBOutlet weak var mapK: MKMapView!
        @IBOutlet weak var name: UILabel!
        @IBOutlet weak var time: UILabel!
        
        @IBOutlet weak var days: UILabel!
        @IBOutlet weak var mobile: UILabel!
        @IBOutlet weak var phone: UILabel!
        @IBOutlet weak var address: UILabel!
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            layer.cornerRadius = 5.0
            //create shadow
            contentView.layer.cornerRadius = 5.0
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.clear.cgColor
            contentView.layer.masksToBounds = false
            
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0,height: 1.0)
            layer.shadowRadius = 3.0
            layer.shadowOpacity = 0.5
            layer.masksToBounds = false
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        }
  
    
}
