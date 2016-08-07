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

class ViewController: UIViewController, GIDSignInUIDelegate {//
    
    

    @IBOutlet weak var testLabel: UILabel!
    //
    @IBAction func testButton(_ sender: AnyObject) {
        rootRef.child("test").setValue("Button")
    }
    
    @IBAction func goToLive(_ sender: AnyObject) {
        
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
        
        //Google Sign In Delegate Requirements
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //Refresh Test Button
        rootRef.child("test").observe(FIRDataEventType.value) {
            (snap: FIRDataSnapshot) in
            self.testLabel.text = snap.value?.description
        }
        testLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}//

