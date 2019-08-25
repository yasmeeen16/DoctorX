//
//  NurseHome2.swift
//  DoctorX
//
//  Created by yasmeen on 7/15/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class NurseHome2: UIViewController, UITableViewDelegate,UITableViewDataSource {
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
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day ,.hour ,.minute], from: date)
        
        let year1 =  "\(components.year!)" //year of now
        let month1 = "\(components.month!)" // month of now
        let day1 = "\(components.day!)"
        let hour1 = components.hour //hour of now
        let minute1 = components.minute // minute of now
        ref = Database.database().reference()
        self.ref.child("Reservation").queryOrdered(byChild: "confirmed").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
//                let dict = snap.value as! [String: String]
//                let reserveType = dict["reserveType"]!
//                let clinicId = dict["clinicId"]!
//                let entered = dict["entered"]!
//                let day = dict["day"]
//                let month = dict ["month"]
//                let year = dict ["year"]
                let data = snap.value as? [String:Any]
                var reserveType = ""
                var clinicId = ""
                var entered = ""
                var day = ""
                var month = ""
                var year = ""
                for (key,value) in data! {
                    if key == "reserveType" {
                        reserveType = (value as? String)!
                    }
                    if key == "clinicId"{
                        clinicId = (value as? String)!
                    }
                    if key == "entered"{
                        entered = (value as? String)!
                    }
                    if key == "day"{
                        day = (value as? String)!
                    }
                    if key == "month"{
                        month = (value as? String)!
                    }
                    if key == "year"{
                        year = (value as? String)!
                    }
                }
                let defaults = UserDefaults.standard
                if clinicId == "\(defaults.object(forKey: "clinicId")!)" && entered == "1" && day == day1 && month == month1 && year == year1{
                    
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

        self.reservationRequests = []
        self.ref.child("Reservation").queryOrdered(byChild: "confirmed").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                print(child)
                let snap = child as! DataSnapshot
                let data = snap.value as? [String:Any]
                //let dict = snap.value as! [String: String]
                var address = ""
                var age = ""
                var clinicId = ""
                var confirmed = ""
                var day = ""
                var gender = ""
                var id = ""
                var lat = ""
                var long = ""
                var month = ""
                var name = ""
                var nurseId = ""
                var phone = ""
                var price = ""
                var reserveDate = ""
                var reserveTime = ""
                var reserveType = ""
                var status = ""
                var userKey = ""
                var year = ""
                var entered = ""
                var type = ""
                for (key,value) in data! {
                    if key == "address" {
                        address = (value as? String)!
                    }
                    if key == "age"{
                        age = (age as? String)!
                    }
                    if key == "clinicId"{
                        clinicId = (value as? String)!
                    }
                    if key == "confirmed"{
                       confirmed = (value as? String)!
                    }
                    if key == "entered"{
                        entered = (value as? String)!
                    }
                    if key == "day"{
                        day = (value as? String)!
                    }
                    if key == "month"{
                        month = (value as? String)!
                    }
                    if key == "year"{
                        year = (value as? String)!
                    }
                    if key == "id"{
                        id = (value as? String)!
                    }
                    if key == "lat"{
                        lat = (value as? String)!
                    }
                    if key == "long"{
                        long = (value as? String)!
                    }
                    if key == "gender"{
                        gender = (value as? String)!
                    }
                    if key == "name"{
                        name = (value as? String)!
                    }
                    if key == "nurseId"{
                        nurseId = (value as? String)!
                    }
                    if key == "price"{
                        price = (value as? String)!
                    }
                    if key == "phone"{
                        phone = (value as? String)!
                    }
                    if key == "reserveType"{
                        reserveType = (value as? String)!
                    }
                    if key == "reserveDate"{
                        reserveDate = (value as? String)!
                    }
                    if key == "reserveTime"{
                        reserveTime = (value as? String)!
                    }
                    if key == "status"{
                        status = (value as? String)!
                    }
                    if key == "userKey"{
                        userKey = (value as? String)!
                    }
                }
//                let snap = child as! DataSnapshot
//                let dict = snap.value as! [String: String]
//                let address = dict["address"]!
//                let age = dict["age"]!
//                let clinicId = dict["clinicId"]!
//                let confirmed = dict["confirmed"]!
//                let day = dict["day"]!
//                let gender = dict["gender"]!
//                let id = dict["id"]!
//                let lat = dict["lat"]!
//                let long = dict["long"]!
//                let month = dict["month"]!
//                let name = dict["name"]!
//                let nurseId = dict["day"]!
//                let phone = dict["phone"]!
//                let price = dict["price"]!
//                let reserveDate = dict["reserveDate"]!
//                let reserveTime = dict["reserveTime"]!
//                let reserveType = dict["reserveType"]!
//                let status = dict["status"]!
//                let userKey = dict["userKey"]!
//                let year = dict["year"]!
//                let entered = dict["entered"]!
//                var type = ""
                let defaults = UserDefaults.standard
                if clinicId == "\(defaults.object(forKey: "clinicId")!)" && entered == "1" && day == day1 && month == month1 && year == year1{
                        
                        self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                            for child in snapshot.children {
                                print(child)
                                let snap = child as! DataSnapshot
                                let data = snap.value as? [String:Any]
                                //let dict = snap.value as! [String: String]
                                for (key,value) in data! {
                                    if key == "name" {
                                        type = (value as? String)!
                                    }
                                }
//                                type = dict["name"]!
//                                let snap = child as! DataSnapshot
//                                let dict = snap.value as! [String: String]
//                                self.typeName = dict["name"]!
//                                type = self.typeName
//                                print(type)
                                
                            }
                            let reserveRequest = PatiantData(id: id, name: name, address: address, age: age, gender: gender, clinicId: clinicId, phone: phone, lat: lat, long: long, price: price, status: status, reserveType: type, reserveDate: reserveDate, reserveTime: reserveTime, userKey: userKey, nurseId: nurseId, day: day, month: month, year: year, confirmed: confirmed, entered: entered)
                            self.reservationRequests.append(reserveRequest)
                            self.Top5Table.reloadData()
                            
                        })
                    }
                }
            
        })
        
    }
    @IBAction func AddReservation(_ sender: Any) {
        self.performSegue(withIdentifier: "next", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservationRequests.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = Top5Table.dequeueReusableCell(withIdentifier: "cell") as! top5forNurse
        let reserve = self.reservationRequests[indexPath.row]
        //cell.patiantName.text = "mohamed ali"
        cell.patiantName.text = reserve.name
        
        return cell
        
    }
    
    

}
