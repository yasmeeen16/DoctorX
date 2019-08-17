//
//  ReservationDAO.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class ReservationDAO {
    private var ref: DatabaseReference
    private let node = "Reservation"
    var Reserve:[PatiantData] = [PatiantData]()
    init(databaseReference ref: DatabaseReference){
        self.ref = ref.child(node)
    }
    public func savepatiantData(patiant: PatiantData){
        
        let pa = patiant.reserveMapper()
        let childRef = ref.childByAutoId()
        childRef.setValue(pa)
        patiant.id = childRef.key
      
        childRef.child("id").setValue(patiant.id)

    }
    func getAllAppointment(){
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
        })
    }
    static var FirebaseToken : String? {
        return InstanceID.instanceID().token()
    }
}
