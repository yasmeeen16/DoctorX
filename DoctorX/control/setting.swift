//
//  setting.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import Firebase
class setting: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func changePassword(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "changePass") as! changePass
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        UserDefaults.standard.set("", forKey: "userId")
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
}
