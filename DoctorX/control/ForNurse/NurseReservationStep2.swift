//
//  NurseReservationStep2.swift
//  DoctorX
//
//  Created by yasmeen on 7/15/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class NurseReservationStep2: UIViewController , UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reservationtable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    

    var reservationTypeDAO:ReservationTypeDAO!
    var ref: DatabaseReference! = nil
    var Spinner :UIView!
    @IBOutlet weak var reservationtable: UITableView!
    var reserveObject :PatiantData?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ReservationType(_ sender: Any) {
        self.reserveObject?.reserveType = String((sender as AnyObject).tag)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        nextViewController.reserve = self.reserveObject
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    
    }

}
