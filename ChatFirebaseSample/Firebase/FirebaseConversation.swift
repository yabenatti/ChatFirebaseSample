//
//  FirebaseConversation.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseConversationService {
    
    // MARK: - Variables
    static let sharedInstance = FirebaseConversationService()
    
    // MARK: - Messages
    
    func getAllMessages(completion: @escaping(_ success: Bool, _ arrayOfMessages: [Message]?) -> ()) {
        Database.database().reference().child("messages").observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else {
                completion(false, nil)
                return
            }
            
            var arrayOfMessages = [Message]()
            for (_, value) in data {
                if let dict = value as? [String: Any] {
                    print("\(dict)")
                    if let message = Message.parseMessage(dict: dict) {
                        arrayOfMessages.append(message)
                    }
                }
            }
            
            completion(true, arrayOfMessages)
        }
    }
}
