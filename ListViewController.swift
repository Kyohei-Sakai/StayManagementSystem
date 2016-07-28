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
    
    var ary:[String] = []
    var csvArray:[String] = []
    var ary2: [(name: String, grade: String, inTime: String, outTime: String)] = [
        ("田中","M2","12:00","15:00"),
        ("木下","M2","8:00","12:00"),
        ("松下","M2","12:00","15:00"),
        ("園部","M1","12:00","17:00"),
        ("北沢","B4","12:00","18:00"),
        ("武藤","B4","13:00","19:00"),
    ]
    
    
    // セクション名
    let sections = ["刀剣男士一覧"]
    
    // 刀剣男士名
    let texts: [(rare: Int, name: String, yomi :String, height :Int)] = [
        (5,"三日月宗近","みかづきむねちか",180),
        (3,"小狐丸","こぎつねまる",188),
        (3,"石切丸","いしきりまる",189),
        (3,"岩融","いわとおし",203),
        (1,"今剣","いまのつるぎ",123),
        (2,"にっかり青江","にっかりあおえ",167),
        (2,"鳴狐","なきぎつね",164),
        (4,"一期一振","いちごひとふり",177),
        (2,"鯰尾藤四郎","なまずおとうしろう",158),
        (2,"骨喰藤四郎","ほねばみとうしろう",159),
        (1,"平野藤四郎","ひらのとうしろう",132),
        (1,"厚藤四郎","あつしとうしろう",154),
        (1,"前田藤四郎","まえだとうしろう",130),
        (1,"秋田藤四郎","あきたとうしろう",123),
        (1,"博多藤四郎","はかたとうしろう",0),
        (1,"乱藤四郎","みだれとうしろう",145),
        (1,"五虎退","ごこたい",135),
        (1,"薬研藤四郎","やげんとうしろう",153),
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //CSVファイル名を引数にしてloadCSVメソッドを使用し、CSVファイルを読み込む
        csvArray = loadCSV("schedule")
        print(csvArray)
        print(csvArray.count)
        
        //csvArrayの任意の行を取り出し、カンマを区切りとしてaryに格納
        ary = csvArray[1].componentsSeparatedByString(",")
        
        
        //delegateとdataSourceを設定
        staytableview.delegate = self
        staytableview.dataSource = self
        
    }
    
    //テーブルビューのセルの数をcsvArrayの要素数に設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ary2.count
        
    }
    
    //セルに表示する内容を設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath  indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomTableViewCell
        
        //cell.textLabel?.text = ary2[indexPath.row].name
        
        switch (ary2[indexPath.row].grade)
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
        
        cell.setCell(nameText: ary2[indexPath.row].name, gradeText: ary2[indexPath.row].grade, inTimeText: ary2[indexPath.row].inTime, outTimeText: ary2[indexPath.row].outTime)
        
        
        
        /*
        // StoryBoardで取得したCellを取得
        let cell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        // タイトルとタイトルの行数、公開日時をCellにセット
        cell.textLabel!.text = ary[0]
        //cell.textLabel!.numberOfLines = 3
        //cell.detailTextLabel!.text = newsDic["publishedDate"] as? String
        */
        
        return cell
        
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
    
    
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}
