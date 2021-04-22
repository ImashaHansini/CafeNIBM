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
    
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        
        if !Inputvalidator.isValidName(name: txtName.text ?? "") {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a valid Name", style: .danger)
            banner.show()
            return
        }
        
        if !Inputvalidator.isValidMobileNo(txtPhone.text ?? "") {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a valid Phone Number", style: .danger)
            banner.show()
            return
        }
        
        if !Inputvalidator.isValidEmail(email: txtEmail.text ?? "") {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a Email Address", style: .danger)
            banner.show()
            return
        }
        
        if !Inputvalidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6 , maxLength: 50) {
            let banner = NotificationBanner(title: "Error Signing In", subtitle: "Please enter a valid Password", style: .danger)
            banner.show()
            return
        }
        
        let user = User(userName: txtName.text ?? "", userEmail: txtEmail.text ?? "", userPassword: txtPassword.text ?? "", userPhone: txtPhone.text ?? "")
        
        registerUser(user: user)
    }
//        if validateInput() {
//            registerUser(email: txtEmail.text!, password:txtPassword.text!)
//        } else {
//            print("Input error found")
//        }
//}
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registerUser(user: User){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                let banner = NotificationBanner(title: "Error Signing Up", subtitle: "User Sign Up failed", style: .danger)
                banner.show()
                return
            }
            
            self.saveUserdata(user: user)
        
//            if let result = authResult {
//                print("User added with Email: \(result.user.email ?? "Not found")")
//                let banner = NotificationBanner(title: "Done", subtitle: "User Registered Successfuly", style: .success)
//                banner.show()
//            }
        }
    }
    
    func saveUserdata(user: User) {
        
        let userData = [
            "userName" : user.userName,
            "userEmail" : user.userEmail,
            "userPhone" : user.userPhone,
            "userPassword" : user.userPassword
        ]
        
        self.ref.child("users")
            .child(user.userEmail
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_")).setValue(userData) {
        (error, ref) in
            
            if let err = error {
                print(err.localizedDescription)
                let banner = NotificationBanner(title: "Error", subtitle: "User data not saved on database!", style: .danger)
                banner.show()
                return
            }
            
            let banner = NotificationBanner(title: "Done", subtitle: "User data saved on database!", style: .success)
                    banner.show(queuePosition: .front)
                    self.dismiss(animated: true, completion: nil)
        }
        
    }
}
    
//    func validateInput() -> Bool {
//        guard let name = txtName.text else{
//            print("Name is Null")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        guard let phone = txtPhone.text else{
//            print("Phone is Null")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        guard let email = txtEmail.text else{
//            print("Email is Null")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        guard let password = txtPassword.text else{
//            print("Password is Null")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter all the details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if name.count < 5 {
//            print("Enter a valid name")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if phone.count < 10 {
//            print("Enter a valid phone number")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if email.count < 5 {
//            print("Enter a valid email")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        if password.count < 5 {
//            print("Enter a valid password")
//            let banner = NotificationBanner(title: "Error Signing Up", subtitle: "Please enter valid details", style: .danger)
//            banner.show()
//            return false
//        }
//
//        return true
//    }
//
 //}
