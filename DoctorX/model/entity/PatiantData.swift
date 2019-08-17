//
//  PatiantData.swift
//  DoctorX
//
//  Created by yasmeen on 7/7/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation

class PatiantData{
    
    private var _id:String!
    private var _name:String!
    private var _address:String!
    private var _age:String!
    private var _gender:String!
    private var _phone:String!
    private var _clinicId:String!
    private var _lat:String!
    private var _long:String!
    private var _price:String!
    private var _reserveType:String!
    private var _reserveDate:String!
    private var _reserveTime:String!
    private var _status:String!
    private var _userKey:String!
    private var _nurseId:String!
    private var _year:String!
    private var _month:String!
    private var _day:String!
    private var _confirmed:String!
    private var _entered:String!
    init(id:String,name:String, address:String,age:String,gender:String,clinicId:String , phone:String ,lat:String,long:String,price:String,status:String,reserveType:String,reserveDate:String,reserveTime:String ,userKey:String ,nurseId:String , day:String, month :String , year : String, confirmed:String, entered:String) {
        self.id = id
        self.name = name
        self.address = address
        self.age = age
        self.gender = gender
        self.phone = phone
        self.clinicId = clinicId
        self.lat = lat
        self.long = long
        self.price = price
        self.reserveDate = reserveDate
        self.reserveTime = reserveTime
        self.reserveType = reserveType
        self.status = status
        self.userKey = userKey
        self.nurseId = nurseId
        self.year = year
        self.month = month
        self.day = day
        self.confirmed = confirmed
        self.entered = entered
    }
    public var entered:String{
        get{
            return _entered
        }set{
            _entered = newValue
        }
    }
    public var confirmed: String{
        get{
           return _confirmed
        }set{
            _confirmed = newValue
        }
    }
    public var year:String{
        get{
            return _year
        }
        set{
            _year = newValue
        }
        
    }
    public var month:String{
        get{
           return _month
        }
        set{
            _month = newValue
        }
    }
    public var day:String{
        get{
            return _day
        }
        set{
            _day = newValue
        }
    }
    public var nurseId:String!{
        get{
            return _nurseId
        }set{
            _nurseId = newValue
        }
    }
    public var userKey:String!{
    get{
        return _userKey
    }
    set{
        _userKey = newValue
        }
    }
    public var age:String!{
        get{
            return _age
        }
        set{
            _age = newValue
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
    
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
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
    
    public var address:String!{
        get{
            return _address
        }
        set{
            _address = newValue
        }
    }
    public var gender:String!{
        get{
            return _gender
        }
        set{
            _gender = newValue
        }
    }
    public var lat:String!{
        get{
            return _lat
        }
        set{
            _lat = newValue
        }
    }
    public var long:String!{
        get{
            return _long
        }
        set{
            _long = newValue
        }
    }
    public var status:String!{
        get{
            return _status
        }
        set{
            _status = newValue
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
    public var price:String!{
        get{
            return _price
        }
        set{
            _price = newValue
        }
    }
    public var reserveDate:String!{
        get{
            return _reserveDate
        }
        set{
            _reserveDate = newValue
        }
    }
    public var reserveTime:String!{
        get{
            return _reserveTime
        }
        set{
            _reserveTime = newValue
        }
    }
    public var reserveType:String!{
        get{
            return _reserveType
        }
        set{
            _reserveType = newValue
        }
    }
    public func reserveMapper()->[String:Any]{
        var reserve=[String:Any]()
        reserve["id"] = self.id
        reserve["name"] = self.name
        reserve["phone"] = self.phone
        reserve["address"] = self.address
        reserve["age"] = self.age
        reserve["gender"] = self.gender
        reserve["clinicId"] = self.clinicId
        reserve["lat"] = self.lat
        reserve["long"] = self.long
        reserve["price"] = self.price
        reserve["status"] = self.status
        reserve["reserveTime"] = self.reserveTime
        reserve["reserveType"] = self.reserveType
        reserve["reserveDate"] = self.reserveDate
        reserve["userKey"] = self.userKey
        reserve["nurseId"] = self.nurseId
        reserve["day"] = self.day
        reserve["month"] = self.month
        reserve["year"] = self.year
        reserve["confirmed"] = self.confirmed
        reserve["entered"] = self.entered
        return reserve
    }
    public static func mapToReservation(user:[String:Any],key:String)->PatiantData{
        let user = PatiantData(id: user["id"] as! String, name: user["name"] as! String, address: user["address"] as! String, age: user["age"] as! String, gender: user["gender"] as! String, clinicId: user["clinicId"] as! String, phone:user["phone"] as! String, lat: user["lat"] as! String, long: user["long"] as! String, price: user["price"] as! String,status: user["status"] as! String, reserveType: user["reserveType"] as! String, reserveDate:user["reserveDate"] as! String,  reserveTime: user["reserveTime"] as! String, userKey: user["userKey"] as! String, nurseId: user["nurseId"] as! String, day: user["day"] as! String, month: user["month"] as! String, year: user["year"] as! String, confirmed: user["confirmed"] as! String, entered: user["entered"] as! String  )
        return user
    }
}
