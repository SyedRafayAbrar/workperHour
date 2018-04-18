//
//  JobsViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 24/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseDatabase

class JobsViewController: UIViewController {

    @IBOutlet var jobFor: UILabel!
    @IBOutlet var budgetAmount: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var jobNAme: UILabel!
    @IBOutlet var bid: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
stylingoutlets()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        jobNAme.text! = list[newindex]["JobTitle"]! as! String
        jobFor.text! = list[newindex]["jobfor"]! as! String
        budgetAmount.text! = "$ \(list[newindex]["budget"]! as! String) "
        descriptionLabel.text! = list[newindex]["Desc"]! as! String
        timeLabel.text! = list[newindex]["time"]! as! String
        
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func stylingoutlets(){
        scrollView.contentSize.height = 1000
        descriptionLabel.layer.borderWidth = 0.7
        jobFor.layer.borderWidth = 0.7
        jobFor.layer.cornerRadius = 8
        jobFor.layer.masksToBounds = true
        jobFor.layer.borderColor = UIColor.blue.cgColor
        bid.layer.masksToBounds = true
        bid.layer.cornerRadius = 8
        bid.layer.borderColor = UIColor.black.cgColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func bidonitPressed(_ sender: Any) {
        biders=list[newindex]["bider"] as! [String]
        biders.append(userName)
        let post = ["Desc": descriptionLabel.text!,
                    "JobTitle": jobNAme.text!,
                    "budget": budgetAmount.text!,
                    "jobPoster": list[newindex]["jobPoster"],
                    "jobfor": jobFor.text!,
                    "time": timeLabel.text!,
                    "bider": biders
            
        ]
        let childUpdates = ["/Jobs/\(childKey[newkey])": post]
        ref.updateChildValues(childUpdates)
        dismiss(animated: true, completion: nil)
    }
}
