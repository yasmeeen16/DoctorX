//
//  patiantAppointment.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class patiantAppointment{

private var _id:String!
private var _clinicId:String!
private var _date:String!
private var _time:String!
    
    init(id:String, clinicId:String, date:String,time :String) {
    self.id = id
    self.clinicId = clinicId
    self.date = date
    self.time = time
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

public var date:String!{
    get{
        return _date
    }
    set{
        _date = newValue
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
public func AppMapper()->[String:Any]{
    var app=[String:Any]()
    app["id"] = self.id
    app["clinicId"] = self.clinicId
    app["date"] = self.date
    app["time"] = self.time
    return app
}
public static func mapToapp(app:[String:Any])->patiantAppointment{
    let app = patiantAppointment(id: app["id"] as! String, clinicId: app["clinicId"] as! String, date: app["date"] as! String, time: app["time"] as! String)
    return app
}
}
