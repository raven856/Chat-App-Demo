//
//  LoginViewController.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/7/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var email: String!
    var password: String!
    
    let backendless = Backendless.sharedInstance()
    
    @IBAction func btnLogin(sender: AnyObject) {
        
        if txtEmail.text != "" && txtPassword.text != "" {
            
            password = self.txtPassword.text
            email = self.txtEmail.text
            
            //login user
            loginUser(email!, password: password!)
            
        } else {
            //show error
        }
        
    }
    
    func loginUser(email: String, password: String) {
        
        backendless.userService.login(email, password: password, response: { (user : BackendlessUser!) in
            
            self.txtEmail.text?.removeAll()
            self.txtPassword.text?.removeAll()
            
            //segue to viewcontroller
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0
            
            self.presentViewController(vc, animated: true, completion: nil)
            
            print("logged in")
            
        }) { (fault : Fault!) in
                print("couldnt login user \(fault)")
        }
        
    }
    
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
