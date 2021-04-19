//
//  SignInViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/13/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var number: Int?
    var fetchedNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func onSignInPressed(_ sender: UIButton) {
        if validateInput() {
            authenticateUser(email: txtEmail.text!, password: txtPassword.text!)        }
        else {
            print("Input Error Found")
        }
    }
    
    func validateInput() -> Bool {
        guard let email = txtEmail.text else {
            print("Email is NULL")
            return false
        }
        
        guard let password = txtPassword.text else {
                 print("Password is NULL")
                 return false
        }
        
        if email.count < 5 {
            print("Enter a valid Email")
            return false
        }
        
        if password.count < 5 {
            print("Enter a valid Password")
            return false
        }
        
        return true
    }
    
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password:password){
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            //save user logged in state
            let sessionManager = SessionManager()
            sessionManager.saveUserLogin()
        }
    }
}
