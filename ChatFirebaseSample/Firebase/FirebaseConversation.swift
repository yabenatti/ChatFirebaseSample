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
            
            let sortedKeys = Array(data.keys).sorted()
            
            var arrayOfMessages = [Message]()
            for key in sortedKeys {
                guard let messageDict = data[key] as? [String : Any] else {
                    continue
                }
            
                print("\(messageDict)")
                if let message = Message.parseMessage(dict: messageDict) {
                    arrayOfMessages.append(message)
                }
            }
            
            completion(true, arrayOfMessages)
        }
    }
    
    func sendMessage(_ dict: [String:Any]) {
        Database.database().reference().child("messages").childByAutoId().setValue(dict)
    }
    
    func observeMessageAdditions(completion: @escaping(_ success: Bool, _ message: Message?) -> ())  {
        Database.database().reference().child("messages").observe(.childAdded) { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else {
                completion(false, nil)
                return
            }
            
            if let message = Message.parseMessage(dict: data) {
                completion(true, message)
            } else {
                completion(false, nil)
            }
        }
    }
}
