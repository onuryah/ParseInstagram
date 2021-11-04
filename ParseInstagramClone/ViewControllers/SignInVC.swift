//
//  ViewController.swift
//  ParseInstagramClone
//
//  Created by Ceren Çapar on 3.11.2021.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func signInButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toTabBar", sender: nil)
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
    }
    
}

