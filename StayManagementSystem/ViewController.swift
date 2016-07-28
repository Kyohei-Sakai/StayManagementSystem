//
//  ViewController.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/07/10.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func stateTapped(sender: AnyObject) {
    }
    
    @IBAction func documentTapped(sender: AnyObject) {
        //SegueをIdentifierで呼び出す
        performSegueWithIdentifier("toDocumentView", sender: self)
    }
    
    @IBAction func backFromListView(segue:UIStoryboardSegue){
        NSLog("ViewController#backFromListView")
    }



}

