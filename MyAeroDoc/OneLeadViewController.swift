//
//  OneLeadViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 03.05.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class OneLeadViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    var lead : AGLead?
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func accept(sender: AnyObject) {
        AeroDocAPIClient.sharedInstance().postLead(self.lead!, success: { () -> () in
            var error : NSErrorPointer = nil
            if((AeroDocAPIClient.sharedInstance().localStore?.save(self.lead?.dictionary(), error: error)) != nil){
                println("error occured durning save")
            }
        }) { (error) -> () in
            println("ops!")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goBackToList() ->(){
        self.lead?.saleAgent = AeroDocAPIClient.sharedInstance().userId
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
