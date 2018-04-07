//
//  selectViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 10/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper

class selectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let user = Auth.auth().currentUser
        
        if let user = user {
           
            uid=user.uid
            userName=user.email
            
        }
     
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if list.count == 0{
        getID()
        fetchData()
        } else {
            list.removeAll()
            childKey.removeAll()
            getID()
            fetchData()
        }
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findjob(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    @IBAction func postAJob(_ sender: Any) {
        performSegue(withIdentifier: "toNew", sender: nil)
    }
    @IBAction func goToProfilePressed(_ sender: Any) {
    performSegue(withIdentifier: "gotoProfile", sender: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
       try! Auth.auth().signOut()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var initialViewController: UIViewController
        initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "main") as! LoginViewController
   present(initialViewController, animated: true, completion: nil)
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
