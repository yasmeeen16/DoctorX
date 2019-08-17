//
//  ReservationTypes.swift
//  DoctorX
//
//  Created by yasmeen on 7/22/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class ReservationTypes{
    
    private var _id:String!
    private var _name:String!
    private var _price:String!
    private var _isActive:String!

    init(id:String, name:String, price:String,isActive:String) {
        self.id = id
        self.name = name
        self.price = price
        self.isActive = isActive
        
    }
    public var id:String!{
        get{
            return _id
        }
        set{
            _id = newValue
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
    
    public var name:String!{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
    public var isActive:String!{
        get{
            return _isActive
        }
        set{
            _isActive = newValue
        }
    }
    

    public func typeMapper()->[String:Any]{
        var type = [String:Any]()
        type["id"] = self.id
        type["price"] = self.price
        type["name"] = self.name
        type["isActive"] = self.isActive
       
        return type
    }
    public static func mapToaType(type:[String:Any])->ReservationTypes{
        let type = ReservationTypes(id: type["id"] as! String, name: type["name"] as! String, price: type["price"] as! String, isActive: type["isActive"] as! String)
        return type
    }
}
