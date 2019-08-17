//
//  home.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class home: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var logoBtn: UIButton!
    @IBOutlet weak var docName: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var collect: UICollectionView!
    @IBOutlet weak var aboutLb: UITextView!
    var cilnicDAO:ClinicDAOImp!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.shadowView()
        let user_key = randomString()
        print(user_key)
        let defaults = UserDefaults.standard
        let d = "\( defaults.object(forKey: "userKey")!)"
        if d == ""{
        //let defaults = UserDefaults.standard
        defaults.setValue(user_key, forKey: "userKey")
        }

        print(defaults.object(forKey: "userKey")!)
        Spinner = UIViewController.displaySpinner(onView: self.view)
        self.ref = Database.database().reference()
        ref.child("DoctorInfo").child("40yAHV5f07QZc0KhVePwupvxVIz1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let data = snapshot.value as? [String:Any]
            if data == nil {
                return
            }
            for (key,value) in data! {
                if key == "about" {
                    let mobile = value as! String
                    self.aboutLb.text = mobile
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
            UIViewController.removeSpinner(spinner: self.Spinner)
        }
        collect.delegate = self
        collect.dataSource = self
        cilnicDAO = ClinicDAOImp(databaseReference: ref)
        cilnicDAO.allClinics(collec: collect, loader: Spinner)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cilnicDAO.Clinics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClinicCell
        cell.name.text = cilnicDAO.Clinics[indexPath.row].name
        cell.phone.text = cilnicDAO.Clinics[indexPath.row].phone
        cell.mobile.text = cilnicDAO.Clinics[indexPath.row].mobile
        cell.address.text = cilnicDAO.Clinics[indexPath.row].address
        cell.time.text = cilnicDAO.Clinics[indexPath.row].time
        cell.days.text = cilnicDAO.Clinics[indexPath.row].days
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "patientReg") as! patientReg
        
            nextViewController.clinic_id = cilnicDAO.Clinics[indexPath.item].id
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    func randomString() -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< 15 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    @IBAction func LogoBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NurseLogin") as! NurseLogin
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
}
