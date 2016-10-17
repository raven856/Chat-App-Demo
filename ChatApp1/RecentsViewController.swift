//
//  RecentsViewController.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/7/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import UIKit

class RecentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblRecents: UITableView!
    
    var recents: [NSDictionary] = []
    
    
    @IBAction func composeMessage(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableviewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let recentCell = tableView.dequeueReusableCellWithIdentifier("RecentCell", forIndexPath: indexPath) as! RecentsTableViewCell
        let recent = recents[indexPath.row]
        
        recentCell.bindData(recent)
        return recentCell
    }
    

}
