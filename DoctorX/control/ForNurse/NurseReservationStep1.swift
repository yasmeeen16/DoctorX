//
//  NurseReservationStep1.swift
//  DoctorX
//
//  Created by yasmeen on 7/15/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class NurseReservationStep1: UIViewController ,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBOutlet weak var genderTextF: UITextField!
    var picker = UIPickerView()
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
        picker.delegate = self
        picker.dataSource = self
        genderTextF.inputView = picker
        name.shadowView()
        phone.shadowView()
        viewbg.shadowView()
        hideKeyboardWhenTappedAround()
        name.delegate = self
        phone.delegate = self
        print(clinic_id)
        
        
 
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
        if !DataFiled(self.name.text!){
            showToast(message: "ادخل الاسم")
        }
        else if !DataFiled(self.phone.text!){
            showToast(message: "ادخل رقم التليفون")
        }
        else if !self.phone.text!.isValidContact{
            showToast(message: "رقم الهاتف غير صالح")
        }
        else if !DataFiled(self.age.text!){
            showToast(message: "ادخل العمر")
        }
        else if !DataFiled(self.address.text!){
            showToast(message: "ادخل العنوان")
        }else{
            
        let defaults = UserDefaults.standard
        print(defaults.object(forKey: "NurseId")!)
        let name = self.name.text
        let age = self.age.text
        let phone = self.phone.text
        let address = self.address.text
        let nurseId = "\(defaults.object(forKey: "NurseId")!)"
        let clinicId = "\(defaults.object(forKey: "clinicId")!)"
        let reserveObj = PatiantData(id: "", name: name!, address: address!, age: age!, gender: self.selectedGender, clinicId:clinicId, phone: phone!, lat: "", long: "", price: "", status: "", reserveType: "", reserveDate: "", reserveTime: "", userKey: "", nurseId: nurseId, day: "", month: "", year: "", confirmed: "1", entered: "0")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentType") as! AppointmentType
        nextViewController.reserveObject = reserveObj
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
        }
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
        self.genderTextF.text = gender[row]
    }
    
    //validation
    //showing tost
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
