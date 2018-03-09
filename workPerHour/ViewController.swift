//
//  ViewController.swift
//  workPerHour
//
//  Created by Syed  Rafay on 24/02/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {

    @IBOutlet var tqbleVeiw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     tableMod()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}

//---------- Extention--------------//




extension ViewController:UITableViewDataSource{
    
    func tableMod(){
        tqbleVeiw.backgroundView?.backgroundColor = .clear ;
        tqbleVeiw.separatorColor = .clear
        tqbleVeiw.layer.cornerRadius = 5;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        return tempCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
