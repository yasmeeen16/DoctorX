//
//  NurseList.swift
//  DoctorX
//
//  Created by yasmeen on 7/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NurseList: UIViewController , UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableNurses: UITableView!
    var ref : DatabaseReference!
    var nurses = [Nurse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNurses.delegate = self
        tableNurses.dataSource = self
        ref = Database.database().reference()
        ref.child("Nurses").queryOrdered(byChild: "active").queryEqual(toValue: "1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            
            for child in snapshot.children {
                print(child)
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: String]
                let Email = dict["Email"]!
                let Name = dict["Name"]!
                let clinicId = dict["clinicId"]!
                let clinicname = dict["clinicname"]!
                let id = dict["id"]!
                let phone = dict["phone"]!
                let password = dict["password"]!
                let type = dict["type"]!
                let mrs = Nurse(id: id, name: Name, email: Email, password: password, clinicId: clinicId, phone: phone, clinicName: clinicname, type: type)
                
               self.nurses.append(mrs)
                
            }
            self.tableNurses.reloadData()
          
        })
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nurses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableNurses.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditDeleteCell
        cell.clinicName.text = self.nurses[indexPath.row].clinicName
        cell.nurseName.text = self.nurses[indexPath.row].name
        cell.nursePhone.text = self.nurses[indexPath.row].phone
        cell.deleteBtn.accessibilityIdentifier = self.nurses[indexPath.row].id
        cell.editBtn.accessibilityIdentifier = self.nurses[indexPath.row].id
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
        
    }
    
    @IBAction func deleteNurse(_ sender: Any) {
        let recordId = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        let dialogMessage = UIAlertController(title: "Confirm", message: "you sure you want to delete Nurse?", preferredStyle: .alert)
    
    // Create OK button with action andler
    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        print("Ok button tapped")
        self.deleteRecord(id: recordId)
    })
    
    // Create Cancel button with action handlder
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        print("Cancel button tapped")
    }
    
    //Add OK and Cancel button to dialog message
    dialogMessage.addAction(ok)
    dialogMessage.addAction(cancel)
    
    // Present dialog message to user
    self.present(dialogMessage, animated: true, completion: nil)
    }
    func deleteRecord(id : String)
    {
             
        print("Deleting text now")
        //self.myTextField.text = ""
        print(id)
        self.ref.child("Nurses").child(id).updateChildValues(["active":"0"])
    }
    
    @IBAction func editBtn(_ sender: Any) {
        
        let NextVC = storyboard?.instantiateViewController(withIdentifier: "editNurseData") as! editNurseData
        NextVC.nurseId = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        self.navigationController?.pushViewController(NextVC, animated: true)
        
    }
    
}
