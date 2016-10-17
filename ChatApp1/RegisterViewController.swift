//
//  RegisterViewController.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/7/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!

    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    var newUser: BackendlessUser?
    var email: String?
    var username:String?
    var password: String?
    var avatarImg: UIImage?
  
    //MARK: Register Button
    @IBAction func btnRegister(sender: AnyObject) {
        
        //Test
        print("Test")
        
        if txtEmail.text != "" && txtPassword.text != "" && txtUserName.text != "" {
            
            ProgressHUD.show("Registering...")
            
            email = txtEmail.text
            password = txtPassword.text
            username = txtUserName.text
            
            register(self.email!, username: self.username!, password: self.password!, avatarImg: self.avatarImg)
            
            ProgressHUD.dismiss()
            
        } else {
            //Warning to user
            ProgressHUD.showError("All fields are required")
            
        }
        
    }
    
    func register(email: String, username: String, password: String, avatarImg: UIImage?){
        //Test
        print("Test")
        
        if avatarImg == nil {
            newUser!.setProperty("Avatar", object: "")
        }
        
        newUser!.email = email
        newUser!.name = username
        newUser!.password = password
        
        backendless.userService.registering(newUser, response: { (registeredUser: BackendlessUser!) -> Void in
            //Login User
            
            self.loginUser(email, username: username, password: password)
            
            self.clearTextFields()
            
        }) { (fault: Fault!) -> Void in
            
                print("Server reported an error, could not register new user: \(fault)")
            
        }
        
    }
    //MARK: Login Function
    func loginUser(email: String, username: String, password: String){
        
        backendless.userService.login(email, password: password, response: { (user: BackendlessUser!) -> Void in
            
            //segue to recents view controller
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }) { (fault: Fault!) -> Void in
            
            print("Server reported an error: \(fault)")
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newUser = BackendlessUser()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearTextFields(){
        txtUserName.text?.removeAll()
        txtPassword.text?.removeAll()
        txtEmail.text?.removeAll()
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
