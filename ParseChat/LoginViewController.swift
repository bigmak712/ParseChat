//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Timothy Mak on 2/23/17.
//  Copyright © 2017 Timothy Mak. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground{
            (success, error) -> Void in
            if let error = error {
                let errorMessage = (error as NSError).userInfo["error"] as? NSString
                if errorMessage != nil {
                    print("ERROR: \(errorMessage)")
                    let alertController = UIAlertController(title: "Error", message: "ERROR: Could not sign up!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true)
                }
            }
            else {
                print("Sign-up successful!")
                self.performSegue(withIdentifier: "chatSegue", sender: self)
            }
        }
    }

    @IBAction func login(_ sender: Any) {
        let username = emailTextField.text
        let password = passwordTextField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!) {
            (user: PFUser?, error: Error?) -> Void in
            if let error = error {
                let errorMessage = (error as NSError).userInfo["error"] as? NSString
                if errorMessage != nil {
                    print("ERROR: \(errorMessage)")
                    let alertController = UIAlertController(title: "Error", message: "ERROR: Could not log in!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController, animated: true)
                }
            }
            else {
                print("Login successful!")
                self.performSegue(withIdentifier: "chatSegue", sender: self)
            }

        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
