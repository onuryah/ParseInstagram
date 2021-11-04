//
//  ViewController.swift
//  ParseInstagramClone
//
//  Created by Ceren Çapar on 3.11.2021.
//

import UIKit
import Parse

class SignInVC: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "banana"
        parseObject["calories"] = 200
        parseObject.saveInBackground { success, error in
           if error != nil{
                print(error?.localizedDescription ?? "")
           } else {
               print("success")
           }
        }
        
        
        let query = PFQuery(className: "Fruits")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                if let objects = objects {
                    print(objects)

                }
            }
        }
    }
    @IBAction func signInButtonClicked(_ sender: Any) {
        if userNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { user, error in
                if error != nil {
                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "ERROR", message: "Username/Password ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if userNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
        let user = PFUser()
        user.username = userNameTextField.text!
        user.password = passwordTextField.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else {
                    
                    
                }
            }
            
        }else{
            let alert = UIAlertController(title: "ERROR", message: "Username/Password ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }

    
    }

}
