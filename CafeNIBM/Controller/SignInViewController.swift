//
//  SignInViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/13/21.
//

import UIKit
import Firebase
import NotificationBannerSwift

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBAction func onSignInPressed(_ sender: UIButton) {
        
       if Inputvalidator.isValidEmail(email: txtEmail.text ?? "") {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a valid Email address", style: .danger)
            banner.show()
            return
        }
        
       if Inputvalidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50) {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a valid Password", style: .danger)
            banner.show()
            return
        }
        
        authenticateUser(email: txtEmail.text!, password: txtPassword.text!) 
    }
    func authenticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password:password){
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                //let rightView = UIImageView(image: #imageLiteral(resourceName: "Error"))
                let banner = NotificationBanner(title: "Error Signing In", subtitle: "Invalid Username or Password", style: .danger)
                banner.show()
                return
            }
            
            if let email = authResult?.user.email{
                self.getUserData(email: email)
            } else {
                let banner = NotificationBanner(title: "Error Signing In", subtitle: "User Email not found", style: .danger)
                banner.show()
            }
            
            //save user logged in state
            let sessionManager = SessionManager()
            sessionManager.saveUserLogin()
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
        }
    }
    
    func getUserData(email: String) {
        ref.child("users")
        .child(email
        .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")).observe(.value,with: {
                (snapshot) in
                
                if snapshot.hasChildren() {
                    if let data = snapshot.value {
                        if let userData = data as? [String: String] {
                        
                    }
                }
            } else {
                let banner = NotificationBanner(title: "Error Signing In", subtitle: "User not found", style: .danger)
                banner.show()
                }
        })
    }
}
        
//        if validateInput() {
//            authenticateUser(email: txtEmail.text!, password: txtPassword.text!)        }
//        else {
//            print("Input Error Found")
//        }
//   }
//
//    func validateInput() -> Bool {
//        guard let email = txtEmail.text else {
//            print("Email is NULL")
//            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        guard let password = txtPassword.text else {
//            print("Password is NULL")
//            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if email.count < 5 {
//            print("Enter a valid Email")
//            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if password.count < 5 {
//            print("Enter a valid Password")
//            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        return true
//    }
    

