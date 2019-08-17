//
//  editClinic.swift
//  DoctorX
//
//  Created by Marwa on 6/24/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class editClinic: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var days: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var address: UITextField!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    var clinicDAO:ClinicDAOImp!
    var clinicId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ref = Database.database().reference()
        clinicDAO = ClinicDAOImp(databaseReference: ref)
        name.delegate = self
        phone.delegate = self
        mobile.delegate = self
        address.delegate = self
        time.delegate = self
        days.delegate  = self
        //scroll step 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom:200, right: 0)
        scroll.contentInset = contentInset
        //get clinic details
        ref.child("Clinics").child(clinicId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                if key == "address" {
                    let address = value as! String
                    self.address.text = address
                }
                if key == "days" {
                    let days = value as! String
                    self.days.text = days
                }
                if key == "mobile" {
                    let mobile = value as! String
                    self.mobile.text = mobile
                }
                if key == "name" {
                    let name = value as! String
                    self.name.text = name
                }
                if key == "phone" {
                    let phone = value as! String
                    self.phone.text = phone
                }
                if key == "time" {
                    let time = value as! String
                    self.time.text = time
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
            self.mobile.becomeFirstResponder()
        }else if textField == self.mobile {
            self.days.becomeFirstResponder()
        }else if textField == self.days {
            self.time.becomeFirstResponder()
        }else if textField == self.time {
            self.address.becomeFirstResponder()
        }else if textField == self.address {
            view.endEditing(true)
        }
        return true
    }
    @IBAction func add(_ sender: Any) {
        if name.text != "" && phone.text != "" && mobile.text != "" && address.text != "" && time.text != "" && days.text != ""{
            Spinner = UIViewController.displaySpinner(onView: self.view)
            let clinic = Clinic(id: "", name: name.text!, mobile: mobile.text!, phone: phone.text!, address: address.text!, time: time.text!, days: days.text!, latitude: "0.0", longitude: "0.0", z: "5.0")
            clinicDAO.editUser(user: clinic, clinicId: "-Li7wTM6ASS1J_UQwOV6")
            UIViewController.removeSpinner(spinner: self.Spinner)
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
    @IBAction func clinicAppointment(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "clinicAppointment") as! clinicAppointment
        nextViewController.clinicId = clinicId
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
}
