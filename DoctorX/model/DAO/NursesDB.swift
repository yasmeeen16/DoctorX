//
//  NursesDB.swift
//  DoctorX
//
//  Created by yasmeen on 7/14/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class NursesDB{
    private var ref: DatabaseReference
    private let node = "Nurses"
    var nurses:[Nurse] = [Nurse]()
    init(databaseReference ref: DatabaseReference){
        self.ref = ref.child(node)
    }
    public func saveNurse(nurse: Nurse){
        
        let pa = nurse.nurseMapper()
        let childRef = ref.childByAutoId()
        childRef.setValue(pa)
        nurse.id = childRef.key
        
        childRef.child("id").setValue(nurse.id)
        
    }
}
