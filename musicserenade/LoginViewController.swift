//
//  LoginViewController.swift
//  musicserenade
//
//  Created by Isaac Lee on 9/13/18.
//  Copyright © 2018 IsaacLee. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInSignUpButton: UIButton!
    @IBOutlet weak var changeLoginSignUpButton: UIButton!
    
    var signUpMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
    }

    @IBAction func logInSignUpTapped(_ sender: Any) {
        if signUpMode {
            let user = PFUser()
            
            user.username = usernameTextField.text
            user.password = usernameTextField.text
            
            user.signUpInBackground(block: { (sucess, error) in
                if error != nil {
                    var errorMessage = "Sign Up Failed - Try Again"
                    
                    if let newError = error as NSError? {
                        if let detailError = newError.userInfo["error"] as? String {
                            errorMessage = detailError
                    //Just in case we have an error
                        
                        }
                    }
                
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = errorMessage
                    
                } else {
                    print("Sign Up Sucessful")
                }
            })
            
        } else {
            
            if let username = usernameTextField.text {
                if let password = passwordTextField.text {
                    PFUser.logInWithUsername(inBackground: username, password: password, block: { (user, error) in
                        if error != nil {
                            var errorMessage = "Log In Failed - Try Again"
                            
                            if let newError = error as NSError? {
                                if let detailError = newError.userInfo["error"] as? String {
                                    errorMessage = detailError
                                    //Just in case we have an error
                                    
                                }
                            }
                            
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = errorMessage
                            
                        } else {
                            print("Logged In Sucessfully")
                        }
                    })
                }
            }
        }
    }
             
    @IBAction func changeLogInSignUpTapped(_ sender: Any) {
        if signUpMode {
            logInSignUpButton.setTitle("Log In", for: .normal)
            changeLoginSignUpButton.setTitle("Sign Up", for: .normal)
            signUpMode = false
        } else {
            logInSignUpButton.setTitle("Sign Up", for: .normal)
            changeLoginSignUpButton.setTitle("Log In", for:. normal)
            signUpMode = true
        }
    }
}

