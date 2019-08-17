//
//  Registraion.swift
//  DoctorX
//
//  Created by Marwa on 6/23/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class Registraion: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    var ref: DatabaseReference!
    var Spinner :UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        email.shadowView()
        pass.shadowView()
        name.shadowView()
        phone.shadowView()
        hideKeyboardWhenTappedAround()
        email.delegate = self
        pass.delegate = self
        name.delegate = self
        phone.delegate = self
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
    @IBAction func login(_ sender: Any) {
        Spinner = UIViewController.displaySpinner(onView: self.view)
        let Name =  name.text
        let Email = email.text
        let Password = pass.text
        let Phone = phone.text
        if Name != "" && Email != "" && Password != "" && Phone != "" {
                Auth.auth().createUser(withEmail: Email!, password: Password!) { (authResult, error) in
                    if let error = error{
                        if (error._code == 17007){
                            UIViewController.removeSpinner(spinner: self.Spinner)
                            self.alertmessage(Message:"هذا البريد الالكتروني مستخدم من قبل")
                        }else if (error._code == 17026){
                            UIViewController.removeSpinner(spinner: self.Spinner)
                            self.alertmessage(Message:"كلمة المرور يجب ان تكون اكثر من 6 حروف او ارقام")
                        }else{
                            UIViewController.removeSpinner(spinner: self.Spinner)
                            print(error.localizedDescription)
                            print(error._code)
                            
                            self.alertmessage(Message:"حدث خطـأ , حاول لاحقا")
                        }
                        UIViewController.removeSpinner(spinner: self.Spinner)
                        return
                    } else{
                        let uid = Auth.auth().currentUser!.uid
                        let token = InstanceID.instanceID().token()
                        if token != nil {
                            UIViewController.removeSpinner(spinner: self.Spinner)
                            UserDefaults.standard.set(uid, forKey: "userId")
                            UserDefaults.standard.set("0", forKey: "type")
                            let userDAO = UserDAOImp(databaseReference:self.ref, id: uid)
                            let us = User(id:uid, userName: Name!, mobile: Phone!, privilege: "0", email:Email!)
                            userDAO.saveUser(user: us)
                            //Registered
                            //                            self.view.showToast(toastMessage: "Registered", duration: 5.0)
                            /// go to main vc
                            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                                UIApplication.shared.keyWindow?.rootViewController = viewController
                                
                            }
                        }
                    }
                }
        }else{
            UIViewController.removeSpinner(spinner: self.Spinner)
            alertmessage(Message: "أكمل البيانات")
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
