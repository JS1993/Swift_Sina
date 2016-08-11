//
//  HomeViewCell.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15

class HomeViewCell: UITableViewCell {

    @IBOutlet var contentTextWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var iconImageV: UIImageView!
    @IBOutlet var verifiedImageV: UIImageView!
    @IBOutlet var vipImageV: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var createAtLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var screenNameLabel: UILabel!
    
    var  viewModel : StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconImageV.sd_setImageWithURL(viewModel.profileImageUrl, placeholderImage: UIImage(named: "avatar_default"))
            verifiedImageV.image=viewModel.verifiedImage
            vipImageV.image=viewModel.mbrankImage
            screenNameLabel.text=viewModel.status?.user?.screen_name
            createAtLabel.text=viewModel.creatAtText
            sourceLabel.text=viewModel.sourceText
            contentLabel.text=viewModel.status?.text
            screenNameLabel.textColor = viewModel.mbrankImage == nil ? UIColor.blueColor() : UIColor.orangeColor()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextWidthConstraint.constant = UIScreen.mainScreen().bounds.height - 2*edgeMargin
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
