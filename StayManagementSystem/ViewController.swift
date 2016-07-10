//
//  ViewController.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/07/10.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func stateTapped(sender: AnyObject) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //CSVファイル名を引数にしてloadCSVメソッドを使用し、CSVファイルを読み込む
        let csvArray = loadCSV("schedule")
        print(csvArray)
        
    }
    
    
    //CSVファイルの読み込みメソッド
    func loadCSV(fileName :String) -> [String]{
        
        //CSVファイルのデータを格納するためのString型配列を宣言
        var csvArray:[String] = []
        //CSVファイルのパスを設定
        let csvBundle = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")!
        
        do{
            //csvBundleからファイルを読み込み、エンコーディングしてcsvDataに格納
            let csvData = try String(contentsOfFile: csvBundle, encoding: NSUTF8StringEncoding)
            //改行コードが"\r"の場合は"\n"に置換する
            let lineChange = csvData.stringByReplacingOccurrencesOfString("\r", withString: "\n")
            //"\n"の改行コードで要素を切り分け、配列csvArrayに格納する
            csvArray = lineChange.componentsSeparatedByString("\n")
            
        }catch{
            print("Error!")
        }
        
        return csvArray     //戻り値の配列
    }



}

