//
//  Clinics.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class Clinics: UIViewController ,UITableViewDelegate, UITableViewDataSource{
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
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clinicsCell
        cell.clinicName.text = cilnicDAO.Clinics[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "editClinic") as! editClinic
        nextViewController.clinicId = cilnicDAO.Clinics[indexPath.row].id
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    //delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "delete"){ (action , view , completion) in
            let clinicId = self.cilnicDAO.Clinics[indexPath.row].id
            self.cilnicDAO.Clinics.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            //delete product
            self.ref.child("Clinics").child(clinicId ?? "").observe(.value, with: { snapshot in
                if snapshot.exists() {
                    snapshot.ref.removeValue()
                    print(snapshot)
                } else {
                    print("snapshot doesn't exist")
                }
            })
            completion(true)
        }
        //action.image =
        action.backgroundColor = .red
        return action
    }
    @IBAction func add(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddClinic") as! AddClinic
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
}
