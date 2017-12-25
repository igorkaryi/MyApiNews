//
//  RegistrationVC.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var registrationBtn: UIButton!
    
    @IBAction func registrationAction(_ sender: UIButton) {
        if emailField.text != " " && passwordField.text != " " {
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "ShowDetailRegistrationSegue", sender: self)
                    print("Success")
                } else {
                    self.showWrongAlert()
                    if let myError = error?.localizedDescription {
                        print(myError)
                    } else {
                        print("ERROR")
                    }
                }
                
            })
        }
        if (passwordField.text != passwordConfirmationField.text) {
            self.wrongPpasswordConfirmationAlert()
        }
    }
    
    func showWrongAlert() {
        // create the alert
        let alert = UIAlertController(title: "Ошибка!", message: "Не правильний Email или пароль! Повторите попытку", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "ДА", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func wrongPpasswordConfirmationAlert() {
        // create the alert
        let alert = UIAlertController(title: "Ошибка!", message: "Подтвердите пароль", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "ДА", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
