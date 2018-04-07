//
//  LoginViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 18/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
//            print("JESS: ID found in keychain")
//            performSegue(withIdentifier: "toOption", sender: nil)
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        if email.text! != "" {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: (error?.localizedDescription)!, preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                print(error?.localizedDescription)
            }else{
                let keychainResult = KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
                print(keychainResult)
                self.performSegue(withIdentifier: "toOption", sender: nil)
            }
        }
        }else{
            let alert = UIAlertController(title: "Error!", message: "Please fill all fields", preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
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
