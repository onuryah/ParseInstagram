//
//  FeedCell.swift
//  ParseInstagramClone
//
//  Created by Ceren Çapar on 4.11.2021.
//

import UIKit
import Parse

class FeedCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var postOwnerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.uuidLabel.isHidden = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        let likeObjects = PFObject(className: "Likes")
        likeObjects["from"] = PFUser.current()!.username!
        likeObjects["to"] = uuidLabel.text
        
        likeObjects.saveInBackground { success, error in
            if error == nil {
                
            }
        }
    }
    @IBAction func commentButtonClicked(_ sender: Any) {
        let commentObjects = PFObject(className: "Comments")
        commentObjects["from"] = PFUser.current()!.username!
        commentObjects["to"] = uuidLabel.text
        
        commentObjects.saveInBackground { success, error in
            if error == nil {
                
            }
        }
    }
    
}
