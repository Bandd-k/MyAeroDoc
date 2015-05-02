//
//  LoginViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 23.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

import CoreLocation
class LoginViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {
    var locationManger: CLLocationManager?
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

    //--------------------------------------------------------------------
    // Login button action. Once successfully logged we register device
    // for push notification
    //--------------------------------------------------------------------
    @IBAction func PushLogin(sender: AnyObject) {
        println("start Logging")
        var apiClient = AeroDocAPIClient.sharedInstance()
        // first, we need to login to the service
        apiClient.loginWithUsername(usernameField.text, password: passwordField.text, succes: { () -> () in
            println("Ok")
            // a successful login means we can trigger the device registration
            // against the AeroGear UnifiedPush Server:
            //self.deviceRegistration()
            self.locationManger = CLLocationManager()
            self.locationManger?.delegate = self
            self.locationManger?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            // needed for iOS8, check to support iOS7
            if((self.locationManger?.respondsToSelector("requestWhenInUseAuthorization")) != nil){// may be problem!!
                self.locationManger?.requestWhenInUseAuthorization()
            }
            self.locationManger?.startMonitoringSignificantLocationChanges()
            //now we can go to the next controller!
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
    
    func locationManager(manager:CLLocationManager,locations: NSArray) ->() {
        var location = locations.lastObject as CLLocation //may cause a problem!)
        var apiClient = AeroDocAPIClient.sharedInstance()
        var latitude = "\(location.coordinate.latitude)"
        var longitude = "\(location.coordinate.longitude)"
        apiClient.changeLocation(latitude, longitude: longitude, succes: { () -> () in
            println("Sucessussfully updated position")
        }) { (error) -> () in
            println("An error has occured during login! \(error)")
        }
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
