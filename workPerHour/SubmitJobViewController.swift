//
//  SubmitJobViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 10/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SubmitJobViewController: UIViewController {
    @IBOutlet weak var jobTitle: UITextField!
    @IBOutlet weak var timePrd: UITextField!
    
    @IBOutlet weak var jobFor: UITextView!
    @IBOutlet weak var budget: UITextField!
    @IBOutlet weak var jobDescription: UITextView!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        JobInfo = ["JobTitle":jobTitle.text!,"Desc":jobDescription.text!,"budget":budget.text!,"time":timePrd.text!,"jobfor":jobFor.text!,"jobPoster":userName]
        ref.child("Jobs").childByAutoId().setValue(JobInfo)
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
