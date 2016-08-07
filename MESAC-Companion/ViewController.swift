//
//  ViewController.swift
//  MESAC-Companion
//
//  Created by Philippos Slicher on 7/27/16.
//  Copyright © 2016 Philippos Slicher & Yajat Dua. All rights reserved.
//

import UIKit
import Material

class ViewController: UIViewController {
    
    @IBAction func toggleDrawer(_ sender: AnyObject) {
        print("Open Drawer")
        navigationDrawerController?.openLeftView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

