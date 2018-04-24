//
//  ConversationViewController.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
            self.tableView.separatorStyle = .none
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Variables
    var arrayOfMessages = [Message]()
    
    // MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, tableView.bounds.size.width - 10)
        self.tableView.transform = CGAffineTransform(scaleX: 1, y: -1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.startOberserOfNewMessages()
        self.recoverMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    func startOberserOfNewMessages() {
        FirebaseConversationService.sharedInstance.observeMessageAdditions { (success, message) in
            if success, let message = message {
                self.arrayOfMessages.append(message)
                self.tableView.insertRows(at: [IndexPath(row: self.arrayOfMessages.count - 1, section: 0)], with: .none)
            }
        }
    }
    
    func recoverMessages() {
        FirebaseConversationService.sharedInstance.getAllMessages { (success, arrayOfMessages) in
            if success, let arrayOfMessages = arrayOfMessages {
                self.arrayOfMessages.removeAll()
                self.arrayOfMessages = arrayOfMessages
                self.tableView.reloadData()
            }
        }
    }
    
    func sendMessageToFirebase() {
        guard let messageContent = self.textView.text, !messageContent.isEmpty,
            let userEmail = Auth.auth().currentUser?.email else {
            return
        }
        
        self.textView.text = ""
        
        let dict = ["email" : userEmail, "text" : messageContent]
        FirebaseConversationService.sharedInstance.sendMessage(dict)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    @IBAction func didTapSendButton(_ sender: Any) {
        self.sendMessageToFirebase()
    }
}

extension ConversationViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageTableViewCell.self), for: indexPath) as? MessageTableViewCell else {
            fatalError("Could not create cell")
        }
        
        let message = self.arrayOfMessages[indexPath.row]
        cell.setUpWithMessage(message)
        
        return cell
    }
}
