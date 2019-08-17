//
//  UserDAOImp.swift
//  DoctorX
//
//  Created by Marwa on 6/23/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class UserDAOImp {
    private var ref: DatabaseReference
    private let node = "Users"
    var Users:[User] = [User]()
    init(databaseReference ref: DatabaseReference,id:String){
        self.ref = ref.child(node).child(id)
    }
    public func saveUser(user: User){
        let us = user.userMapper()
        let childRef = ref
        childRef.setValue(us)
        user.id = childRef.key
        //childRef.child("id").setValue(user.id)
    }
    public func getUser(userId:String) -> User{
        var user = User(id: ""
            , userName: "", mobile: "", privilege: "", email: "")
        ref.child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            var name = ""
            var email = ""
            var phone = ""
            var privilege = ""
            // Get user value
            let data = snapshot.value as? [String:Any]
            for (key,value) in data! {
                if key == "userName" {
                    name = value as! String
                }
                if key == "email" {
                    email = value as! String
                }
                if key == "mobile" {
                    phone = value as! String
                }
                if key == "privilege" {
                    privilege = value as! String
                }
            }
            user = User(id: userId
                , userName: name, mobile: phone, privilege: privilege, email: email)
        }) { (error) in
            print(error.localizedDescription)
            
        }
        return user
    }
    static var FirebaseToken : String? {
        return InstanceID.instanceID().token()
    }
}
