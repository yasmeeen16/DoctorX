//
//  ReservationTypeDAO.swift
//  DoctorX
//
//  Created by yasmeen on 7/22/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class ReservationTypeDAO {
    private var ref: DatabaseReference
    private let node = "Reserve_Type"
    var types:[ReservationTypes] = [ReservationTypes]()
    init(databaseReference ref: DatabaseReference){
        self.ref = ref.child(node)
    }
    public func saveType(type: ReservationTypes){
        let ty = type.typeMapper()
        let childRef = ref.childByAutoId()
        childRef.setValue(ty)
        type.id = childRef.key
        childRef.child("id").setValue(type.id)
    }

    public func allTypes(table: UITableView,loader:UIView){
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                let ad = ReservationTypes.mapToaType(type: value as! [String : Any])
                ad.id = key
                self.types.append(ad)
            }
            if self.types.count == 0 {
                print("no ads")
            }
            print("size",self.types.count)

            UIViewController.removeSpinner(spinner: loader)
            table.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    public func EditType(type: ReservationTypes,typeId:String){
        let ty = type.typeMapper()
        let childRef = ref.child(typeId)
        childRef.setValue(ty)
        type.id = childRef.key
        if type.isActive == "1"{
            type.isActive = "0"
        }else{
            type.isActive = "1"
        }
        childRef.child("id").setValue(type.id)
        childRef.child("isActive").setValue(type.isActive)
        
    }
    
    static var FirebaseToken : String? {
        return InstanceID.instanceID().token()
    }
}
