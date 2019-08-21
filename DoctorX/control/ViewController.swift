//
//  ViewController.swift
//  DoctorX
//
//  Created by Marwa on 5/28/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit
import VACalendar
import Firebase
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,VACalendarViewDelegate{
    @IBOutlet weak var heightView: NSLayoutConstraint!
    @IBOutlet weak var viewbg: UIView!
    @IBOutlet weak var collect: UICollectionView!
    @IBOutlet weak var collectH: NSLayoutConstraint!
    @IBOutlet weak var viewbg2: UIView!
    var reserve :PatiantData!
    var reserveDate : String?
    var reserveTime : String?
    var reservationDAo :ReservationDAO!
    var ref: DatabaseReference! = nil
    var calendarView: VACalendarView!
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    var bookDAO : ApointmentDAOImp!
    var Spinner :UIView!
    var appoints = ["",""]
    var appointCount = 0
    var time:String!
    var dayWeek = ""
    var pickerData = [["day1","Sat"],["day2","Sun"],["day3","Mon"],["day4","Tue"],["day5","Wed"],["day6","Thur"],["day7","Fri"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        viewbg.shadowView()
        viewbg2.shadowView()
        collect.delegate = self
        collect.dataSource = self
     
        self.ref = Database.database().reference()
        reservationDAo = ReservationDAO(databaseReference: ref)
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .single
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
       // calendarView.changeViewType()
        calendarView.setSupplementaries([
            (Date().addingTimeInterval(-(60 * 60 * 70)), [VADaySupplementary.bottomDots([.red, .magenta])]),
            (Date().addingTimeInterval((60 * 60 * 110)), [VADaySupplementary.bottomDots([.red])]),
            (Date().addingTimeInterval((60 * 60 * 370)), [VADaySupplementary.bottomDots([.blue, .darkGray])]),
            (Date().addingTimeInterval((60 * 60 * 430)), [VADaySupplementary.bottomDots([.orange, .purple, .cyan])])
            ])
        self.collect.isUserInteractionEnabled = true
        viewbg.addSubview(calendarView)
        ///
        Spinner = UIViewController.displaySpinner(onView: self.view)
        ref = Database.database().reference()
        bookDAO = ApointmentDAOImp(databaseReference: ref, clinicId: "-Li8I-QDhoqFZKIjhdQm")
       let x = Calendar.current.component(.weekday, from: Date())
        if x == 0{
            dayWeek = pickerData[0][0]
        }else if x == 1{
            dayWeek = pickerData[1][0]
        }else if x == 2{
            dayWeek = pickerData[2][0]
        }else if x == 3{
            dayWeek = pickerData[3][0]
        }else if x == 4{
            dayWeek = pickerData[4][0]
        }else if x == 5{
            dayWeek = pickerData[5][0]
        }else if x == 6{
            dayWeek = pickerData[6][0]
        }else{
            dayWeek = pickerData[0][0]
        }

        print(dayWeek)
        bookDAO.allBooking(collec: collect
            ,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: dayWeek)
    }
    func getTodayWeekDay()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: Date())
        return weekDay
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: weekDaysView.frame.width + 55,
                height: viewbg.frame.height - 25
            )
            calendarView.setup()
        }
        heightView.constant = (self.collect.collectionViewLayout.collectionViewContentSize.height) + 55
         //self.collectH.constant = self.collect.collectionViewLayout.collectionViewContentSize.height
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDAO.appointCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! timeCell
        cell.time.text = bookDAO.appoints[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(bookDAO.appoints[indexPath.row])
            let cell = collectionView.cellForItem(at: indexPath) as! timeCell
            cell.time.textColor = UIColor.black
        cell.layer.backgroundColor = UIColor.white.cgColor
//            cell.layer.borderWidth = 1.0
//            cell.layer.borderColor = UIColor.gray.cgColor
        print("yyy")
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as! timeCell
            cell.time.textColor = UIColor.white
        cell.layer.backgroundColor = self.hexStringToUIColor(hex: "#5AC6DC").cgColor
            collect.allowsMultipleSelection = false
        print("\(cell.time.text! )")
        self.reserve?.reserveTime = "\(cell.time.text!)"
        // save
        reservationDAo.savepatiantData(patiant: reserve)
        if self.reserve.nurseId == ""{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentsReservation") as! AppointmentsReservation
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NurseToDayReservation") as! NurseToDayReservation
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            
//            let appereance = VAMonthHeaderViewAppearance(
//                previousButtonImage: #imageLiteral(resourceName: "previous"),
//                nextButtonImage: #imageLiteral(resourceName: "next"),
//                dateFormatter: dateFormatter
//            )
            let apperance = VAMonthHeaderViewAppearance()
            monthHeaderView.delegate = self
            monthHeaderView.appearance = apperance
            
        }
    }
    static public let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func pre(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func next(_ sender: Any) {
       
        reservationDAo.savepatiantData(patiant: reserve)
        if self.reserve.nurseId == ""{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentsReservation") as! AppointmentsReservation
        self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NurseToDayReservation") as! NurseToDayReservation
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    func selectedDates(_ dates: [Date]) {
        calendarView.startDate = dates.last ?? Date()
        print(("\(calendarView.startDate.getDayMonthYearHourMim().year) -\(calendarView.startDate.getDayMonthYearHourMim().months) -\(calendarView.startDate.getDayMonthYearHourMim().day)"))
        self.reserve?.reserveDate = "\(calendarView.startDate.getDayMonthYearHourMim().year) -\(calendarView.startDate.getDayMonthYearHourMim().months) -\(calendarView.startDate.getDayMonthYearHourMim().day)"
        self.reserve.day = "\(calendarView.startDate.getDayMonthYearHourMim().day)"
        self.reserve.month = "\(calendarView.startDate.getDayMonthYearHourMim().months)"
        self.reserve.year = "\(calendarView.startDate.getDayMonthYearHourMim().year)"
        ///
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        let updatedAtStr3 = "\(calendarView.startDate)"
        let updatedAt3 = dateFormatter3.date(from: updatedAtStr3) // "Jun 5, 2016, 4:56 PM"
        if updatedAt3 == nil {
            print("nil date")
        }else{
            Spinner = UIViewController.displaySpinner(onView: self.view)
            print(updatedAt3!)
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "EEE"
            let day = "\(formatter3.string(from: updatedAt3 as! Date))"
            print("\(formatter3.string(from: updatedAt3 as! Date))")
            if day == "Sat"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day1")
            }else if day == "Sun"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day2")
            }else if day == "Mon"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day3")
            }else if day == "Tue"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day4")
            }else if day == "Wed"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day5")
            }else if day == "Thu"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day6")
            }else if day == "Fri"{
                bookDAO.allBooking(collec: collect,loader: Spinner, clinicId: "-Li8I-QDhoqFZKIjhdQm", day: "day7")
            }
        }
    }
}
extension ViewController: VAMonthHeaderViewDelegate {
    
    func didTapNextMonth() {
        calendarView.nextMonth()
    }
    
    func didTapPreviousMonth() {
        calendarView.previousMonth()
    }
    
}

extension ViewController: VAMonthViewAppearanceDelegate {
    
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
    
}
extension ViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
    
}
extension NSDate {
    
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self as Date)
    }
}
//extension ViewController: VACalendarViewDelegate {
//    func selectedDates(_ dates: [Date]) {
//        calendarView.startDate = dates.last ?? Date()
//
//        print(dates)
//        ///
////        calendarView.startDate
//        let dateFormatter3 = DateFormatter()
//        dateFormatter3.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
//        let updatedAtStr3 = "2019-06-23 00:00:00 +0000"
//        let updatedAt3 = dateFormatter3.date(from: updatedAtStr3) // "Jun 5, 2016, 4:56 PM"
//        if updatedAt3 == nil {
//            print("nil")
//        }else{
//            print(updatedAt3)
//            let formatter3 = DateFormatter()
//            formatter3.dateFormat = "EEEE"
//            print("\(formatter3.string(from: updatedAt3 as! Date))")
//        }
//    }
//
//}
