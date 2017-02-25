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
        user.username = emailTextField.text!
        user.password = passwordTextField.text!
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription
                let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                self.performSegue(withIdentifier: "chatSegue", sender: self)
            }
        }
    }

    @IBAction func login(_ sender: Any) {
        let username = emailTextField.text
        let password = passwordTextField.text
        PFUser.logInWithUsername(inBackground: username!, password: password!) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                self.performSegue(withIdentifier: "chatSegue", sender: self)
            }
            else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
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
