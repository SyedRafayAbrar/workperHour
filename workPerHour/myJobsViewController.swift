//
//  myJobsViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 25/03/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseDatabase

class myJobsViewController: UIViewController,UITableViewDelegate {
    var myJobs=[String]()
    @IBOutlet var tqbleVeiw: UITableView!
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

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension myJobsViewController: UITableViewDataSource{
    func tableMod(){
        tqbleVeiw.backgroundView?.backgroundColor = .clear ;
        tqbleVeiw.separatorColor = .clear
        tqbleVeiw.layer.cornerRadius = 5;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        tempCell.jobName.text! = myList[indexPath.section]["JobTitle"]! as! String
        tempCell.category.text! = myList[indexPath.section]["jobfor"]! as! String
        tempCell.amount.text! = myList[indexPath.section]["budget"]! as! String
        return tempCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let ref3 = ref.child("Jobs").child(myChildKey[indexPath.section])
            ref3.removeValue()
            myList.remove(at: indexPath.section)
            tableView.reloadData()

        }
    }
    
}
