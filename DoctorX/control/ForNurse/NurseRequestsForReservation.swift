//
//  NurseRequestsForReservation.swift
//  DoctorX
//
//  Created by yasmeen on 7/16/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NurseRequestsForReservation: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var requestsTable: UITableView!
    var ref: DatabaseReference!
    var reservationRequests = [PatiantData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        requestsTable.dataSource = self
        requestsTable.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {
        self.reservationRequests = []
        ref = Database.database().reference()
        self.ref.child("Reservation").queryOrdered(byChild: "confirmed").queryEqual(toValue: "0").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                print(child)
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
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
                let defaults = UserDefaults.standard
                var type = ""
                if clinicId == "\(defaults.object(forKey: "clinicId")!)"{
                    
                    
                    
                    self.ref.child("Reserve_Type").queryOrdered(byChild: "id").queryEqual(toValue: reserveType).observeSingleEvent(of: .value, with: { (snapshot) in
                        for child in snapshot.children {
                            print(child)
                            let snap = child as! DataSnapshot
                            let dict = snap.value as! [String: String]
                            type = dict["name"]!
                            
                            print("==============================")
                            print(type)
                  
                        let reserveRequest = PatiantData(id: id, name: name, address: address, age: age, gender: gender, clinicId: clinicId, phone: phone, lat: lat, long: long, price: price, status: status, reserveType: type, reserveDate: reserveDate, reserveTime: reserveTime, userKey: userKey, nurseId: nurseId, day: day, month: month, year: year, confirmed: confirmed, entered: entered)
                        self.reservationRequests.append(reserveRequest)
                            self.requestsTable.reloadData()
                        }
                    })
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NurseReservationRequest
        let reserve = self.reservationRequests[indexPath.row]
        cell.configureCellEn(reservation: reserve)
        
        return cell
    }
    
    @IBAction func AcceptBtn(_ sender: Any) {
        let R_id = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        
      self.ref.child("Reservation").child(R_id).updateChildValues(["confirmed":"1"])
        let idToDelete = 10
        if let index = reservationRequests.index(where: {$0.id == R_id}) {
            reservationRequests.remove(at: index)
        }
        self.requestsTable.reloadData()
    }
    
}
