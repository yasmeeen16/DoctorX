//
//  editNurseData.swift
//  DoctorX
//
//  Created by yasmeen on 7/13/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class editNurseData: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var Clinics = [Clinic]()
    var selectedClinicid = ""
    var selectedclinicname = ""
    var nurseId = ""
    var name = ""
    var email = ""
    var password = " "
    var phone = " "
    @IBOutlet weak var nurseName: UITextField!
    @IBOutlet weak var nurseemail: UITextField!
    @IBOutlet weak var nursepassword: UITextField!
    @IBOutlet weak var nursephone: UITextField!
    @IBOutlet weak var clinicsname: UIPickerView!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.nurseId)
        ref = Database.database().reference()
    ref.child("Nurses").child(self.nurseId).observeSingleEvent(of: .value, with:
            { (snapshot) in
                let data = snapshot.value as? [String:Any]
                for (key,value) in data! {
                    if key == "Name" {
                        self.nurseName.text = value as? String
                    }
                    if key == "Email"{
                        self.nurseemail.text = value as? String
                    }
                    if key == "password"{
                        self.nursepassword.text = value as? String
                    }
                    if key == "phone"{
                        self.nursephone.text = value as? String
                    }
                    
                }
            })
        ref.child("Clinics").observeSingleEvent(of: .value, with:
            { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                
                let ad = Clinic.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Clinics.append(ad)
                print(self.Clinics.count)
                self.clinicsname.reloadAllComponents()
            }
            if self.Clinics.count == 0 {
                print("no ads")
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.Clinics.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Clinics[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedClinicid = Clinics[row].id
        self.selectedclinicname = Clinics[row].name
    }
    
    @IBAction func editNurseData(_ sender: Any) {
        ref.child("Nurses").child(self.nurseId).updateChildValues(["Name":self.nurseName.text!,"Email":self.nurseemail.text! ,"password":self.nursepassword.text!,"phone":self.nursephone.text! ,"clinicname":self.selectedclinicname,"clinicId":self.selectedClinicid])
    }
    

}
