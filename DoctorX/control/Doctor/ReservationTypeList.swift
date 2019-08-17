//
//  ReservationTypeList.swift
//  DoctorX
//
//  Created by yasmeen on 7/22/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class ReservationTypeList: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var reservationTypeDAO:ReservationTypeDAO!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    @IBOutlet weak var reservationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reservationTable.delegate = self
        reservationTable.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.ref = Database.database().reference()
        reservationTypeDAO = ReservationTypeDAO(databaseReference: ref)
        Spinner = UIViewController.displaySpinner(onView: self.view)
        reservationTypeDAO.allTypes(table: reservationTable, loader: Spinner)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationTypeDAO.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reservationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReservationTypeCell
        cell.name.text = reservationTypeDAO.types[indexPath.row].name
        cell.price.text = reservationTypeDAO.types[indexPath.row].price
        cell.DeactivateBtn.accessibilityIdentifier = reservationTypeDAO.types[indexPath.row].id
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    @IBAction func ActivationBtn(_ sender: Any) {
        let recordId = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "editClinic") as! editClinic
//        nextViewController.clinicId = cilnicDAO.Clinics[indexPath.row].id
//        self.navigationController?.pushViewController(nextViewController, animated:
//            true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Editbtn(_ sender: Any) {
        let NextVC = storyboard?.instantiateViewController(withIdentifier: "EditReservationType") as! EditReservationType
        NextVC.typeId = "\((sender as AnyObject).accessibilityIdentifier! ?? " ")"
        self.navigationController?.pushViewController(NextVC, animated: true)
    }
    
}
