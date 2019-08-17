//
//  Clinic.swift
//  DoctorX
//
//  Created by Marwa on 6/24/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class Clinic{
    
    private var _id:String!
    private var _name:String!
    private var _address:String!
    private var _mobile:String!
    private var _phone:String!
    private var _days:String!
    private var _time:String!
    private var _latitude:String!
    private var _longitude:String!
    private var _z:String!
    init(id:String, name:String, mobile:String,phone:String,address:String,time:String,days:String,latitude:String,longitude:String,z:String) {
        self.id = id
        self.name = name
        self.mobile = mobile
        self.phone = phone
        self.address = address
        self.days = days
        self.time = time
        self.latitude = latitude
        self.longitude = longitude
        self.z = z
        
    }
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
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
    
    public var mobile:String!{
        get{
            return _mobile
        }
        set{
            _mobile = newValue
        }
    }
    
    public var address:String!{
        get{
            return _address
        }
        set{
            _address = newValue
        }
    }
    public var days:String!{
        get{
            return _days
        }
        set{
            _days = newValue
        }
    }
    public var time:String!{
        get{
            return _time
        }
        set{
            _time = newValue
        }
    }
    ///
    public var latitude:String!{
        get{
            return _latitude
        }
        set{
            _latitude = newValue
        }
    }
    public var z:String!{
        get{
            return _z
        }
        set{
            _z = newValue
        }
    }
    public var longitude:String!{
        get{
            return _longitude
        }
        set{
            _longitude = newValue
        }
    }
    public func userMapper()->[String:Any]{
        var user=[String:Any]()
        user["id"] = self.id
        user["name"] = self.name
        user["mobile"] = self.mobile
        user["phone"] = self.phone
        user["address"] = self.address
        user["time"] = self.time
        user["latitude"] = self.latitude
        user["days"] = self.days
        user["longitude"] = self.longitude
        user["z"] = self.z
        return user
    }
    public static func mapToUser(user:[String:Any])->Clinic{
        let user = Clinic(id: user["id"] as! String, name: user["name"] as! String, mobile: user["mobile"] as! String, phone: user["phone"] as! String, address: user["address"] as! String, time: user["time"] as! String, days: user["days"] as! String, latitude: user["latitude"] as! String, longitude: user["longitude"] as! String, z: user["z"] as! String)
        return user
    }
}
