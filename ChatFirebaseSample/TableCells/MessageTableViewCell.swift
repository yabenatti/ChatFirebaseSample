//
//  MessageTableViewCell.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessageTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var bubbleView: UIView!
    
    // MARK: - Table Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpWithMessage(_ message: Message) {
        self.emailLabel.text = message.emailSender
        self.contentLabel.text = message.content
        
        self.contentView.transform = CGAffineTransform(rotationAngle: (-.pi))
        self.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        
        if let userEmail = Auth.auth().currentUser?.email, userEmail == message.emailSender {
            self.emailLabel.textAlignment = .left
            self.contentLabel.textAlignment = .left
        } else {
            self.emailLabel.textAlignment = .right
            self.contentLabel.textAlignment = .right
        }
    }
    
}
