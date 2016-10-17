//
//  Recent.swift
//  ChatApp1
//
//  Created by Ralph Venuto on 7/9/16.
//  Copyright © 2016 Ralph Venuto. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

//Mark: Helper functions

private let dateFormat = "yyyyMMddHHmmss"

//let firebase = Firebase(url: "https://chatapp1-241cf.firebaseio.com")  Depreciated
let rootRef = FIRDatabase.database().reference()

let backendless = Backendless.sharedInstance()
let currentUser = backendless.userService.currentUser

func dateFormatter() -> NSDateFormatter {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
    
}