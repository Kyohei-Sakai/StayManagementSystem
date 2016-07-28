//
//  CustomTableViewCell.swift
//  StayManagementSystem
//
//  Created by 酒井恭平 on 2016/07/23.
//  Copyright © 2016年 酒井恭平. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var inTimeLabel: UILabel!
    @IBOutlet weak var outTimeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //表示内容を設定する
    func setCell(nameText: String, gradeText: String, inTimeText: String, outTimeText: String) {
        
        nameLabel.text = nameText
        gradeLabel.text = gradeText
        inTimeLabel.text = inTimeText
        outTimeLabel.text = outTimeText
        
    }

}
