//
//  AGStatus.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 30.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class AGStatus: NSObject {
   
    class func sharedInstance() -> AGStatus {
        return _sharedInstanc
    }
    class func targetList()->NSMutableArray{
        return _targets
    }
    
    func registerStatusItemOnTarger(target:AnyObject)->(UIBarButtonItem){
        AGStatus.targetList().addObject(target)
        return self.changeStatusOnTarget(target)
    }
    
    func changeStatusOnTarget(target:AnyObject)->(UIBarButtonItem){
        var statusImage:UIImage
        var statusButton:UIBarButtonItem
        if(AeroDocAPIClient.sharedInstance().status == "PTO"){
            statusImage = UIImage(named: "orange.png")! //add pictures
            statusButton = UIBarButtonItem(image: statusImage, landscapeImagePhone: statusImage, style: UIBarButtonItemStyle.Plain, target: target, action: "changeStatus")
            statusButton.tintColor = UIColor.orangeColor()
        }
        else{
            statusImage = UIImage(named: "green.png")!
            statusButton = UIBarButtonItem(image: statusImage, landscapeImagePhone: statusImage, style: UIBarButtonItemStyle.Plain, target: target, action: "changeStatus")
            statusButton.tintColor = UIColor.greenColor()
            
        }
        return statusButton
    }
    
}



let _sharedInstanc : AGStatus = {AGStatus()}()
let _targets: NSMutableArray = {NSMutableArray()}()