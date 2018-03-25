//
//  PROFILEViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 12/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class PROFILEViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var contacttext: UITextField!
    @IBOutlet var contactLabel: UILabel!
    @IBOutlet var amounttext: UITextField!
    @IBOutlet var amountPerhourlbel: UILabel!
    @IBOutlet var portfolioUrlLabel: UILabel!
    @IBOutlet var portfolioText: UITextField!
    @IBOutlet var segmentedCtrl: UISegmentedControl!
    @IBOutlet var email: UITextField!
    @IBOutlet var FULLNAME: UITextField!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contacttext.isHidden = true;
        contactLabel.isHidden = true
        amounttext.isHidden = true
        amountPerhourlbel.isHidden = true
        portfolioText.isHidden = true
        portfolioUrlLabel.isHidden = true
        imageView.layer.cornerRadius =
   imageView.frame.size.width / 2;
        imageView.clipsToBounds = true;
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

    @IBAction func segmentedSelected(_ sender: Any) {
        if segmentedCtrl.selectedSegmentIndex == 0{
            contacttext.isHidden = false;
            contactLabel.isHidden = false
            amounttext.isHidden = false
            amountPerhourlbel.isHidden = false
            portfolioText.isHidden = false
            portfolioUrlLabel.isHidden = false
        } else {
            contacttext.isHidden = true;
            contactLabel.isHidden = true
            amounttext.isHidden = true
            amountPerhourlbel.isHidden = true
            portfolioText.isHidden = true
            portfolioUrlLabel.isHidden = true
        }
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


