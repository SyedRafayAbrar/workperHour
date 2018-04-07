//
//  PROFILEViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 12/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PROFILEViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    @IBOutlet weak var password: UITextField!
    var imagePicker: UIImagePickerController!
    var storageref:StorageReference!
    var ref: DatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageref = Storage.storage().reference()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        contacttext.isHidden = false;
        contactLabel.isHidden = false
        amounttext.isHidden = false
        amountPerhourlbel.isHidden = false
        portfolioText.isHidden = false
        portfolioUrlLabel.isHidden = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20;
       imageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitPressed(_ sender: Any) {
        
    postUser()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

    @IBAction func selectImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)

    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerEditedImage"] as? UIImage {
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imgInfo=info["UIImagePickerControllerImageURL"]
            print("abrar___\(imgInfo)")
            print("rafay+++\(info)")
            imageSelected = true
        } else {
            print("JESS: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

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
extension PROFILEViewController{
    
    func postUser() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if error != nil {
                let errorOcc = error?.localizedDescription
                let alert = UIAlertController(title: "Error", message: errorOcc!, preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            } else {
                var data = NSData()
                data = UIImageJPEGRepresentation(self.imageView.image!, 0.8)! as NSData
                // set upload path
                let filePath = "\(self.email.text!)/\("userPhoto")"
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                self.storageref.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
                    if error != nil {
                        print("error occ \(error?.localizedDescription)")
                       
                    }else{
                        //store downloadURL
                        let downloadURL = metaData!.downloadURL()!.absoluteString
                        //store downloadURL at database
                        userinfo = ["name":self.FULLNAME.text!,"email":self.email.text!,"Contact":self.contacttext.text!,"Portfolio":self.portfolioText.text!,"Amount":self.amounttext.text!,"userphoto":downloadURL]
                        
                        self.ref = Database.database().reference()
                        self.ref.child("Users").childByAutoId().setValue(userinfo)
                        //self.ref.child("photos").child(uid!).updateChildValues(["userPhoto": downloadURL])
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                
                
                self.dismiss(animated: true, completion: nil)
            }
        })
        
        
        
        
    }
    
}

