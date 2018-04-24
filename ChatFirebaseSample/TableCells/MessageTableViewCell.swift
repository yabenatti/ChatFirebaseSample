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
    
    // MARK: - Constraints
    
    @IBOutlet weak var bubbleTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    var leadingConstraint: NSLayoutConstraint?
    var trailingConstraint: NSLayoutConstraint?
    
    // MARK: - Table Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.leadingConstraint = NSLayoutConstraint(item: self.bubbleView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8)
        self.trailingConstraint = NSLayoutConstraint(item: self.bubbleView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 8)
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
        
        // Incoming
        self.removeConstraints([self.bubbleTrailingConstraint, self.bubbleLeadingConstraint])
        
        if let userEmail = Auth.auth().currentUser?.email, userEmail == message.emailSender {
            if let trailingConstraint = self.trailingConstraint {
                self.bubbleView.addConstraint(trailingConstraint)
            }
        } else {
            if let leadingConstraint = self.leadingConstraint {
                self.bubbleView.addConstraint(leadingConstraint)
            }
        }
        
        self.layoutIfNeeded()
        self.updateConstraints()
    }
    
}
