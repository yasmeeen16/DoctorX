//
//  AppointmentsReservation.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class AppointmentsReservation: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    var reservationAppointment = [PatiantData]()
    var ref: DatabaseReference!
    @IBOutlet weak var appointmentsTable: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reservationAppointment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appointmentsTable.dequeueReusableCell(withIdentifier: "cell") as! AppointmentCell
        cell.reservationDate.text = self.reservationAppointment[indexPath.row].reserveDate
        cell.reservationTime.text = self.reservationAppointment[indexPath.row].reserveTime
        cell.reservationclinic.text = self.reservationAppointment[indexPath.row].id
        cell.patiantName.text = self.reservationAppointment[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentsTable.delegate = self
        appointmentsTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.reservationAppointment = []
        ref = Database.database().reference()
        let defaults = UserDefaults.standard
        let user_k = defaults.object(forKey: "userKey")
        
        self.ref.child("Reservation").queryOrdered(byChild: "userKey").queryEqual(toValue: user_k).observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children {
                print(child)
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                let clinicId = dict["clinicId"]!
                let reserveDate = dict["reserveDate"]!
                let reserveTime = dict["reserveTime"]!
                let entered = dict["entered"]
                let name = dict["name"]
                self.ref.child("Clinics").queryOrdered(byChild: "id").queryEqual(toValue: clinicId).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let data = snapshot.value as? [String:Any]
                    if data == nil {
                        return
                    }
                    for (key,value) in data! {
                        print(value)
                        let ad = Clinic.mapToUser(user: value as! [String : Any])
                        ad.id = key
                        let clinicName = ad.name
                        let patient = PatiantData(id: clinicName!, name: name! , address: "", age: "", gender: "", clinicId: "", phone: "", lat: "", long: "", price: "", status: "", reserveType: "", reserveDate: reserveDate, reserveTime: reserveTime, userKey: "", nurseId: "", day: "", month: "", year: "", confirmed: "", entered: entered!)
                        self.reservationAppointment.append(patient)
                    }
                    
                    self.appointmentsTable.reloadData()
                    
                })
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
