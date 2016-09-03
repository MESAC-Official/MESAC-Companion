//
//  ViewController.swift
//  MESAC-Companion
//
//  Created by Philippos Slicher on 7/27/16.
//  Copyright © 2016 Philippos Slicher & Yajat Dua. All rights reserved.
//

import UIKit
import Firebase
import Material

class ViewController: UIViewController {//
    
    
    @IBAction func toLive(_ sender: AnyObject) {
    }

    @IBOutlet weak var testLabel: UILabel!
    //
    @IBAction func testButton(_ sender: AnyObject) {
        rootRef.child("test").setValue("Button")
    }
    
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
        
        //Refresh Test Button
        rootRef.child("test").observe(FIRDataEventType.value) {
            (snap: FIRDataSnapshot) in
            self.testLabel.text = (snap.value as AnyObject).description
        }
        testLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}//

