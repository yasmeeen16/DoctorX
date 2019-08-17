
//
//  Appointment.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class Appointment{
    private var _id:String!
    private var _clinicId:String!
    private var _evening:[String:Any]!
    private var _morning:[String:Any]!
    init(id:String, clinicId:String, evening:[String:Any],morning:[String:Any]) {
        self.id = id
        self.clinicId = clinicId
        self.evening = evening
        self.morning = morning
    }
    public var id:String!{
        get{
            return _id
        }
        set{
            _id = newValue
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
    
    public var evening:[String:Any]!{
        get{
            return _evening
        }
        set{
            _evening = newValue
        }
    }
    
    public var morning:[String:Any]!{
        get{
            return _morning
        }
        set{
            _morning = newValue
        }
    }
    public func userMapper()->[String:Any]{
        var user=[String:Any]()
        user["id"] = self.id
        user["clinicId"] = self.clinicId
        user["evening"] = self.evening
        user["morning"] = self.morning
        return user
    }
    public static func mapToUser(user:[String:Any])->Appointment{
        let user = Appointment(id: user["id"] as! String, clinicId: user["clinicId"] as! String, evening: user["evening"] as! [String:Any], morning: user["morning"] as! [String:Any])
        return user
    }
}
