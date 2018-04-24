//
//  MessageTableViewCell.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    

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
    }
    
}
