//
//  AGMyLeadsTableViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 30.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class AGMyLeadsTableViewController: UITableViewController {
    var MyLeads = []
    var localStore: AGStore = AeroDocAPIClient.sharedInstance().localStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.contentInset = UIEdgeInsetsMake(64,0,0,0)// 44 + 20
        self.tableView.rowHeight = 60
        self.displayLeads()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myLeadRefresh", name: "LeadAddedNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myLeadRefresh", name: "LeadAcceptedNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myLeadRefresh", name: "AcceptNotification", object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return MyLeads.count
    }
    func displayLeads()->(){
        self.MyLeads = (localStore.readAll() as NSArray).mutableCopy() as! NSMutableArray // difficult place
        
    }
    func myLeadRefresh() -> (){
        self.displayLeads()
        self.tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LeadCell
        //var test = (MyLeads[indexPath.row] as NSDictionary)
        //var bg = test["location"]
        cell.topLabel.text = (MyLeads[indexPath.row] as! NSDictionary)["name"] as! String
        cell.bottomLabel.text = (MyLeads[indexPath.row] as! NSDictionary)["location"] as! String        // Configure the cell...
        //cell.topLabel.text = "br"

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
