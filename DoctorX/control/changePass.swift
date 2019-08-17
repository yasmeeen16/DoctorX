//
//  changePass.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class changePass: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        pass.shadowView()
        confirmPass.shadowView()
        hideKeyboardWhenTappedAround()
        pass.delegate = self
        confirmPass.delegate = self
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
        if textField == self.pass {
            self.confirmPass.becomeFirstResponder()
        }else if textField == self.confirmPass {
            view.endEditing(true)
        }
        return true
    }
    @IBAction func updatePass(_ sender: Any) {
    }
    //    let currentUser = FIRAuth.auth()?.currentUser
//
//    currentUser?.updateEmail(email) { error in
//    if let error = error {
//    print(error)
//
//    } else {
//    // Email updated.
//    currentUser?.updatePassword(password) { error in
//    if let error = error {
//
//    } else {
//    // Password updated.
//    print("success")
//
//    }
//    }
//    }
//    }
}
