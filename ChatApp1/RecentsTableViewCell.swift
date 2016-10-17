//
//  RecentsTableViewCell.swift
//  
//
//  Created by Ralph Venuto on 7/7/16.
//
//

import UIKit

class RecentsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblLastMessage: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblNewMessageCounter: UILabel!

    @IBOutlet weak var imgAvatar: UIImageView!

    let backendless = Backendless.sharedInstance()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(recent: NSDictionary) {
        
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.width/2
        imgAvatar.layer.masksToBounds = true
        
        self.imgAvatar.image = UIImage(named: "blank-profile-picture-973460_1280")
        
        let withUserId = recent.objectForKey("withUserUserId") as? String //he unwrapped..
        
        //get the backendless user and download avatar
        let whereClause = "objectId = '\(withUserId)"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        let dataStore = backendless.persistenceService.of(BackendlessUser.ofClass())
        
        dataStore.find(dataQuery, response: { (users : BackendlessCollection!) in
            
            let withUser = users.data.first as! BackendlessUser
            //use wit huser to get avatar
            
        }) { (fault : Fault!) in
            
            print("Didnt find or something")
            
        }
        
        lblName.text = recent["withUserUsername"] as? String
        lblLastMessage.text = recent["lastMessage"] as? String
        lblNewMessageCounter.text = ""
        
        if recent["counter"] as? Int != 0 {
            lblNewMessageCounter.text = "\(recent["counter"]!) New"
        }
        
        let date = dateFormatter().dateFromString((recent["date"] as? String)!)
        let seconds = NSDate().timeIntervalSinceDate(date!)

        lblTime.text = TimeElapsed(seconds)
    
    }

    func TimeElapsed(seconds: NSTimeInterval) -> String {
        let elapsed: String?
        if seconds < 60 {
            elapsed = "Just Now"
        } else if (seconds < 60 * 60) {
            let minutes = Int(seconds/60)
            var minText = "min"
            if minutes > 1 {
                minText = "mins"
            }
            elapsed = "\(minutes) \(minText)"
        } else if (seconds < 24 * 60 * 60) {
            let hours = Int(seconds/(60 * 60))
            var hourText = "hour"
            if hours>1 {
                hourText = "hours"
            }
            elapsed = "\(hours) \(hourText)"
        } else {
            let days = Int(seconds / (24 * 60 * 60))
            var dayText = "day"
            if days > 1 {
                dayText = "days"
            }
            elapsed = "\(days) \(dayText)"
        }
        return elapsed!
    }

}
    

