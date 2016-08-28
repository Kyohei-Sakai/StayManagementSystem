//
//  GraphViewController.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/08/28.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    let size: CGSize = UIScreen.mainScreen().nativeBounds.size
//    let view = UIView(frame: CGRect(origin: CGPointZero, size: size))
//    view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
    
    func drawLine(from: CGPoint, to: CGPoint) {
        let linePath = UIBezierPath()
        linePath.moveToPoint(from)
        linePath.addLineToPoint(to)
        linePath.lineWidth = 0.5
        UIColor.grayColor().setStroke()
        linePath.stroke()
    }
    
    func drawBar(from: CGPoint, to: CGPoint, width: CGFloat) {
        let BarPath = UIBezierPath()
        BarPath.moveToPoint(from)
        BarPath.addLineToPoint(to)
        BarPath.lineWidth = width
        UIColor.blueColor().setStroke()
        BarPath.stroke()
    }
    
    var dataArray: [(start: CGFloat, time: CGFloat)] = [
        (2, 4), (1, 3), (0, 5), (2, 8), (4, 15), (0, 10), (3.5, 7.7)
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CoreGraphicsで描画する
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        
        // 軸となる線
        let axisline = UIBezierPath()
        let yMargin: CGFloat = 100  // 上の余白幅
        axisline.moveToPoint(CGPointMake(yMargin, 0))
        axisline.addLineToPoint(CGPointMake(yMargin, size.height))
        UIColor.grayColor().setStroke()
        axisline.lineWidth = 2
        axisline.stroke()
        
        // 仕切り線
        let partitionline = UIBezierPath()
        let xMargin: CGFloat = 100  // 左の余白幅
        partitionline.moveToPoint(CGPointMake(0, xMargin))
        partitionline.addLineToPoint(CGPointMake(size.width, xMargin))
        UIColor.grayColor().setStroke()
        partitionline.lineWidth = 2
        partitionline.stroke()
        
        // 目盛り線
        let lineNum: Int = 12   // 目盛りの本数
        for i in 1...lineNum {
            let xToEnd = size.width
            // 目盛りの幅
            let yScaleInterval = (size.height - yMargin) / CGFloat(lineNum + 1)
            // 目盛りのY座標を求める
            let yScalePoint = yMargin + yScaleInterval * CGFloat(i)
            
            drawLine(CGPoint(x: xMargin, y: yScalePoint), to: CGPoint(x: xToEnd, y: yScalePoint))
        }
        
        // グラフ
        let BarNum: Int = dataArray.count
        for i in 1...BarNum {
            // グラフの間隔
            let xScaleInterval = (size.width - xMargin) / CGFloat(BarNum + 1)
            // グラフのX座標を求める
            let xScalePoint = xMargin + xScaleInterval * CGFloat(i)
            let barWidth = (xScaleInterval / CGFloat(5) * CGFloat(2)) * CGFloat(2)
            //グラフの始点と終点
            let yScaleInterval = (size.height - yMargin) / CGFloat(lineNum + 1)
            let yFromPoint = yMargin + yScaleInterval * dataArray[i - 1].start
            let yToPoint = yFromPoint + yScaleInterval * dataArray[i - 1].time
            
            drawBar(CGPoint(x: xScalePoint, y: yFromPoint), to: CGPoint(x: xScalePoint, y: yToPoint), width: barWidth)
        }
        
        
        // viewのlayerに描画したものをセットする
        view.layer.contents = UIGraphicsGetImageFromCurrentImageContext().CGImage
        
        UIGraphicsEndImageContext()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}