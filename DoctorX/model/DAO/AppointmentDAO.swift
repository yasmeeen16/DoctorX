
//
//  AppointmentDAO.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
class ApointmentDAOImp {
    private var ref: DatabaseReference
    private let node = "Clinic_Appointment"
    var Appointments:[Appointment] = [Appointment]()
    var AppointmentsSorted:[Appointment] = [Appointment]()
    init(databaseReference ref: DatabaseReference ,clinicId:String){
        self.ref = ref.child(node).child(clinicId)
    }
    public func saveUser(user: Appointment,day:String){
        let us = user.userMapper()
        let childRef = ref.child(day)
        childRef.setValue(us)
        user.id = childRef.key
        //childRef.child("id").setValue(user.id)
    }
    public func allAppointment(table: UITableView,loader:UIView){
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.hasChild("day1"){
                            print("true clinic exist")
                        }else{
                            ///loader end
                            UIViewController.removeSpinner(spinner: loader)
                            print("false clinic doesn't exist")
                        }
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                print(value)
                let ad = Appointment.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Appointments.append(ad)
            }
            if self.Appointments.count == 0 {
                UIViewController.removeSpinner(spinner: loader)
                print("no ads")
            }
            
            self.AppointmentsSorted =   self.Appointments.sorted(by: { $0.id < $1.id })
            print("size",self.Appointments.count)
            ///loader end
            //            loader.stopAnimating()
            //            UIApplication.shared.endIgnoringInteractionEvents()
            UIViewController.removeSpinner(spinner: loader)
            table.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    public func allAppointment(loader:UIView){
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild("day1"){
                print("true clinic exist")
            }else{
                ///loader end
                UIViewController.removeSpinner(spinner: loader)
                print("false clinic doesn't exist")
            }
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                print(value)
                let ad = Appointment.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Appointments.append(ad)
            }
            if self.Appointments.count == 0 {
                UIViewController.removeSpinner(spinner: loader)
                print("no ads")
            }
            
            self.AppointmentsSorted =   self.Appointments.sorted(by: { $0.id < $1.id })
            print("size",self.Appointments.count)
            ///loader end
            //            loader.stopAnimating()
            //            UIApplication.shared.endIgnoringInteractionEvents()
            UIViewController.removeSpinner(spinner: loader)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    var appoints = ["",""]
    var appointCount = 0
    public func allBooking(collec: UICollectionView,loader:UIView,clinicId:String,day:String){
        ref.child(day).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if value == nil {
                print("nil day")
                ///loader end
                self.appoints.removeAll()
                self.appointCount = 0
                collec.reloadData()
                UIViewController.removeSpinner(spinner: loader)
                return
            }
            let book = Appointment.mapToUser(user: value as! [String : Any])
            var toHour:Int!
            var fromHour:Int!
            var workTime:Int!
            var toHour2:Int!
            var fromHour2:Int!
            var workTime2:Int!
            var appoint:String!
            if book.id == day{
                print("in for loop")
                self.appoints.removeAll()
                self.appointCount = 0
                fromHour = book.morning["fromH"] as? Int ?? 0
                toHour = book.morning["toH"] as? Int ?? 0
                if fromHour > 12{
                    fromHour = fromHour - 12
                }
                if toHour > 12{
                    toHour = toHour - 12
                }

                workTime = toHour - fromHour
                //
                fromHour2 = book.evening["fromH"] as? Int ?? 0
                toHour2 = book.evening["toH"] as? Int ?? 0
                if fromHour2 > 12{
                    fromHour2 = fromHour2 - 12
                }
                if toHour2 > 12{
                    toHour2 = toHour2 - 12
                }
                workTime2 = toHour2 - fromHour2
                if workTime2 < 0 {
                    workTime2 = workTime2 * -1
                }else if workTime2 == 0{
                    ///loader end
                    UIViewController.removeSpinner(spinner: loader)
                    collec.reloadData()
                    return
                }
                if workTime < 0 {
                    workTime = workTime * -1
                }else if workTime == 0{
                    ///loader end
                    UIViewController.removeSpinner(spinner: loader)
                    collec.reloadData()
                    return
                }
                for i in 0..<(workTime * 2){
                    if (i % 2) == 0 {
                        appoint = "\(fromHour!) : 00"
                        print(appoint)
                        self.appoints.append(appoint)
                    }else{
                        appoint = "\(fromHour!) : 30"
                        self.appoints.append(appoint)
                        print(appoint)
                        fromHour = fromHour + 1
                    }
                    self.appointCount = self.appoints.count
                    collec.reloadData()
                }
                ///// evening times
                for i in 0..<(workTime2 * 2){
                    if (i % 2) == 0 {
                        appoint = "\(fromHour2!) : 00"
                        print(appoint)
                        self.appoints.append(appoint)
                    }else{
                        appoint = "\(fromHour2!) : 30"
                        self.appoints.append(appoint)
                        print(appoint)
                        fromHour2 = fromHour2 + 1
                    }
                    self.appointCount = self.appoints.count
                    collec.reloadData()
                }
            }
            
            ///loader end
            UIViewController.removeSpinner(spinner: loader)
            
            collec.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
