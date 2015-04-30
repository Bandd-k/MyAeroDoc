//
//  LoginViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 23.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.delegate = self
        self.passwordField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func PushLogin(sender: AnyObject) {
        println("start Logging")
        var apiClient = AeroDocAPIClient()
        apiClient.loginWithUsername(usernameField.text, password: passwordField.text, succes: { () -> () in
            println("Ok")
        }) { (error) -> () in
            println("An error has occured during login! \n \(error)")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
