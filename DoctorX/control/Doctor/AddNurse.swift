//
//  AddNurse.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
class AddNurse: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var picker = UIPickerView()
    var Clinics = [Clinic]()
    var selectedClinicid = ""
    var selectedclinicname = ""
    @IBOutlet weak var clinicNameTextF: UITextField!
    @IBOutlet weak var nurseName: UITextField!
    @IBOutlet weak var nurseemail: UITextField!
    @IBOutlet weak var nursepassword: UITextField!
    @IBOutlet weak var nursephone: UITextField!
    //@IBOutlet weak var clinicsname: UIPickerView!
    var nurse:Nurse!
    var ref: DatabaseReference!
    var nursesDB: NursesDB!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        clinicNameTextF.inputView = picker
        ref = Database.database().reference()
        ref.child("Clinics").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                
                let ad = Clinic.mapToUser(user: value as! [String : Any])
                ad.id = key
                self.Clinics.append(ad)
                //self.clinicsname.reloadAllComponents()
                self.picker.reloadAllComponents()
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
        self.clinicNameTextF.text = Clinics[row].name
    }
    
    @IBAction func AddNurse(_ sender: Any) {
        var Existed = false
        if isEmailValid(nurseemail.text!)&&DataFiled(nurseName.text!)&&DataFiled(nursepassword.text!)&&nursephone.text!.isValidContact{
        ref.child("Nurses").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                let id = dict["id"]
                if self.nurseemail.text == dict["Email"]!{
                    print("existed email")
                    self.showToast(message: "Email existed")
                    Existed = true
                    return
                }
            }
            
            if Existed == false{
                self.nurse  = Nurse(id: "", name: self.nurseName.text!, email: self.nurseemail.text!, password: self.nursepassword.text!, clinicId: self.selectedClinicid, phone: self.nursephone.text!, clinicName: self.selectedclinicname, type: "nurse")

               
                
                let DB = Database.database().reference().child("Nurses")
                let userDictionary : NSDictionary = ["id":" " ,"Name" :self.nurseName.text!, "phone" : self.nursephone.text!,"Email":self.nurseemail.text!, "clinicId":self.selectedClinicid,"clinicname": self.selectedclinicname,"password":self.nursepassword.text!,"active":"1","type" : "nurse"]
                let DBref =  DB.childByAutoId()
                let id = DBref.key
                
                DBref.setValue(userDictionary) {
                    (error, ref) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        DBref.child("id").setValue(id)
                        self.showToast(message: "Saved successfully")
                        print("Message saved successfully!")
                    }
                }
           
            }
        })
        }else{
            showToast(message: "please fill all data")
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
    
    
}
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[0-9]\\d{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}
