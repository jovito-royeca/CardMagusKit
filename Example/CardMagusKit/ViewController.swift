//
//  ViewController.swift
//  CardMagusKit
//
//  Created by jovito-royeca on 04/11/2017.
//  Copyright (c) 2017 jovito-royeca. All rights reserved.
//

import UIKit
import CardMagusKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DatabaseMaintainer.sharedInstance.json2CoreData()
        DatabaseMaintainer.sharedInstance.updateDatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

