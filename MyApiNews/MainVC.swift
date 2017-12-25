//
//  ViewController.swift
//  MyApiNews
//
//  Created by Igor Karyi on 24.12.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FBSDKLoginKit

class MainVC: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to log into Google: ", err)
            return
        }
        
        print("Successfully logged into Google", user)
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if let err = error {
                print("Failed to create a Firebase User with Google account: ", err)
                return
            }
            
            guard let uid = user?.uid else { return }
            print("Successfully logged into Firebase with Google", uid)
        })
        
        self.performSegue(withIdentifier: "SuccessSegue", sender: self)
    }
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func loginActionBtn(_ sender: UIButton) {
        if emailField.text != " " && passwordField.text != " " {
            FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if user != nil {
                    print("Success")
                    self.performSegue(withIdentifier: "SuccessSegue", sender: self)
                } else {
                    if let myError = error?.localizedDescription {
                        print(myError)
                        self.showWrongAlert()
                    } else {
                        print("ERROR ")
                    }
                }
                
            })
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 29, y: 125, width: view.frame.width - 57, height: 40)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        self.performSegue(withIdentifier: "SuccessSegue", sender: self)
        print("Successfully logged in with facebook...")
    }
}

