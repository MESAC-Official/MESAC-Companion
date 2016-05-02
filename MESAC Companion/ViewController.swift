//
//  ViewController.swift
//  MESAC Companion
//
//  Created by Yajat on 3/28/16.
//  Copyright © 2016 American Community School of Abu DHabi. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    
    let ref = Firebase(url: "https://mesac-companion.firebase.io.com") 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var videoView: UIWebView!

}