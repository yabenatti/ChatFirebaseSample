//
//  ConversationViewController.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
        }
    }
    
    // MARK: - Variables
    var arrayOfMessages = [Message]()
    
    // MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.recoverMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    func recoverMessages() {
        self.tableView.reloadData()
    }
    
    func sendMessageToFirebase() {
        
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
