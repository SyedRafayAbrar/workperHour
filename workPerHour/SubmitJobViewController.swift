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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
