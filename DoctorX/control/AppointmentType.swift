//
//  AppointmentType.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class AppointmentType: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var reservationTypeDAO:ReservationTypeDAO!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    @IBOutlet weak var typestabel: UITableView!

    var reserveObject :PatiantData? 
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.ref = Database.database().reference()
        reservationTypeDAO = ReservationTypeDAO(databaseReference: ref)
        Spinner = UIViewController.displaySpinner(onView: self.view)
        reservationTypeDAO.allTypes(table: typestabel, loader: Spinner)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservationTypeDAO.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typestabel.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PatiantReservationCell
        cell.reservationType.text =  reservationTypeDAO.types[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.reserveObject?.reserveType = reservationTypeDAO.types[indexPath.row].id
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        nextViewController.reserve = self.reserveObject
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    @IBAction func next(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    @IBAction func ChoseTypeOfReservation(_ sender: Any) {
        self.reserveObject?.reserveType = String((sender as AnyObject).tag)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        nextViewController.reserve = self.reserveObject
    self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    
    
}
