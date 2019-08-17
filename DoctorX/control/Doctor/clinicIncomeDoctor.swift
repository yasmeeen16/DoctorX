//
//  clinicIncomeDoctor.swift
//  DoctorX
//
//  Created by yasmeen on 8/17/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase

class clinicIncomeDoctor: UIViewController {
    
    
    @IBOutlet weak var patiantToday: UILabel!
    @IBOutlet weak var incomeMonth: UILabel!
    @IBOutlet weak var incomeDay: UILabel!
    @IBOutlet weak var incomeyear: UILabel!
    var ref : DatabaseReference!
    var clinicId = " "
     override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var numOfRes = 0
        var totalofDay = 0
        var totalOfMonth = 0
        var taotalOfYear = 0
        ref = Database.database().reference()
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day ,.hour ,.minute], from: date)
        
        let year1 =  "\(components.year!)" //year of now
        let month1 = "\(components.month!)" // month of now
        let day1 = "\(components.day!)"
        let hour1 = components.hour //hour of now
        let minute1 = components.minute // minute of now
        
        self.ref.child("Reservation").queryOrdered(byChild: "confirmed").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                let reserveType = dict["reserveType"]!
                let clinicId = dict["clinicId"]!
                let entered = dict["entered"]!
                let day = dict["day"]!
                let month = dict["month"]!
                let year = dict["year"]!
                let defaults = UserDefaults.standard
                if clinicId == self.clinicId && entered == "1" && day == day1{
                    
                    numOfRes = numOfRes + 1
                    self.patiantToday.text = "\(numOfRes)"
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                             totalofDay = totalofDay + Int(dict["price"]!)!
                            self.incomeDay.text = "\(totalofDay) ريال"
                        }
                    })
                }
                if clinicId == self.clinicId && entered == "1" && month == month1{
                    
                    //numOfRes = numOfRes + 1
                    // self.NumOfReservation.text = "\(numOfRes)"
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                            totalOfMonth = totalOfMonth + Int(dict["price"]!)!
                            self.incomeMonth.text = "\(totalOfMonth) ريال"
                        }
                    })
                }
                if clinicId == self.clinicId && entered == "1" && year == year1{
                    
                    //numOfRes = numOfRes + 1
                    // self.NumOfReservation.text = "\(numOfRes)"
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                            taotalOfYear = taotalOfYear + Int(dict["price"]!)!
                            self.incomeyear.text = "\(taotalOfYear) ريال"
                        }
                    })
                }
            }
        })
    }
}
