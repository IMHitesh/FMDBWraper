//
//  ViewController.swift
//  UserModuleSQLite
//
//  Created by Hitesh on 28/05/19.
//  Copyright © 2019 Hitesh. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: HSTextField!
    @IBOutlet weak var txtPassword: HSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValidation()
    }
    
    func setValidation(){
        txtEmail.setValidation(Type: .Email)
        txtPassword.setValidation(Type: .Password)
    }
    
    @IBAction func btnLoginTap(){
        if self.view.ValidateAllTextField(){
            let email = txtEmail.text!
            let password = txtPassword.text!
            let strQuery = "INSERT INTO UserModule (email,password) VALUES('\(email)','\(password)')"
            HSDBManager.sharedInstance.methodToInsertUpdateDeleteData(strQuery) { (status) in
                print("User loggedIn Sucessfuly")
            }
        }
    }
}

