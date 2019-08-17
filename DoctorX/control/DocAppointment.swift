
//
//  DocAppointment.swift
//  DoctorX
//
//  Created by Marwa on 6/9/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class DocAppointment: UIViewController  ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! docAppointmentCell
        return cell
    }
}
