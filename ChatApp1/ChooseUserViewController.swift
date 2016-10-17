//
//  ChooseUserViewController.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/18/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import UIKit

class ChooseUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var tableView: UITableView!
    
    var users: [BackendlessUser] = []
    
    @IBAction func btnCancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    //MARK: tableview
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let user = users[indexPath.row] 
        
        cell.textLabel?.text = user.name
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
    //MARK: load backendless users
    func loadUsers() {
        
        let whereClause = "objectId != '\(currentUser.objectId)'"
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        let dataStore = backendless.persistenceService.of(BackendlessUser.ofClass())
        
        dataStore.find(dataQuery, response: { (users : BackendlessCollection!) -> Void in
            
            self.users = users.data as! [BackendlessUser]
            
            self.tableView.reloadData()
            print("test") //reaches this
            /*test
            for user in users.data {
                let u = user as! BackendlessUser
                print(u.name)
            }*/
            
            }) {(fault : Fault!) -> Void in
                
                print("Error, could not retrieve users \(fault)")
        
        }
        
    }
    
    override func viewDidLoad() {
        loadUsers()
    }
    
}
