//
//  TabBarController.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 30.04.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //need to add check
        var tabBarItem1 = tabBar.items?[0] as! UITabBarItem
        var tabBarItem2 = tabBar.items?[1] as! UITabBarItem
        tabBarItem1.image = UIImage(named: "list.png")!
        tabBarItem2.image = UIImage(named: "me.png")!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
