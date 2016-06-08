//
//  ViewController.swift
//  MESAC-Companion
//
//  Created by Philippos Slicher on 5/29/16.
//  Copyright © 2016 YDPS. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bottomNavigationController: BottomNavigationController = BottomNavigationController()
        bottomNavigationController.viewControllers = [NavigationController(rootViewController: ViewController()), NavigationController(rootViewController: ViewController())]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        //LightContent
        return UIStatusBarStyle.LightContent
        
        //Default
        //return UIStatusBarStyle.Default
        
    }

}

