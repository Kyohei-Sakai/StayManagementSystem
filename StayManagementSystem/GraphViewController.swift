//
//  GraphViewController.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/08/28.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    let size: CGSize = UIScreen.main.bounds.size
//    let view = UIView(frame: CGRect(origin: CGPointZero, size: size))
//    view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
    
    var scrollView: UIScrollView = UIScrollView()
    
    
    var dataArray: [(name: String, start: CGFloat, time: CGFloat)] = [
        ("H", 2, 4), ("M", 1, 3), ("T", 0, 5), ("R", 2, 8), ("A", 4, 15),
        ("S", 0, 10), ("Y", 3.5, 7.7), ("H", 2, 4), ("M", 1, 3), ("T", 0, 5), ("R", 2, 8), ("A", 4, 15),
        ]
    
    let xMargin: CGFloat = 50  // 左の余白幅
    let yMargin: CGFloat = 50  // 上の余白幅
    let xScaleInterval: CGFloat = 60 // グラフ表示部分の幅
    let yScaleInterval: CGFloat = 50    // 目盛りの幅
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        scrollView.backgroundColor = UIColor.white
        print(size)
        
        // 十分な描画領域を確保
        let canvasSize = CGSize(width: size.width * 3, height: size.height * 3)
        
        let line: Line = Line(dataArray: dataArray)
        line.frame = CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height)
        line.backgroundColor = UIColor.clear
        scrollView.addSubview(line)
        
        let bar: Bar = Bar(dataArray: dataArray)
        bar.frame = CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height)
        bar.backgroundColor = UIColor.clear
        scrollView.addSubview(bar)
        
        scrollView.contentSize = CGSize(width: line.xLength, height: line.yLength)
        print(scrollView.contentSize)
        view.addSubview(scrollView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class Line: UIView {
        var xLength: CGFloat = 0.0
        var yLength: CGFloat = 0.0
        var xMargin: CGFloat = 50
        var yMargin: CGFloat = 50
        let xScaleInterval: CGFloat = 60 // グラフ表示部分の幅
        let yScaleInterval: CGFloat = 50    // 目盛りの幅
        var dataArray: [(name: String, start: CGFloat, time: CGFloat)] = []
        
        convenience init (dataArray: [(name: String, start: CGFloat, time: CGFloat)]) {
            self.init()
            self.dataArray = dataArray
            
            // Barを表示するための領域の高さを求める
            var maxTime = [CGFloat]()
            for i in 0..<dataArray.count {
                maxTime.append(dataArray[i].start + dataArray[i].time)
            }
            
            self.yLength = yMargin + yScaleInterval * maxTime.max()!
            self.xLength = xMargin + xScaleInterval * CGFloat(dataArray.count)
        }
        
        
        override func draw(_ rect: CGRect) {
            // 仕切り線（縦）
            drawLine(CGPoint(x: yMargin, y: 0), to: CGPoint(x: yMargin, y: yLength), width: 2)
            // 仕切り線（横）
            drawLine(CGPoint(x: 0, y: yMargin), to: CGPoint(x: xLength, y: yMargin), width: 2)
            
            
            // 目盛り線の本数を求める(floor →小数点以下切り捨て)
            let lineNum: Int = Int(floor((yLength - yMargin) / yScaleInterval))
            
            let startTime: Int = 0 // "startTime":00
            
            for i in 1...lineNum {
                // 目盛りのY座標を求める
                let yScalePoint = yMargin + yScaleInterval * CGFloat(i)
                
                drawLine(CGPoint(x: xMargin, y: yScalePoint), to: CGPoint(x: xLength, y: yScalePoint), width: 0.5)
                
                // 目盛り線にラベルをつける
                drawString("\(Int(startTime) + i)" + ":00", fontSize: 10.0, drawPoint: CGPoint(x: xMargin - 35, y: yScalePoint - 5))
            }
            
        }
        
        func drawLine(_ from: CGPoint, to: CGPoint, width: CGFloat) {
            let linePath = UIBezierPath()
            linePath.move(to: from)
            linePath.addLine(to: to)
            linePath.lineWidth = width
            UIColor.gray.setStroke()
            linePath.stroke()
        }
        
        // 文字列を描画
        func drawString(_ word: String, fontSize: CGFloat, drawPoint: CGPoint){
            let attrString = NSAttributedString(
                string: word,
                attributes:[NSForegroundColorAttributeName: UIColor.black,
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize)])
            attrString.draw(at: drawPoint)
        }
        
    }
    
    
    class Bar: UIView {
        
        let barWidth: CGFloat = 40  // Barの幅を設定
        var xLength: CGFloat = 0.0
        var yLength: CGFloat = 0.0
        var xMargin: CGFloat = 50
        var yMargin: CGFloat = 50
        let xScaleInterval: CGFloat = 60 // グラフ表示部分の幅
        let yScaleInterval: CGFloat = 50    // 目盛りの幅
        var dataArray: [(name: String, start: CGFloat, time: CGFloat)] = []
        
        convenience init (dataArray: [(name: String, start: CGFloat, time: CGFloat)]) {
            self.init()
            self.dataArray = dataArray
        }
        
        override func draw(_ rect: CGRect) {
            
            let BarNum: Int = dataArray.count
            
            for i in 1...BarNum {
                // グラフのX座標を求める
                let xScalePoint = xMargin + (xScaleInterval * CGFloat(i)) - (xScaleInterval / 2)
                //グラフの始点と終点
                let yFromPoint = yMargin + yScaleInterval * dataArray[i - 1].start
                let yToPoint = yFromPoint + yScaleInterval * dataArray[i - 1].time
                
                drawBar(CGPoint(x: xScalePoint, y: yFromPoint), to: CGPoint(x: xScalePoint, y: yToPoint), width: barWidth)
                
                // グラフに名前をつける
                drawString(dataArray[i - 1].name, fontSize: 25.0, drawPoint: CGPoint(x: xScalePoint - barWidth / 2, y: 15))
            }
            
        }
        
        func drawBar(_ from: CGPoint, to: CGPoint, width: CGFloat) {
            let BarPath = UIBezierPath()
            BarPath.move(to: from)
            BarPath.addLine(to: to)
            BarPath.lineWidth = width
            UIColor.blue.setStroke()
            BarPath.stroke()
        }
        
        // 文字列を描画
        func drawString(_ word: String, fontSize: CGFloat, drawPoint: CGPoint){
            let attrString = NSAttributedString(
                string: word,
                attributes:[NSForegroundColorAttributeName: UIColor.black,
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize)])
            attrString.draw(at: drawPoint)
        }
        
    }

}
