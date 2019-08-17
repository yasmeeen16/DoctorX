//
//  NurseToDayReservation.swift
//  DoctorX
//
//  Created by yasmeen on 7/15/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NurseToDayReservation: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var reservationTable: UITableView!
    var ref: DatabaseReference!
    var reservationRequests = [PatiantData]()
    var typeName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        reservationTable.delegate = self
        reservationTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.reservationRequests = []
        ref = Database.database().reference()
        self.ref.child("Reservation").queryOrdered(byChild: "reserveTime").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                print(child)
                
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                
                let date = Date()
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day ,.hour ,.minute], from: date)
                
                let year1 =  "\(components.year!)" //year of now
                let month1 = "\(components.month!)" // month of now
                let day1 = "\(components.day!)"
                let hour1 = components.hour //hour of now
                let minute1 = components.minute // minute of now
                
                let address = dict["address"]!
                let age = dict["age"]!
                let clinicId = dict["clinicId"]!
                let confirmed = dict["confirmed"]!
                let day = dict["day"]!
                let gender = dict["gender"]!
                let id = dict["id"]!
                let lat = dict["lat"]!
                let long = dict["long"]!
                let month = dict["month"]!
                let name = dict["name"]!
                let nurseId = dict["day"]!
                let phone = dict["phone"]!
                let price = dict["price"]!
                let reserveDate = dict["reserveDate"]!
                let reserveTime = dict["reserveTime"]!
                let reserveType = dict["reserveType"]!
                let status = dict["status"]!
                let userKey = dict["userKey"]!
                let year = dict["year"]!
                let entered = dict["entered"]!
                var type = ""
                let defaults = UserDefaults.standard
                
                if confirmed == "1" && day == day1 && month == month1 && year == year1{
                if clinicId == "\(defaults.object(forKey: "clinicId")!)" && entered == "0"{
                    
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                             self.typeName = dict["name"]!
                            type = self.typeName
                            print(type)

                        }
                        let reserveRequest = PatiantData(id: id, name: name, address: address, age: age, gender: gender, clinicId: clinicId, phone: phone, lat: lat, long: long, price: price, status: status, reserveType: type, reserveDate: reserveDate, reserveTime: reserveTime, userKey: userKey, nurseId: nurseId, day: day, month: month, year: year, confirmed: confirmed, entered: entered)
                        self.reservationRequests.append(reserveRequest)
                        self.reservationTable.reloadData()
        
                    })
                }
                }
            }
        })
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NurseConfirmedCell
        let reserve = self.reservationRequests[indexPath.row]
        cell.configureCellEn(reservation: reserve)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    
    @IBAction func EnterBtn(_ sender: Any) {
        let R_id = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        
       self.ref.child("Reservation").child(R_id).updateChildValues(["entered":"1"])

        if let index = reservationRequests.index(where: {$0.id == R_id}) {
            reservationRequests.remove(at: index)
        }
        self.reservationTable.reloadData()
    }
    @IBAction func LogOutAction(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "NurseId")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NurseLogin") as! NurseLogin
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
}
