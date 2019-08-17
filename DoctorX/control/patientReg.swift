//
//  patientReg.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class patientReg: UIViewController ,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{

    
    @IBOutlet weak var pickgenderOutlet: UIPickerView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var viewbg: UIView!
    let gender = ["male" , "female"]
    var selectedGender = "male"
    var clinic_id = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        name.shadowView()
        phone.shadowView()
        viewbg.shadowView()
        hideKeyboardWhenTappedAround()
        name.delegate = self
        phone.delegate = self
        print(clinic_id)

        
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
        if textField == self.name {
            self.phone.becomeFirstResponder()
        }else if textField == self.phone {
            view.endEditing(true)
        }
        return true
    }
    
    @IBAction func next(_ sender: Any) {

        let name = self.name.text
        let age = self.age.text
        let phone = self.phone.text
        let address = self.address.text
        let defaults = UserDefaults.standard
        let reserveObj = PatiantData(id: "", name: name!, address: address!, age: age!, gender: self.selectedGender, clinicId: self.clinic_id, phone: phone!, lat: "", long: "", price: "", status: "", reserveType: "", reserveDate: "", reserveTime: "", userKey: "\(defaults.object(forKey: "userKey")!)", nurseId: "", day: "", month: "", year: "", confirmed: "0", entered: "0")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentType") as! AppointmentType
        nextViewController.reserveObject = reserveObj
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedGender = gender[row]
    }
    
}
