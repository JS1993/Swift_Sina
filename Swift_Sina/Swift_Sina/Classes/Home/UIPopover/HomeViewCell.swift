//
//  HomeViewCell.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

private let edgeMargin : CGFloat = 15

class HomeViewCell: UITableViewCell {

    @IBOutlet var contentTextWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextWidthConstraint.constant = UIScreen.mainScreen().bounds.height - 2*edgeMargin
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
