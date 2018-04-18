//
//  helper.swift
//  workPerHour
//
//  Created by Syed  Rafay on 29/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit
var myKey:String!
var userinfo = [String:Any]()
var myJobs:[String:Any] = ["JobTitle":"","Desc":"","budget":"","time":"","jobfor":"","jobPoster":"","bider":[String]()]
var newindex:Int!
var newkey:Int!
var myChildKey=[String]()
var usersKey = [String]()
var biders = [String]()
var imgInfo:Any!
var imageSelected = false
var JobInfo = [String:Any]()
var ref: DatabaseReference!
var KEY_UID="uid"
var uid:String!
var userName:String!
var ref2: DatabaseReference!
var childKey=[String]()
var list = [[String:Any]]()
var storageref:StorageReference!

var myList = [myJobs]
var Jobs:[String:Any] = ["JobTitle":"","Desc":"","budget":"","time":"","jobfor":"","jobPoster":"","bider":[String]()]
var user:[String:Any] = ["name":"","email":"","contact":"","portfolio":"","Amount":"","userPhoto":""]
var me:[String:Any] = ["name":"","email":"","contact":"","portfolio":"","Amount":"","userPhoto":""]

var UsersList =  [[String:Any]]()
func getUserInfo(){
    let user = Auth.auth().currentUser
    
    if let user = user {
        
        uid=user.uid
        print("User ID \(uid)")
        userName=user.email
        
    }
}
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
                        if let biders = fetched["bider"] as? [String] {
                            Jobs["bider"] = biders
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

func getMyChildKey(){
    ref = Database.database().reference()
    ref.child("Jobs").queryOrdered(byChild: "jobPoster").queryEqual(toValue: userName).observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists()==true{
            for child in snapshot.children {
                print("1")
                let snap = child as! DataSnapshot
                let key = snap.key
                myChildKey.append(key)
                
                
            }
            print("child-- \(childKey)")
        }
    }
}

func fetchUserData(){
    ref = Database.database().reference()
    ref.child("Jobs").queryOrdered(byChild: "jobPoster").queryEqual(toValue: userName).observeSingleEvent(of: .value, with: { (snapshot) in
        
        if snapshot.exists() == true {
            
            for i in myChildKey{
                print("rrrr\(i)")
                if let value = snapshot.value as? NSDictionary{
                    print("Rafay-- \(value)")
                    if let fetched = value[i] as? [String:Any]{
                        if let title = fetched["JobTitle"] as? String {
                            myJobs["JobTitle"] = title
                        }
                        if let description = fetched["Desc"] as? String {
                            myJobs["Desc"] = description
                        }
                        if let budget = fetched["budget"] as? String {
                            myJobs["budget"] = budget
                        }
                        if let jobFor = fetched["jobfor"] as? String {
                            myJobs["jobfor"] = jobFor
                        }
                        if let time = fetched["time"] as? String {
                            myJobs["time"] = time
                        }
                        if let biders = fetched["bider"] as? [String] {
                            myJobs["bider"] = biders
                        }
                        myList.append(myJobs)
                    }
                }
                
                
                
                
            }
         
            
            
            print("ppppp\(list)")
        }else{
            let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.show(alert, sender: nil)
            
        }
        
    })

}

//func test(){
//    ref = Database.database().reference()
//ref.child("Users").queryOrdered(byChild: "email").queryEqual(toValue: userName as! String)
//}


func getProfileKey(){
    print(userName)
    ref = Database.database().reference()
    ref.child("Users").queryOrdered(byChild: "email").queryEqual(toValue: userName).observeSingleEvent(of: .value) { (snapshot) in
        print(snapshot.key)
        print("hey!")
        if snapshot.exists()==true{
            for child in snapshot.children {

                let snap = child as! DataSnapshot
                let key = snap.key
                myKey = key
                print("My key \(myKey)")

            }
        }else{
            print("Not found")
        }
    }
}

func getUsersKey(){
    ref = Database.database().reference()
    ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.exists()==true{
            for child in snapshot.children {
                print("1")
                let snap = child as! DataSnapshot
                let key = snap.key
                usersKey.append(key)
                
                
            }
        }
    }
}

func getUsers(){
    ref = Database.database().reference()
    ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
        
        if snapshot.exists() == true {
            
            for i in usersKey{
                print("rrrr\(i)")
                if let value = snapshot.value as? NSDictionary{
                    print("Rafay-- \(value)")
                    if let fetched = value[i] as? [String:Any]{
                        if let Name = fetched["name"] as? String {
                            user["name"] = Name
                        }
                        if let description = fetched["email"] as? String {
                            user["email"] = description
                        }
                        if let budget = fetched["Amount"] as? String {
                            user["Amount"] = budget
                        }
                        if let Contact = fetched["Contact"] as? String {
                            user["contact"] = Contact
                        }
                        if let portfolio = fetched["Portfolio"] as? String {
                            user["portfolio"] = portfolio
                        }
                        if let userPhoto = fetched["userphoto"] as? String {
                            user["userPhoto"] = userPhoto
                        }
                        UsersList.append(user)
                    }
                }
                
                
                
                
            }
            
            
            
            print("ppppp\(list)")
        }else{
            let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.show(alert, sender: nil)
            
        }
        
    })
}

func getProfile(){
    print(userName)
    print(myKey)
    ref = Database.database().reference()
    ref.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
        
        if snapshot.exists() == true {
            
            
            
                if let value = snapshot.value as? NSDictionary{
                    print("Rafay-- \(value)")
                    if let fetched = value[myKey] as? [String:Any]{
                        if let Name = fetched["name"] as? String {
                            me["name"] = Name
                        }
                        if let description = fetched["email"] as? String {
                            me["email"] = description
                        }
                        if let budget = fetched["Amount"] as? String {
                            me["Amount"] = budget
                        }
                        if let Contact = fetched["Contact"] as? String {
                            me["contact"] = Contact
                        }
                        if let portfolio = fetched["Portfolio"] as? String {
                            me["portfolio"] = portfolio
                        }
                        if let userPhoto = fetched["userphoto"] as? String {
                            me["userPhoto"] = userPhoto
                        }
                        print("Me \(me)")
                    }
                }
                
                
                
                
            
            
            
            
            print("ppppp\(list)")
        }else{
            let alert = UIAlertController(title: "Not Found", message: "Not found Data", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.show(alert, sender: nil)
            
        }
        
    })
    
}

