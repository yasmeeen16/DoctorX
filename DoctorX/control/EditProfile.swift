//
//  EditProfile.swift
//  DoctorX
//
//  Created by Marwa on 6/24/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class EditProfile: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var aboutLb: UITextView!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    var type =  UserDefaults.standard.string(forKey: "type")
    let uid = Auth.auth().currentUser!.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        Spinner = UIViewController.displaySpinner(onView: self.view)
        //scroll step 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom:200, right: 0)
        scroll.contentInset = contentInset
        self.ref = Database.database().reference()
        name.shadowView()
        phone.shadowView()
        aboutLb.shadowView()
        aboutLb.delegate = self
        name.delegate = self
        phone.delegate = self
        if type == nil {
            print("nil")
        }else if type == "2"{
            aboutLb.isHidden = false
        }else{
            aboutLb.isHidden = true
        }
        ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                
                return
            }
            for (key,value) in data! {
                if key == "userName" {
                    let name = value as! String
                    self.name.text = name
                }
                if key == "mobile" {
                    let mobile = value as! String
                    self.phone.text = mobile
                }
                if key == "privilege" {
                    let privilege = value as! String
                    if privilege == "2"{
                        self.ref.child("DoctorInfo").child(self.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                            // Get user value
                            let data = snapshot.value as? [String:Any]
                            if data == nil {
                                return
                            }
                            for (key,value) in data! {
                                if key == "about" {
                                    let mobile = value as! String
                                    self.aboutLb.text = mobile
                                    UIViewController.removeSpinner(spinner: self.Spinner)
                                }
                            }
                            
                    }) { (error) in
                        print(error.localizedDescription)
                        UIViewController.removeSpinner(spinner: self.Spinner)
                    }
                        //
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    //step2 add method to handle tap event
    @objc func didTapView(gesture:UIGestureRecognizer){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.name {
            self.phone.becomeFirstResponder()
        }else if textField == self.phone {
            self.aboutLb.becomeFirstResponder()
        }else if textField == self.aboutLb {
            view.endEditing(true)
        }
        return true
    }
    @IBAction func save(_ sender: Any) {
        if name.text != "" && phone.text != ""   {
            ref.child("Users").child(uid).child("userName").setValue(name.text!)
            ref.child("Users").child(uid).child("mobile").setValue(phone.text!)
            if type == "2"{
                if aboutLb.text != "" {
                     ref.child("DoctorInfo").child(uid).child("about").setValue(aboutLb.text!)
                }else{
                     alertmessage(Message: "اكمل البيانات")
                }
               
            }
            
        }else{
            alertmessage(Message: "اكمل البيانات")
        }
    }
    func alertmessage (Message : String) {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "تأكيد", message: Message, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
//                //mark to add segue
//                switch action.style{
//                case .default: break
//                case .cancel: break
//                case .destructive: break
//                }}))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
}
