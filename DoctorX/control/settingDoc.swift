//
//  settingDoc.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class settingDoc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func editNurse(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EditDeleteNurse") as! EditDeleteNurse
        self.navigationController?.pushViewController(nextViewController, animated:
            true)
    }
}
