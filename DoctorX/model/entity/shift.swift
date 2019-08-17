//
//  shift.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
class shift{
    private var _fromH:String!
    private var _fromText:String!
    private var _toH:String!
    private var _toText:String!
    init(fromH:String, fromText:String, toH:String,toText:String) {
        self.fromH = fromH
        self.fromText = fromText
        self.toH = toH
        self.toText = toText
    }
    public var fromH:String!{
        get{
            return _fromH
        }
        set{
            _fromH = newValue
        }
    }
    
    public var toH:String!{
        get{
            return _toH
        }
        set{
            _toH = newValue
        }
    }
    
    public var fromText:String!{
        get{
            return _fromText
        }
        set{
            _fromText = newValue
        }
    }
    
    public var toText:String!{
        get{
            return _toText
        }
        set{
            _toText = newValue
        }
    }
    public func userMapper()->[String:Any]{
        var user=[String:Any]()
        user["fromText"] = self.fromText
        user["toText"] = self.toText
        user["toH"] = self.toH
        user["fromH"] = self.fromH
        return user
    }
}
