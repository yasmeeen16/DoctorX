//
//  User.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import Foundation
import FirebaseAuth
class User{
    
    private var _id:String!
    private var _userName:String!
    private var _privilege:String!
    private var _mobile:String!
    private var _email:String!
    init(id:String, userName:String, mobile:String!,privilege:String,email:String) {
        self.id = id
        self.userName = userName
        self.mobile = mobile
        self.privilege = privilege
        self.email = email
        
    }
    public var email:String!{
        get{
            return _email
        }
        set{
            _email = newValue
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
    
    public var userName:String!{
        get{
            return _userName
        }
        set{
            _userName = newValue
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
    
    public var privilege:String!{
        get{
            return _privilege
        }
        set{
            _privilege = newValue
        }
    }
    public func userMapper()->[String:Any]{
        var user=[String:Any]()
        user["id"] = self.id
        user["userName"] = self.userName
        user["mobile"] = self.mobile
        user["privilege"] = self.privilege
        user["email"] = self.email
        return user
    }
    public static func mapToUser(user:[String:Any],key:String)->User{
        let user = User(id: user["id"] as! String, userName: user["userName"] as! String, mobile: user["mobile"] as? String, privilege: user["privilege"] as! String, email: user["email"] as! String)
        return user
    }
}
