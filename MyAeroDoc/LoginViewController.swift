//
//  LoginViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 23.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    var deviceToken: NSData?
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
            self.performSegueWithIdentifier("toTab", sender: self)
            
        }) { (error) -> () in
            println("An error has occured during login! \n \(error)")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func deviceRegistration() ->(){
    #if !TARGET_IPHONE_SIMULATOR
       var registration = AGDeviceRegistration(serverURL: NSURL(string: URL_UNIFIED_PUSH))
        registration.registerWithClientInfo({ (clientInfo) -> Void in
            clientInfo.variantID = VARIANT_ID
            clientInfo.variantSecret = VARIANT_SECRET
            clientInfo.deviceToken = self.deviceToken
            clientInfo.categories = ["lead"]
            var currentDevice = UIDevice.currentDevice()
            clientInfo.alias = AeroDocAPIClient.sharedInstance().loginName
            clientInfo.operatingSystem = currentDevice.systemName
            clientInfo.osVersion = currentDevice.systemVersion
            clientInfo.deviceType = currentDevice.model
            
        }, success: { () -> Void in
            println("UnifiedPush registration successful")
        }, failure: { (error) -> Void in
            println("UnifiedPush registration Error: \(error)")
        })
        
    #endif
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
