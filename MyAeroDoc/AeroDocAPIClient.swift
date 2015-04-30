//
//  AeroDocAPIClient.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 22.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import Foundation
class AeroDocAPIClient: NSObject {
    var userId:NSNumber = 0
    var loginName:String = ""
    var status:String = ""
    var latitude:String = ""
    var longitude: String = ""
    var leadsPipe: AGPipe?
    var agentPipe: AGPipe?
    var localStore: AGStore?
    var pushedLocalStore: AGStore?
    
    class func sharedInstance() -> AeroDocAPIClient {
        return _sharedInstance
    }
    
    func loginWithUsername(username: String,password: String,succes:()->(),failure:(error: NSError)->()){
        var baseUrl = NSURL(string: URL_AERODOC)
        // create the Pipeline object
        var pipeline = AGPipeline(baseURL: baseUrl)
        // create the Authenticator object
        var authenticator = AGAuthenticator()
        // request the default 'AeroGear' authentication module from 'Authenticator'
        var authMod = authenticator.auth { (config) -> Void in
            config.name = "todoAuthMod" // assign it a name
            config.baseURL = baseUrl // the base url to authenticate to
            config.type = "AG_SECURITY" // can be omitted as 'AG_SECURITY' is the default auth module
            config.loginEndpoint = "\(ENDPOINT)/login"
        }
        
        // build the credentials JSON object for AeroDoc backend:
        var credentials = ["loginName": username, "password": password]
        
        
       authMod.login(credentials, success: { (object1) -> Void in
        println("succes!")
        var object = object1 as NSDictionary
        //self.userId = object["id"] as NSNumber
        // some Nulls in Object
        self.loginName = object["loginName"] as String
        self.status = object["status"] as String
        self.latitude = object["latitude"] as String
        self.longitude = object["longitude"] as String
        
        self.leadsPipe = pipeline.pipe({ (config) -> Void in
            config.name = "leads"
            config.authModule = authMod
            config.endpoint = "\(ENDPOINT)/leads"
        })
        self.agentPipe = pipeline.pipe({ (config) -> Void in
            config.name = "saleagents"
            config.authModule = authMod
            config.endpoint = "\(ENDPOINT)/saleagents"
        })
        
        // initialize local store
        var dm = AGDataManager()
        self.localStore = dm.store({ (config) -> Void in
            config.name = username
            config.type = "PLIST"
        })
        self.localStore = dm.store({ (config) -> Void in
            config.name = "pusheLocalStorage\(username)"
            config.type = "PLIST"
        })
        succes()
       }) { (error) -> Void in
        failure(error: error)
        }
    }
    //fetchLeads
    func fetchLeads(success:(leads : NSMutableArray)->(),failure:(error: NSError)->() )->(){
        self.leadsPipe?.read({ (responseObject) -> Void in
            //add
            var leads = [AGLead]()
            for leadDict in (responseObject as NSArray){ // May be a problem !!)
                leads.append(AGLead(dictionary: leadDict as NSDictionary))
            }
            
        }, failure: { (error) -> Void in
            failure(error: error)
        })
    }
    
    func postLead(lead :AGLead,success:()->(),failure:(error: NSError)->())->(){
     leadsPipe?.save(lead.dictionary(), success: { (responseObject) -> Void in
        if (lead.recId == nil) { // if it is a new lead, set the id
            lead.recId = responseObject.objectForKey("id") as? NSNumber
        }
        
        success();
     }, failure: { (error) -> Void in
        failure(error: error);
     })
        
    }
    
    func changeStatus(status: String,succes:()->(),failure:(error: NSError)->())-> (){
        self.changeAgent(status, latitude: latitude, longitude: longitude, success: succes, failure: failure)
    }
    func changeLocation(latitude: String,longitude: String,succes:()->(),failure:(error: NSError)->())->(){
        self.changeAgent(status, latitude: latitude, longitude: longitude, success: succes, failure: failure)
    }
    
    
    func changeAgent(status: String,latitude: String,longitude: String,success:()->(),failure:(error: NSError)->())->(){
        var params = ["id":self.userId,"loginName":self.loginName,"status":status,"latitude":latitude,"longitude":longitude]
        agentPipe?.save(params, success: { (responseObject) -> Void in
            self.status = status
            self.longitude = longitude
            self.latitude = latitude
            success()
        }, failure: { (error) -> Void in
            failure(error: error)
        })
    }
    
    
    
}
let _sharedInstance : AeroDocAPIClient = {AeroDocAPIClient()}()