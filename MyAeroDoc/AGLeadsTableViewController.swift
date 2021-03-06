//
//  AGLeadsTableViewController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 30.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class AGLeadsTableViewController: UITableViewController {
    var Allleads = [AGLead]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayLeads()
        var refreshButton = UIBarButtonItem(image: UIImage(named: "refresh15.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "displayLeads")
        self.navigationItem.setRightBarButtonItem(refreshButton, animated: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayLeads", name: "LeadAddedNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayLeads", name: "LeadAcceptedNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayLeads", name: "AcceptNotification", object: nil)
//        self.navigationController?.navigationItem.setRightBarButtonItem(refreshButton, animated: true)
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
        return Allleads.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LeadCell
        cell.topLabel.text = Allleads[indexPath.row].name
        cell.bottomLabel.text = Allleads[indexPath.row].location
        
        // Configure the cell...

        return cell
    }
    //get all leads from server
    func displayLeads()->(){
        AeroDocAPIClient.sharedInstance().fetchLeads({ (leads) -> () in
            self.Allleads = leads// check for problem
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }, failure: { (error) -> () in
            println(error) // add UIALET instead log
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "TableSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as! OneLeadViewController
                destinationController.lead = Allleads[indexPath.row]
            }
        }
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
