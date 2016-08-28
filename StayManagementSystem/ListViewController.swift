//
//  ListViewController.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/07/16.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var staytableview: UITableView!
    
    //var dic:[[name: String, grade: String, inTime: String, outTime: String]] = [][:]
    var csvArray:[String] = []
    var dic2: [(name: String, grade: String, inTime: String, outTime: String)] = [
        ("田中","M2","12:00","15:00"),
        ("木下","M2","8:00","12:00"),
        ("松下","M2","12:00","15:00"),
        ("園部","M1","12:00","17:00"),
        ("北沢","B4","12:00","18:00"),
        ("武藤","B4","13:00","19:00"),
        ]
    var dic3: [(name: String, grade: String, inTime: String, outTime: String)] = [
        ("藤田","M2","12:00","15:00"),
        ("斎藤","M2","8:00","12:00"),
        ("小川","M2","12:00","15:00"),
        ("木村","M1","12:00","17:00"),
        ("小野","B4","12:00","18:00"),
        ("岩尾","B4","13:00","19:00"),
        ]
    var dic4: [(name: String, grade: String, inTime: String, outTime: String)] = [
        ("Jody","M2","12:00","15:00"),
        ("Mac","M2","8:00","12:00"),
        ("Rumer","M2","12:00","15:00"),
        ("Sue","M1","12:00","17:00"),
        ("Ahn","B4","12:00","18:00"),
        ("Wowow","B4","13:00","19:00"),
        ]
    
    // Sectionで使用する配列を定義する.
    private let mySections: NSArray = ["在室", "予定", "退室"]
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //CSVファイル名を引数にしてloadCSVメソッドを使用し、CSVファイルを読み込む
        csvArray = loadCSV("schedule2")
        print(csvArray)
        print(csvArray.count)
        
        //csvArrayの任意の行を取り出し、カンマを区切りとしてaryに格納
        //dic = csvArray[1].componentsSeparatedByString(",")  //今のところいらない
        
        
        
        
        //delegateとdataSourceを設定
        staytableview.delegate = self
        staytableview.dataSource = self
        
    }
    
    //セクションの数を設定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return mySections.count
        
    }
    
    //セクションのタイトルを設定
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return mySections[section] as? String
        
    }
    
    
    //テーブルビューのセルの数をcsvArrayの要素数に設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dic2.count
        } else if section == 1 {
            return dic3.count
        } else if section == 2 {
            return dic4.count
        } else {
            return 0
        }
        
    }
    
    
    //セルに表示する内容を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath  indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCell
        
        //cell.nameLabel.text = dic2[indexPath.row].name
        //cell.gradeLabel.text = dic2[indexPath.row].grade
        //cell.inTimeLabel.text = dic2[indexPath.row].inTime
        //cell.outTimeLabel.text = dic2[indexPath.row].outTime
        
        if indexPath.section == 0 {
            
            //上の４行を１つのメソッドにまとめたもの
            cell.setCell(dic2[indexPath.row].name, gradeText: dic2[indexPath.row].grade, inTimeText: dic2[indexPath.row].inTime, outTimeText: dic2[indexPath.row].outTime)
            
        } else if indexPath.section == 1 {
            cell.setCell(dic3[indexPath.row].name, gradeText: dic3[indexPath.row].grade, inTimeText: dic3[indexPath.row].inTime, outTimeText: dic3[indexPath.row].outTime)
        } else if indexPath.section == 2 {
            cell.setCell(dic4[indexPath.row].name, gradeText: dic4[indexPath.row].grade, inTimeText: dic4[indexPath.row].inTime, outTimeText: dic4[indexPath.row].outTime)
        }
        
        

        /*
        switch (dic2[indexPath.row].grade)
        {
        case "M2":
            cell.backgroundColor = UIColor.redColor();
            break
        case "M1":
            cell.backgroundColor = UIColor.blueColor();
            break
        case "B4":
            cell.backgroundColor = UIColor.greenColor();
            break
        default:
            break
        }
        */
        
        return cell
        
    }
    
    
    
    //CSVファイルの読み込みメソッド
    func loadCSV(fileName :String) -> [String]{
        
        //CSVファイルのデータを格納するためのString型配列を宣言
        var csvArray:[String] = []
        
        do {
            //CSVファイルのパスを取得する。
            let csvPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv")
            
            //CSVファイルのデータを取得する。
            let csvData = try String(contentsOfFile:csvPath!, encoding:NSUTF8StringEncoding)
            
            //改行区切りでデータを分割して配列に格納する。
            csvArray = csvData.componentsSeparatedByString("\n")
            
            print(csvArray)
            
        } catch {
            print(error)
        }
        
        return csvArray     //戻り値の配列
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}
