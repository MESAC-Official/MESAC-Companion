//
//  ViewController.swift
//  MESAC-Companion
//
//  Created by Philippos Slicher on 5/29/16.
//  Copyright © 2016 YDPS. All rights reserved.
//

import UIKit
import SwiftPaginator

class ViewController: UIViewController {
    
    var stringPaginator: Paginator<String>?
    
    let source = [["one", "two"], ["three", "four"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

