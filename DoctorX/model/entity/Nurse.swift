//
//  Nurse.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class Nurse{
    
    private var _id:String!
    private var _name:String!
    private var _email:String!
    private var _password:String!
    private var _clinicId:String!
    private var _phone:String!
    private var _clinicName:String!
    private var _type:String!
    init(id:String, name:String, email:String,password:String,clinicId: String ,phone:String,clinicName:String ,type:String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.clinicId = clinicId
        self.phone = phone
        self.clinicName = clinicName
        self.type = type
    }
    public var type:String!{
        get{
            return _type
        }
        set{
            _type = newValue
        }
    }
    public var id:String!{
        get{
            return _id
        }
        set{
            _id = newValue
        }
    }
    public var phone:String!{
        get{
            return _phone
        }
        set{
            _phone = newValue
        }
    }
    
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
    public var email:String!{
        get{
            return _email
        }
        set{
            _email = newValue
        }
    }
    
    public var password:String!{
        get{
            return _password
        }
        set{
            _password = newValue
        }
    }
    public var clinicId:String!{
        get{
            return _clinicId
        }
        set{
            _clinicId = newValue
        }
    }
    public var clinicName:String!{
        get{
            return _clinicName
        }
        set{
            _clinicName = newValue
        }
    }
    public func nurseMapper()->[String:Any]{
        var nurse=[String:Any]()
        nurse["id"] = self.id
        nurse["clinicId"] = self.clinicId
        nurse["name"] = self.name
        nurse["email"] = self.email
        nurse["password"] = self.password
        nurse["phone"] = self.phone
        nurse["clinicName"] = self.clinicName
        nurse["type"] = self.type
        return nurse
    }
    public static func mapTonurse(nurse:[String:Any])->Nurse{
        let nurse = Nurse(id: nurse["id"] as! String, name: nurse["name"] as! String, email: nurse["email"] as! String, password: nurse["password"] as! String, clinicId: nurse["clinicId"] as! String,phone: nurse["phone"] as! String, clinicName: nurse["clinicName"] as! String , type: nurse["type"] as!String)
        return nurse
    }
}
