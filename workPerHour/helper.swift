//
//  helper.swift
//  workPerHour
//
//  Created by Syed  Rafay on 29/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import UIKit
var userinfo = [String:Any]()
var newindex:Int!
var imgInfo:Any!
var imageSelected = false
var JobInfo = [String:Any]()
var ref: DatabaseReference!
var KEY_UID="uid"
var uid:String!
var userName:String!
var ref2: DatabaseReference!
var childKey=[String]()
var list = [[String:String]]()

var Jobs = ["JobTitle":"","Desc":"","budget":"","time":"","jobfor":"","jobPoster":""]

func getID(){
    ref = Database.database().reference()
    ref.child("Jobs").observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists()==true{
            for child in snapshot.children {
                print("1")
                let snap = child as! DataSnapshot
                let key = snap.key
                childKey.append(key)
                
                
            }
            print("child-- \(childKey)")
        }
    }
    
}

func fetchData() {
    if list.count == 0 {
    ref2 = Database.database().reference()
    ref2.child("Jobs").observeSingleEvent(of: .value, with: { (snapshot) in
        if snapshot.exists() == true {
            for i in childKey {
                if let value = snapshot.value as? NSDictionary {
                    if let fetched = value[i] as? [String:Any]{
                        if let title = fetched["JobTitle"] as? String {
                            Jobs["JobTitle"] = title
                        }
                        if let description = fetched["Desc"] as? String {
                            Jobs["Desc"] = description
                        }
                        if let budget = fetched["budget"] as? String {
                            Jobs["budget"] = budget
                        }
                        if let jobFor = fetched["jobfor"] as? String {
                            Jobs["jobfor"] = jobFor
                        }
                        if let time = fetched["time"] as? String {
                            Jobs["time"] = time
                        }
                        list.append(Jobs)
                    }
                }
                print(list)
            }
        }else{
            let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.show(alert, sender: nil)
        }
    }) { (error) in
        print(error.localizedDescription)
    }
}
}


