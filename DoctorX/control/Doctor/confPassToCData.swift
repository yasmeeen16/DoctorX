





//
//  confPassToCData.swift
//  DoctorX
//
//  Created by yasmeen on 8/21/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class confPassToCData: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var password: UITextField!
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //        if UserDefaults.standard.string(forKey:"NurseId") != ""{
        //            print("Loged in  >>>>>>>>>>>>>>>")
        //             self.performSegue(withIdentifier: "mainSegueForNurse", sender: self)
    }
    // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
        var successLogin = false
        ref.child("Nurses").queryOrdered(byChild: "active").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if !self.DataFiled(self.Email.text!){
                self.showToast(message: "Enter Email")
            }else if !self.isEmailValid(self.Email.text!){
                self.showToast(message: "Email not Valid")
            }else if !self.DataFiled(self.password.text!){
                self.showToast(message: "Enter Password")
            }else{
                let data = snapshot.value as? [String:Any]
                for child in snapshot.children {
                    print(child)
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    var mail = ""
                    var password = ""
                    var type = ""
                    var id = ""
                    for (key,value) in dict {
                        if key == "Email" {
                            mail = value as! String
                        }
                        if key == "password" {
                            password = value as! String
                        }
                        if key == "type" {
                            type = value as! String
                        }
                        if key == "id" {
                            id = value as! String
                        }
                    }
//                    let mail = dict["Email"]!
//                    let password = dict["password"]!
//                    let type = dict["type"]
//                    let id = dict["id"]
                    if mail == self.Email.text! && password == self.password.text! &&  type == "doctor"{
                        successLogin = true
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict["id"]!, forKey: "DoctorId")
                        //defaults.setValue(dict["clinicname"]!, forKey: "clinicname")
                        //defaults.setValue(dict["clinicId"]!, forKey: "clinicId")
                        // self.showToast(message: "Login success")
                        //                            self.performSegue(withIdentifier: "changePassword", sender: self)
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChangeData") as! ChangeData
                        nextViewController.doctorId = id
                        self.navigationController?.pushViewController(nextViewController, animated:
                            true)
                    }
                }
                if successLogin == false{
                    self.showToast(message: "Encorrect Data")
                }
            }
        })
        
    }
    
    public func isEmailValid(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                print("no")
                return false
            }
        } catch {
            print("no")
            return false
        }
        
        print("yes")
        return true
    }
    public func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func DataFiled(_ value:String)->Bool{
        if ( value != "" ) {
            return true
        }
        return false
    }
    
    
}



