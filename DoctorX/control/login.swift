
//
//  login.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class login: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    var Spinner :UIView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        email.shadowView()
        pass.shadowView()
        hideKeyboardWhenTappedAround()
        email.delegate = self
        pass.delegate = self
        //scroll step 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom:200, right: 0)
        scroll.contentInset = contentInset
    }
    //step2 add method to handle tap event
    @objc func didTapView(gesture:UIGestureRecognizer){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.email {
            self.pass.becomeFirstResponder()
        }else if textField == self.pass {
            view.endEditing(true)
        }
        return true
    }
    @IBAction func signUp(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Registraion") as! Registraion
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    @IBAction func login(_ sender: Any) {
        Spinner = UIViewController.displaySpinner(onView: self.view)
        guard let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            alertmessage(Message: "ادخل البريد الالكتروني")
            UIViewController.removeSpinner(spinner: self.Spinner)
            return
        }
        guard let password = pass.text, !password.isEmpty else  {
            alertmessage(Message:"ادخل كلمة المرور")
            UIViewController.removeSpinner(spinner: self.Spinner)
            return
        }
        self.view.endEditing(true)
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            // ..
            if let error = error{
                print(error.localizedDescription)
                if error._code == 17011 {
                    UIViewController.removeSpinner(spinner: self.Spinner)
                    //user not found
                    self.alertmessage(Message: "لا يوجد مستخدم بهذا البريد الالكتروني")
                }else {
                    UIViewController.removeSpinner(spinner: self.Spinner)
                    //invalid email or password
                    self.alertmessage(Message: "كلمة المرور او البريد الالكتروني غير صحيح")
                }
            }else{
                if let user = user {
                    UIViewController.removeSpinner(spinner: self.Spinner)
                    var type = ""
                    print("this is the user \(user.user.uid)")
                    self.ref.child("Users").child(user.user.uid).child("privilege").observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let privilege = snapshot.value as? String
                        print(privilege)
                        if privilege == "1" {
                            type = "1"
                            // userDefault
                            UserDefaults.standard.set("1", forKey: "type")
                            UserDefaults.standard.set(true, forKey: "Login")
                            print("user type : \(type)")
                            // go to main vc
                            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "adminHome") {
                                UIApplication.shared.keyWindow?.rootViewController = viewController
                                self.dismiss(animated: true, completion: nil)
                            }
                        }else if privilege == "0"{
                            // userDefault
                            type = "0"
                            UserDefaults.standard.set("0", forKey: "type")
                            UserDefaults.standard.set(true, forKey: "Login")
                            print("user type : \(type)")
                            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                                UIApplication.shared.keyWindow?.rootViewController = viewController
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    print("user type : \(type)")
                }
            }
        }
    }
    func alertmessage (Message : String) {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: "تأكيد", message: Message, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { action in
//                mark to add segue
//                switch action.style{
//                case .default: break
//                case .cancel: break
//                case .destructive: break
//                }}))
//            self.present(alert, animated: true, completion: nil)
//        }
    }

}
