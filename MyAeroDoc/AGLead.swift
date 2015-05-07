//
//  AGLead.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 29.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit
import Foundation

class AGLead: NSObject,NSCopying  {
    var recId: NSNumber?
    var name : String = ""
    var location : String = ""
    var phoneNumber: String = ""
    var saleAgent: String?
    
    init(dictionary: NSDictionary) {
        super.init()
        self.recId = dictionary.objectForKey("id")?.integerValue
        self.name = dictionary.objectForKey("name") as! String
        self.location = dictionary.objectForKey("location") as! String
        self.phoneNumber = dictionary.objectForKey("phoneNumber") as! String
        self.saleAgent = dictionary.objectForKey("saleAgent") as? String
}
    func dictionary() ->(NSDictionary){
        if(recId != nil && saleAgent != nil){
        return ["id" : self.recId!.stringValue,"name":self.name,"location":self.location,"phoneNumber":self.phoneNumber,"saleAgent": self.saleAgent!]// maybe need add check for null
        
        }
        return ["name":self.name,"location":self.location,"phoneNumber":self.phoneNumber]
    }
    
    func copyFrom(lead: AGLead)->() {
    self.recId = lead.recId
    self.name = lead.name
    self.location = lead.location
    self.phoneNumber = lead.phoneNumber
    self.saleAgent = lead.saleAgent
    }
    func copyWithZone(zone: NSZone) -> AnyObject {
        var lead: AGLead = AGLead.allocWithZone(zone)
        lead.recId = self.recId
        lead.name = self.name
        lead.location = self.location
        lead.phoneNumber = self.phoneNumber
        lead.saleAgent = self.saleAgent
        return lead
    
    }
    override func isEqual(object: AnyObject?) -> Bool {
        if(!(object is AGLead)){
            return false
        }
        var otherLead = object as! AGLead
        return (self.recId!.isEqualToNumber(otherLead.recId!))// need check nil before unwrapping!
    }
    
    func descript() -> NSString{
        return "\(object_getClass(self)) [id=\(self.recId), name=\(self.name), location=\(self.location), phoneNumber=\(self.phoneNumber), saleAgent=\(self.saleAgent)]"
    }
    
   
}
