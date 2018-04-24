//
//  Message.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation


class Message {
    var content: String
    var emailSender: String
    
    init(content: String, emailSender: String) {
        self.content = content
        self.emailSender = emailSender
    }
}
