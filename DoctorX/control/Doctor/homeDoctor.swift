//
//  homeDoctor.swift
//  DoctorX
//
//  Created by yasmeen on 8/17/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class homeDoctor: UIViewController {

    @IBOutlet weak var NumOfReservation: UILabel!
    @IBOutlet weak var Money: UILabel!
    @IBOutlet weak var viewNumOfREservation: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var Top5Table: UITableView!
    var ref: DatabaseReference!
    var reservationRequests = [PatiantData]()
    var typeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.title = "\(defaults.object(forKey: "clinicname")!)"
        
        print(defaults.object(forKey: "NurseId")!)
        viewNumOfREservation.shadowView()
        view4.shadowView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var numOfRes = 0
        var total = 0
        ref = Database.database().reference()
        self.ref.child("Reservation").queryOrdered(byChild: "confirmed").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                let reserveType = dict["reserveType"]!
                let clinicId = dict["clinicId"]!
                let entered = dict["entered"]!
                
                let defaults = UserDefaults.standard
                if clinicId == "\(defaults.object(forKey: "clinicId")!)" && entered == "1"{
                    
                    numOfRes = numOfRes + 1
                    self.NumOfReservation.text = "\(numOfRes)"
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                            total = total + Int(dict["price"]!)!
                            self.Money.text = "\(total) ريال"
                        }
                    })
                }
            }
        })


}
}
