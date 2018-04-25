//
//  LoginViewController.swift
//  ChatFirebaseSample
//
//  Created by Yasmin Benatti on 24/04/18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.keyboardType = .emailAddress
            self.emailTextField.delegate = self
            self.emailTextField.text = "min.benatti@gmail.com"
            self.emailTextField.tintColor = UIColor.darkPurpleLiberty
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.isSecureTextEntry = true
            self.passwordTextField.delegate = self
            self.passwordTextField.tintColor = UIColor.darkPurpleLiberty
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = UIColor.lightGray
            self.loginButton.layer.cornerRadius = 5
            self.loginButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signInLabel: UILabel! {
        didSet {
            self.signInLabel.textColor = UIColor.darkPurpleLiberty
        }
    }
    
    // MARK: - VC Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func didTapLoginButton(_ sender: Any) {
        self.signInUserOnFirebase()
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: - Functions
    func checkNoEmptyFields() {
        guard let email = self.emailTextField.text, !email.isEmpty else {
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            self.disableLoginButton()
            return
        }
        
        guard let password = self.passwordTextField.text, !password.isEmpty else {
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            self.disableLoginButton()
            return
        }
        
        self.enableLoginButton()
    }
    
    func enableLoginButton() {
        self.loginButton.isEnabled = true
        self.loginButton.backgroundColor = UIColor.lightSalmonPink
    }
    
    func disableLoginButton() {
        self.loginButton.isEnabled = false
        self.loginButton.backgroundColor = UIColor.lightGray
    }
    
    func createUserOnFirebase() {
        guard let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            self.goToConversation()
        }
    }
    
    func signInUserOnFirebase() {
        guard let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.goToConversation()
        }
    }
    
    func goToConversation() {
        let sb = UIStoryboard(name: "Conversation", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        } else if textField == self.passwordTextField {
            self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.checkNoEmptyFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension LoginViewController {
    @objc func keyboardWillHide(notification: Notification) {
        self.scrollView.contentInset = .zero
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if let frame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        }
        
    }
}
