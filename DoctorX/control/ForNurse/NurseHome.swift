//
//  NurseHome.swift
//  DoctorX
//
//  Created by yasmeen on 7/7/19.
//  Copyright © 2019 Marwa. All rights reserved.
//

import UIKit

class NurseHome: UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource {


    @IBOutlet weak var textfield: UITextView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var HomecollectionView: UICollectionView!
    //var Spinner :UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.shadowView()
        print("+++++++++++++++")
        let defaults = UserDefaults.standard
        print(defaults.object(forKey: "NurseId")!)
        //Spinner = UIViewController.displaySpinner(onView: self.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = HomecollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
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
