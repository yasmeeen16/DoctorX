//
//  ChangePassword.swift
//  DoctorX
//
//  Created by yasmeen on 8/24/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
class ChangePassword: UIViewController {
    var doctorId = ""

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("Nurses").child(self.doctorId).observeSingleEvent(of: .value, with:
            { (snapshot) in
                let data = snapshot.value as? [String:Any]
                for (key,value) in data! {
                  
                    if key == "Email"{
                        self.email.text = value as? String
                    }
                    if key == "password"{
                        self.password.text = value as? String
                    }
                    
                }
        })

        // Do any additional setup after loading the view.
    }
    
  
 
    @IBAction func editNurseData(_ sender: Any) {
        if !self.DataFiled(self.email.text!){
            self.showToast(message: "Enter Email")
        }else if !self.isEmailValid(self.email.text!){
            self.showToast(message: "Email not Valid")
        }else if !self.DataFiled(self.password.text!){
            self.showToast(message: "Enter Password")
        }else{ref.child("Nurses").child(self.doctorId).updateChildValues(["Email":self.email.text! ,"password":self.password.text!])
            showToast(message: "تم التعديل")
           backTwo()
        }
        
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
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
