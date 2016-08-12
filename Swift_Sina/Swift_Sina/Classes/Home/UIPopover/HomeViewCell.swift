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
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {

    @IBOutlet var contentTextWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var pictureHeightConstraint: NSLayoutConstraint!
    @IBOutlet var pictureViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var iconImageV: UIImageView!
    @IBOutlet var verifiedImageV: UIImageView!
    @IBOutlet var vipImageV: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var createAtLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var screenNameLabel: UILabel!
    @IBOutlet var pictureCollectionView: PictureCollectionView!
    
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
            //计算pictureView约束
            let pictureViewSize = calclulatePicViewSize(viewModel.picUrls.count)
            pictureHeightConstraint.constant=pictureViewSize.height
            pictureViewWidthConstraint.constant=pictureViewSize.width
            pictureCollectionView.picUrls=viewModel.picUrls
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextWidthConstraint.constant = UIScreen.mainScreen().bounds.width - 2*edgeMargin
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageVWH = (UIScreen.mainScreen().bounds.width - 2*(edgeMargin+itemMargin))/3
        layout.itemSize = CGSize(width: imageVWH, height: imageVWH)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - 计算方法
extension HomeViewCell{
    //1.没有配图；2.单张配图；3.四张配图：田字格；4.其他张配图：rows=(count - 1)/3+1 ; height=rows*rowHeight
    private func calclulatePicViewSize(count : Int )->CGSize{
        
        if count==0 {
            return CGSizeZero
        }
        
        let imageVWH = (UIScreen.mainScreen().bounds.width - 2*(edgeMargin+itemMargin))/3
        if count==4 {
            let picViewWH = imageVWH*2+itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        let rows = CGFloat((count - 1)/3 + 1)
        let picHeight = rows * imageVWH + (rows - 1) * itemMargin
        let picWidth = UIScreen.mainScreen().bounds.width - 2*edgeMargin
        return CGSize(width: picWidth, height: picHeight)
        
    }
}























