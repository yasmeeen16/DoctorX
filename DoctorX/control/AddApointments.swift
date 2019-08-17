
//
//  AddApointments.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class AddApointments: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
   
    

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tool: UIToolbar!
    @IBOutlet weak var dayLb: UITextField!
    @IBOutlet weak var fromMLb: UITextField!
    @IBOutlet weak var toMLb: UITextField!
    @IBOutlet weak var fromELb: UITextField!
    @IBOutlet weak var toELb: UITextField!
    var pickerData = [["day1","Sat"],["day2","Sun"],["day3","Mon"],["day4","Tue"],["day5","Wed"],["day6","Thur"],["day7","Fri"]]
    var id = ""
    var fromM = ""
    var toM = ""
    var fromE = ""
    var toE = ""
    var flag = 0
    var Spinner :UIView!
    var appointmentDAO : ApointmentDAOImp!
     var ref: DatabaseReference! = nil
    var clinicId = ""
     var ApointmentDAO:ApointmentDAOImp!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        picker.delegate = self
        picker.dataSource = self
        datePicker.datePickerMode = .time
        if id == "day1"{
            dayLb.text = pickerData[0][1]
        }else if id == "day2"{
            dayLb.text = pickerData[1][1]
        }else if id == "day3"{
            dayLb.text = pickerData[2][1]
        }else if id == "day4"{
            dayLb.text = pickerData[3][1]
        }else if id == "day5"{
            dayLb.text = pickerData[4][1]
        }else if id == "day6"{
            dayLb.text = pickerData[5][1]
        }else if id == "day7"{
            dayLb.text = pickerData[6][1]
        }else{
            dayLb.text = pickerData[0][1]
        }
        
        Spinner = UIViewController.displaySpinner(onView: self.view)
        ref.child("Clinic_Appointment").child(clinicId).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            self.ref.child("Clinic_Appointment").child(self.clinicId).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(self.id){
                    print("true clinic exist")
                }else{
                    ///loader end
                    UIViewController.removeSpinner(spinner: self.Spinner)
                    print("false clinic doesn't exist")
                }
            }) { (error) in
                    print(error.localizedDescription)
                UIViewController.removeSpinner(spinner: self.Spinner)
            }
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                if key == "evening" {
                    let address = value as? [String:Any]
                    self.fromELb.text = (address?["fromText"] as? String) ?? ""
                    self.toELb.text = (address?["toText"] as? String) ?? ""
                    self.fromE = (address?["fromH"] as? String) ?? ""
                    self.toE = (address?["toH"] as? String) ?? ""
                }
                if key == "morning" {
                    let address = value as? [String:Any]
                    self.fromMLb.text = (address?["fromText"] as? String) ?? ""
                    self.toMLb.text = (address?["toText"] as? String) ?? ""
                    self.fromM = (address?["fromH"] as? String) ?? ""
                    self.toM = (address?["toH"] as? String) ?? ""
                }
                UIViewController.removeSpinner(spinner: self.Spinner)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        id = pickerData[row][0]
        dayLb.text = pickerData[row][1]
        picker.isHidden = true
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row][1]
    }
    @IBAction func done(_ sender: Any) {
        if flag == 1 {
            fromMLb.text = timee
        }else if flag == 2 {
            toMLb.text = timee
        }else if flag == 3 {
            fromELb.text = timee
        }else if flag == 4 {
           toELb.text = timee
        }
        datePicker.isHidden = true
        tool.isHidden = true
    }
    @IBAction func days(_ sender: Any) {
        if picker.isHidden == true{
            picker.isHidden = false
        }else{
            picker.isHidden = true
        }
    }
    @IBAction func fromM(_ sender: Any) {
        flag = 1
        if datePicker.isHidden == true {
            datePicker.isHidden = false
            tool.isHidden = false
        }else{
            datePicker.isHidden = true
            tool.isHidden = true
        }
    }
    @IBAction func toM(_ sender: Any) {
        flag = 2
        if datePicker.isHidden == true {
            datePicker.isHidden = false
            tool.isHidden = false
        }else{
            datePicker.isHidden = true
            tool.isHidden = true
        }
    }
    @IBAction func fromE(_ sender: Any) {
        flag = 3
        if datePicker.isHidden == true {
            datePicker.isHidden = false
            tool.isHidden = false
        }else{
            datePicker.isHidden = true
            tool.isHidden = true
        }
    }
    @IBAction func toE(_ sender: Any) {
        flag = 4
        if datePicker.isHidden == true {
            datePicker.isHidden = false
            tool.isHidden = false
        }else{
            datePicker.isHidden = true
            tool.isHidden = true
        }
    }
    var timee = ""
    @IBAction func Changed(_ sender: UIDatePicker) {
        let myDateFormatter: DateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "HH:mm a"
        // get the date string applied date format
        let mySelectedDate = myDateFormatter.string(from: sender.date)
        print(mySelectedDate)
       timee = "\(sender.date.getDayMonthYearHourMim().hour):\(sender.date.getDayMonthYearHourMim().min)"
        if flag == 1 {
            fromM = mySelectedDate
        }else if flag == 2 {
            toM = mySelectedDate
        }else if flag == 3 {
            fromE = mySelectedDate
        }else if flag == 4 {
            toE = mySelectedDate
        }
        
    }
    @IBAction func save(_ sender: Any) {
        if fromELb.text != "" && fromMLb.text != "" && toELb.text != "" && toMLb.text != ""{
            let shiftE = shift(fromH:fromELb.text! , fromText: fromE, toH: toELb.text!, toText: toE)
            let shiftM = shift(fromH: fromMLb.text!, fromText: fromM, toH: toMLb.text!, toText: toM)
            let appoint = Appointment(id: id, clinicId: clinicId, evening: shiftE.userMapper(), morning: shiftM.userMapper())
            appointmentDAO = ApointmentDAOImp(databaseReference: ref, clinicId: clinicId)
            appointmentDAO.saveUser(user: appoint, day: id)
        }
    }
}
