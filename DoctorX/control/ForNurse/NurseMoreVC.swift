//
//  NurseMoreVC.swift
//  DoctorX
//
//  Created by yasmeen on 7/15/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class NurseMoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LogOutAction(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "NurseId")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NurseLogin") as! NurseLogin
        self.present(secondViewController, animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
