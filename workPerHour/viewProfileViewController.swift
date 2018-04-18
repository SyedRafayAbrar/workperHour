//
//  viewProfileViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 25/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SwiftKeychainWrapper

class viewProfileViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var myjobbutton: UIButton!
    @IBOutlet weak var unserName: UILabel!
    @IBOutlet weak var jobCount: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        


//        jobCount.text! = String(myList.count)
        print(myList.count)
        myjobbutton.isHidden = false
        
       
       let name = me["name"] as! String
        unserName.text! = name
        getImage()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if myList.count == 0 {
            getMyChildKey()
            fetchUserData()
            
            
            
            
        } else {
            myChildKey.removeAll()
            myList.removeAll()
                        getMyChildKey()
                        fetchUserData()
                        myjobbutton.isHidden = false
        }

        
        if (myKey != nil && userName != nil) {
            deleteButton.isHidden = false
        }
//      jobCount.text! = String(myList.count)
        jobCount.text! = String(myChildKey.count)
        
    }
    @IBAction func deleteAccountPressed(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            let ref4 = ref.child("Users").child(myKey)
         
            ref4.removeValue()
            var sref = Storage.storage().reference()
            let desertRef = sref.child("\(userName)/\("userPhoto")")
            
            // Delete the file
            desertRef.delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    KeychainWrapper.standard.removeAllKeys()
                    try! Auth.auth().signOut()
                     self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            
          
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func myjobsPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMyjob", sender: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
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

}

extension viewProfileViewController {
    func getImage() {
        let url = me["userPhoto"]
        let URL_IMAGE = URL(string: url as! String)
        let session = URLSession(configuration: .default)
        
        //creating a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            //if there is any error
            if let e = error {
                //displaying the message
                print("Error Occurred: \(e)")
                
            } else {
                DispatchQueue.main.async {
                    
                    //in case of now error, checking wheather the response is nil or not
                    if (response as? HTTPURLResponse) != nil {
                        
                        //checking if the response contains an image
                        if let imageData = data {
                            
                            //getting the image
                            let image = UIImage(data: imageData)
                            
                            //displaying the image
                            self.imageView.contentMode = .scaleAspectFit
                            self.imageView.image = image
                            
                            
                            
                        } else {
                            print("Image file is currupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
                
            }
            
        }
        getImageFromUrl.resume()
        
    }
    
    func imageViewEditor() {
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
    }
    
    
}

