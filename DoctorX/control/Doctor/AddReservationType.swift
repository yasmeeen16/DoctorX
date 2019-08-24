//
//  AddReservationType.swift
//  DoctorX
//
//  Created by yasmeen on 7/21/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class AddReservationType: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource {
    var picker = UIPickerView()
    @IBOutlet weak var ActiveOrDactTextF: UITextField!
    @IBOutlet weak var ReservationName: UITextField!
    @IBOutlet weak var ReservationPrice: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    let ActiveOrDeact = ["Active" , "Deactive"]
    var selected = "1"
    //var clinic_id = " "
    var reservationTypeDAO : ReservationTypeDAO!
    var ref: DatabaseReference! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        self.ActiveOrDactTextF.inputView = picker
        self.ref = Database.database().reference()
        reservationTypeDAO = ReservationTypeDAO(databaseReference: ref)
        //pickerView.delegate = self
        //pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Add(_ sender: Any) {
        let name = self.ReservationName.text
        let price = self.ReservationPrice.text
        var ActOrDeact = "0"
        if self.selected == "Active"{
             ActOrDeact = "1"
            
        }else if self.selected == "Deactive"{
             ActOrDeact = "0"
            
        }
        
        let type = ReservationTypes(id: "", name: name!, price: price!, isActive: ActOrDeact)
        reservationTypeDAO.saveType(type: type)
        //let defaults = UserDefaults.standard
        
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentType") as! AppointmentType
        //nextViewController.reserveObject = reserveObj
        //self.navigationController?.pushViewController(nextViewController, animated:true)
        
    }
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ActiveOrDeact.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ActiveOrDeact[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selected = ActiveOrDeact[row]
        self.ActiveOrDactTextF.text = ActiveOrDeact[row]
    }

    
}
