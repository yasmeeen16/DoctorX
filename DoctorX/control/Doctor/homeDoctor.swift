//
//  homeDoctor.swift
//  DoctorX
//
//  Created by yasmeen on 8/17/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class homeDoctor: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var cilnicDAO:ClinicDAOImp!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        Spinner = UIViewController.displaySpinner(onView: self.view)
        self.ref = Database.database().reference()
        cilnicDAO = ClinicDAOImp(databaseReference: ref)
        cilnicDAO.allClinics(table: table, loader: Spinner)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cilnicDAO.Clinics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! doctorHomecell
        cell.clinicName.text = cilnicDAO.Clinics[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "clinicIncomeDoctor") as! clinicIncomeDoctor
        nextViewController.clinicId = cilnicDAO.Clinics[indexPath.row].id
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }


}

