
//
//  ClinicDAOImp.swift
//  DoctorX
//
//  Created by Marwa on 6/24/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class ClinicDAOImp {
    private var ref: DatabaseReference
    private let node = "Clinics"
    var Clinics:[Clinic] = [Clinic]()
    init(databaseReference ref: DatabaseReference){
        self.ref = ref.child(node)
    }
    public func saveUser(user: Clinic){
        let us = user.userMapper()
        let childRef = ref.childByAutoId()
        childRef.setValue(us)
        user.id = childRef.key
        //childRef.child("id").setValue(user.id)
    }
    public func editUser(user: Clinic,clinicId:String){
        let us = user.userMapper()
        let childRef = ref.child(clinicId)
        childRef.setValue(us)
        user.id = childRef.key
        //childRef.child("id").setValue(user.id)
    }
    public func allClinics(table: UITableView,loader:UIView){
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
//                print(value)
                let ad = Clinic.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Clinics.append(ad)
            }
            if self.Clinics.count == 0 {
                print("no ads")
            }
            print("size",self.Clinics.count)
            ///loader end
            //            loader.stopAnimating()
            //            UIApplication.shared.endIgnoringInteractionEvents()
            UIViewController.removeSpinner(spinner: loader)
            table.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    public func allClinics(collec: UICollectionView,loader:UIView){
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
//                print(value)
                let ad = Clinic.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Clinics.append(ad)
            }
            if self.Clinics.count == 0 {
                print("no ads")
                UIViewController.removeSpinner(spinner: loader)
            }
            print("size",self.Clinics.count)
            ///loader end
            //            loader.stopAnimating()
            //            UIApplication.shared.endIgnoringInteractionEvents()
            UIViewController.removeSpinner(spinner: loader)
            collec.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    static var FirebaseToken : String? {
        return InstanceID.instanceID().token()
    }
}
