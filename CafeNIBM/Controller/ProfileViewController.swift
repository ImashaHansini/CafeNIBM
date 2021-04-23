//
//  ProfileViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/23/21.
//

import UIKit

class ProfileViewController: UIViewController {

    let sessionMGR = SessionManager()
    
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = sessionMGR.getUserData()
        txtUsername.text = user.userName
        txtEmail.text = user.userEmail
        txtPhone.text = user.userPhone

    }
    
    @IBAction func onSignOutPressed(_ sender: UIButton) {
        
        sessionMGR.clearUserLoggedState()
    }
    
}
