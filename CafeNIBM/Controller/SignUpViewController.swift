//
//  SignUpViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/17/21.
//

import UIKit
import Firebase
import NotificationBannerSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        if validateInput() {
            registerUser(email: txtEmail.text!, password:txtPassword.text!)
        } else {
            print("Input error found")
        }
    }
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                let banner = NotificationBanner(title: "Error Signing Up", subtitle: "User Sign Up failed", style: .danger)
                banner.show()
                return
            }
            
            if let result = authResult {
                print("User added with Email: \(result.user.email ?? "Not found")")
                let banner = NotificationBanner(title: "Done", subtitle: "User Registered Successfuly", style: .success)
                banner.show()
            }
        }
    }
    
    func validateInput() -> Bool {
        guard let name = txtName.text else{
            print("Name is Null")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
            banner.show()
            return false
        }
        
        guard let phone = txtPhone.text else{
            print("Phone is Null")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
            banner.show()
            return false
        }
        
        guard let email = txtEmail.text else{
            print("Email is Null")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
            banner.show()
            return false
        }
        
        guard let password = txtPassword.text else{
            print("Password is Null")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
            banner.show()
            return false
        }
        
        if name.count < 5 {
            print("Enter a valid name")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
            banner.show()
            return false
        }
        
        if phone.count < 10 {
            print("Enter a valid phone number")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
            banner.show()
            return false
        }
        
        if email.count < 5 {
            print("Enter a valid email")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
            banner.show()
            return false
        }
        
        if password.count < 5 {
            print("Enter a valid password")
            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
            banner.show()
            return false
        }
        
        return true
    }
    
 }
