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
    
    @IBAction func stateTapped(_ sender: AnyObject) {
    }
    
    @IBAction func documentTapped(_ sender: AnyObject) {
        //SegueをIdentifierで呼び出す
        performSegue(withIdentifier: "toDocumentView", sender: self)
    }
    
    @IBAction func backFromListView(_ segue:UIStoryboardSegue){
        NSLog("ViewController#backFromListView")
    }



}

