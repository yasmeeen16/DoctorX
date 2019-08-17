//
//  clinicAppointment.swift
//  DoctorX
//
//  Created by Marwa on 6/25/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class clinicAppointment: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    var ApointmentDAO:ApointmentDAOImp!
    @IBOutlet weak var table: UITableView!
    var clinicId = ""
    var pickerData = [["day1","Sat"],["day2","Sun"],["day3","Mon"],["day4","Tue"],["day5","Wed"],["day6","Thur"],["day7","Fri"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        Spinner = UIViewController.displaySpinner(onView: self.view)
        self.ref = Database.database().reference()
        ApointmentDAO = ApointmentDAOImp(databaseReference: ref, clinicId: clinicId)
        ApointmentDAO.allAppointment(table: table, loader: Spinner)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ApointmentDAO.AppointmentsSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentClinicCell
        let DayName = ApointmentDAO.AppointmentsSorted[indexPath.row].id
        if DayName == "day1"{
            cell.day.text = pickerData[0][1]
        }else if DayName == "day2"{
            cell.day.text = pickerData[1][1]
        }else if DayName == "day3"{
            cell.day.text = pickerData[2][1]
        }else if DayName == "day4"{
            cell.day.text = pickerData[3][1]
        }else if DayName == "day5"{
            cell.day.text = pickerData[4][1]
        }else if DayName == "day6"{
            cell.day.text = pickerData[5][1]
        }else if DayName == "day7"{
            cell.day.text = pickerData[6][1]
        }
        cell.from.text = ApointmentDAO.AppointmentsSorted[indexPath.row].morning["fromText"] as? String
        cell.to.text = ApointmentDAO.AppointmentsSorted[indexPath.row].morning["toText"] as? String
        cell.fromE.text = ApointmentDAO.AppointmentsSorted[indexPath.row].evening["fromText"] as? String
        cell.toE.text = ApointmentDAO.AppointmentsSorted[indexPath.row].evening["toText"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddApointments") as! AddApointments
        nextViewController.clinicId = clinicId
        nextViewController.id = ApointmentDAO.AppointmentsSorted[indexPath.row].id
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
            let clinicId = self.ApointmentDAO.AppointmentsSorted[indexPath.row].clinicId
            let id = self.ApointmentDAO.AppointmentsSorted[indexPath.row].id
            self.ApointmentDAO.AppointmentsSorted.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            //delete product
            self.ref.child("Clinic_Appointment").child(clinicId ?? "").child(id ?? "").observe(.value, with: { snapshot in
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
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddApointments") as! AddApointments
        nextViewController.clinicId = clinicId
        nextViewController.id = "day1"
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
}
