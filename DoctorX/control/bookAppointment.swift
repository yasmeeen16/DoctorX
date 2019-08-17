
//
//  bookAppointment.swift
//  DoctorX
//
//  Created by Marwa on 5/29/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class bookAppointment: UIViewController {
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var viewbg: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    var Pressed1 = 0
    var Pressed2 = 0
    var Pressed3 = 0
    var Pressed4 = 0
    var Pressed5 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewbg.shadowView()
    }
    @IBAction func next(_ sender: Any) {
    }
    @IBAction func prev(_ sender: Any) {
    }
    @IBAction func Btn1(_ sender: UIButton) {
        if Pressed1 == 0 {
            b1.backgroundColor = UIColor(red: 99 / 255, green: 217 / 255, blue: 215 / 255, alpha: 1.0)
            b1.setTitleColor(UIColor.white, for: .normal)
            Pressed1 = 1
        }else{
            b1.backgroundColor = UIColor.white
            b1.setTitleColor(UIColor.darkGray, for: .normal)
            Pressed1 = 0
        }
        
    }
    @IBAction func Btn2(_ sender: Any) {
        if Pressed2 == 0 {
            b2.backgroundColor = UIColor(red: 99 / 255, green: 217 / 255, blue: 215 / 255, alpha: 1.0)
            b2.setTitleColor(UIColor.white, for: .normal)
            Pressed2 = 1
        }else{
            b2.backgroundColor = UIColor.white
            b2.setTitleColor(UIColor.darkGray, for: .normal)
            Pressed2 = 0
        }
    }
    
    @IBAction func Btn3(_ sender: Any) {
        if Pressed3 == 0 {
            b3.backgroundColor = UIColor(red: 99 / 255, green: 217 / 255, blue: 215 / 255, alpha: 1.0)
            b3.setTitleColor(UIColor.white, for: .normal)
            Pressed3 = 1
        }else{
            b3.backgroundColor = UIColor.white
            b3.setTitleColor(UIColor.darkGray, for: .normal)
            Pressed3 = 0
        }
    }
    @IBAction func Btn4(_ sender: Any) {
        if Pressed4 == 0 {
            b4.backgroundColor = UIColor(red: 99 / 255, green: 217 / 255, blue: 215 / 255, alpha: 1.0)
            b4.setTitleColor(UIColor.white, for: .normal)
            Pressed4 = 1
        }else{
            b4.backgroundColor = UIColor.white
            b4.setTitleColor(UIColor.darkGray, for: .normal)
            Pressed4 = 0
        }
    }
    @IBAction func Btn5(_ sender: Any) {
        if Pressed5 == 0 {
            b5.backgroundColor = UIColor(red: 99 / 255, green: 217 / 255, blue: 215 / 255, alpha: 1.0)
            b5.setTitleColor(UIColor.white, for: .normal)
            Pressed5 = 1
        }else{
            b5.backgroundColor = UIColor.white
            b5.setTitleColor(UIColor.darkGray, for: .normal)
            Pressed5 = 0
        }
    }
}
