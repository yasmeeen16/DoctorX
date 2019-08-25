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
                let defaults = UserDefaults.standard
                
                if clinicId == "\(defaults.object(forKey: "clinicId")!)"{
                    
                    
                    
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
                                //type = dict["name"]!
                        
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
        return self.reservationRequests.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 203
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 203
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NurseReservationRequest
            let reserve = self.reservationRequests[section]
            cell.configureCellEn(reservation: reserve)
            
            return cell
            
        }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    //delete
    @IBAction func cancelAction(_ sender: Any) {
        let R_id = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        
        self.ref.child("Reservation").child(R_id).removeValue()
        
        //let idToDelete = 10
        if let index = reservationRequests.index(where: {$0.id == R_id}) {
            reservationRequests.remove(at: index)
        }
        self.requestsTable.reloadData()
        
    }
    

}
