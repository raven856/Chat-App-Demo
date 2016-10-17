//
//  WelcomeViewController.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/7/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

    let backendless = Backendless.sharedInstance()
    
    var currentUser: BackendlessUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewWillAppear(animated: Bool) {
        
        backendless.userService.setStayLoggedIn(true)
        
        currentUser = backendless.userService.currentUser
        
        if currentUser != nil {
            
            dispatch_async(dispatch_get_main_queue()) {
            
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
                vc.selectedIndex = 0
            
                self.presentViewController(vc, animated: true, completion: nil)
                
            }
            
        } else {
            
            
            
        }
        
    }

}
