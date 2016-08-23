//
//  LiveViewController.swift
//  MESAC-Companion
//
//  Created by Philippos Slicher on 8/7/16.
//  Copyright © 2016 Philippos Slicher & Yajat Dua. All rights reserved.
//

import UIKit
import Firebase
import Material

class LiveViewController: UIViewController {//
    
    
    //Firebase Ref
    let rootRef = FIRDatabase.database().reference()
    
    @IBAction func toggleDrawer(_ sender: AnyObject) {
        print("Open Drawer")
        navigationDrawerController?.openLeftView()
    }
    
    //
    
    //
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}//

