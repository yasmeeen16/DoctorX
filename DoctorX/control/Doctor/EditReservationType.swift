//
//  EditReservationType.swift
//  DoctorX
//
//  Created by yasmeen on 7/22/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class EditReservationType: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let ActiveOrDeact = ["Active" , "Deactive"]
    var selectedType = ""
    var typeId = ""
    @IBOutlet weak var typename: UITextField!
    @IBOutlet weak var typePrice: UITextField!
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var ActorDeactTextF: UITextField!
    var picker = UIPickerView()

    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        self.ActorDeactTextF.inputView = picker
        ref = Database.database().reference()
        ref.child("Reserve_Type").child(self.typeId).observeSingleEvent(of: .value, with:
            { (snapshot) in
                let data = snapshot.value as? [String:Any]
                for (key,value) in data! {
                    if key == "name" {
                        self.typename.text = value as? String
                    }
                    if key == "price"{
                        self.typePrice.text = value as? String
                    }
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
        return self.ActiveOrDeact.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ActiveOrDeact[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if ActiveOrDeact[row] == "Active"{
            self.selectedType = "1"
            self.ActorDeactTextF.text = "active"
         }else if ActiveOrDeact[row] == "Deactive"{
            self.selectedType = "0"
            self.ActorDeactTextF.text = "Deactive"
        }
        
    }
    
    @IBAction func edittype(_ sender: Any) {
        ref.child("Reserve_Type").child(self.typeId).updateChildValues(["name":self.typename.text!,"price":self.typePrice.text! ,"isActive":self.selectedType])
      
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
}

