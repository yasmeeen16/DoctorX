//
//  notifications.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class notifications: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! notificationCell
        return cell
    }
    

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        //
        //create shadow
        view.layer.cornerRadius = 5.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.clear.cgColor
        table.layer.shadowColor = UIColor.gray.cgColor
        table.layer.shadowOffset = CGSize(width: 0,height: 1.0)
        table.layer.shadowRadius = 3.0
        table.layer.shadowOpacity = 0.5
        table.layer.masksToBounds = false
    }
}
