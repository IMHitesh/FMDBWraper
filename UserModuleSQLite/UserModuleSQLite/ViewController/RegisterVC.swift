//
//  RegisterVC.swift
//  UserModuleSQLite
//
//  Created by Hitesh on 28/05/19.
//  Copyright © 2019 Hitesh. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var txtEmail: HSTextField!
    @IBOutlet weak var txtPassword: HSTextField!
    @IBOutlet var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValidation()
        imagePicker.delegate = self
    }
    
    func setValidation(){
        txtEmail.setValidation(Type: .Email)
        txtPassword.setValidation(Type: .Password)
    }
    
    @IBAction func btnLoginTap(){
        if self.view.ValidateAllTextField(){
            
            let email = txtEmail.text!
            let password = txtPassword.text!
            HSDBManager.sharedInstance.methodToSelectData("SELECT * FROM UserModule WHERE email = '\(email)'") { (aryData) in
                
                if aryData.count == 0{
                    let strQuery = "INSERT INTO UserModule (email,password) VALUES('\(email)','\(password)')"
                    HSDBManager.sharedInstance.methodToInsertUpdateDeleteData(strQuery) { (status) in
                        print("User loggedIn Sucessfuly")
                    }
                }else{
                        self.view.makeToast("Already exsist in DB")
                    }
                }
            }
        }
    
    @IBAction func openImagePicker(sender: UIControl) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


