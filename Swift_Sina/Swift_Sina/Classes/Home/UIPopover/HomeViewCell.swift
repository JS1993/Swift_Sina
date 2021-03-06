//
//  HomeViewCell.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage
import HYLabel

private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

class HomeViewCell: UITableViewCell {

    @IBOutlet var contentTextWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var contentLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet var pictureHeightConstraint: NSLayoutConstraint!
    @IBOutlet var pictureViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var pictureViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var iconImageV: UIImageView!
    @IBOutlet var verifiedImageV: UIImageView!
    @IBOutlet var vipImageV: UIImageView!
    @IBOutlet var contentLabel: HYLabel!
    @IBOutlet var createAtLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var screenNameLabel: UILabel!
    @IBOutlet var pictureCollectionView: PictureCollectionView!
    @IBOutlet var reweetedContentLabel: HYLabel!
    @IBOutlet var bgView: UIView!
    var  viewModel : StatusViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            iconImageV.sd_setImageWithURL(viewModel.profileImageUrl, placeholderImage: UIImage(named: "avatar_default"))
            verifiedImageV.image=viewModel.verifiedImage
            vipImageV.image=viewModel.mbrankImage
            screenNameLabel.text=viewModel.status?.user?.screen_name
            let screenName = viewModel.status?.user?.screen_name
            if screenName == "苏_JS" {
                sourceLabel.text="来自 iPhone 7 Plus"
            }else{
                sourceLabel.text=viewModel.sourceText
            }
            createAtLabel.text=viewModel.creatAtText
            contentLabel.attributedText = FindEmoticon.shareIntance.findAttrString(viewModel.status?.text, font: contentLabel.font)
            screenNameLabel.textColor = viewModel.mbrankImage == nil ? UIColor.blueColor() : UIColor.orangeColor()
            //计算pictureView约束
            let pictureViewSize = calclulatePicViewSize(viewModel.picUrls.count)
            pictureHeightConstraint.constant=pictureViewSize.height
            pictureViewWidthConstraint.constant=pictureViewSize.width
            pictureCollectionView.picUrls=viewModel.picUrls
            //设置转发微博的正文
            if viewModel.status?.retweeted_status != nil {
                if let screen_name = viewModel.status?.retweeted_status?.user?.screen_name,
                    let reweetedText = viewModel.status?.retweeted_status?.text{
                    reweetedContentLabel.attributedText = FindEmoticon.shareIntance.findAttrString("@"+"\(screen_name) : "+reweetedText, font: reweetedContentLabel.font)
                    bgView.hidden=false;
                    contentLabelTopConstraint.constant = 15
                }
            }else{
                reweetedContentLabel.text = "";
                bgView.hidden=true;
                contentLabelTopConstraint.constant = 0
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextWidthConstraint.constant = UIScreen.mainScreen().bounds.width - 2*edgeMargin
        contentLabel.matchTextColor = UIColor .blueColor()
        reweetedContentLabel.matchTextColor = UIColor.blueColor()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - 计算方法
extension HomeViewCell{
    //1.没有配图；2.单张配图；3.四张配图：田字格；4.其他张配图：rows=(count - 1)/3+1 ; height=rows*rowHeight
    private func calclulatePicViewSize(count : Int )->CGSize{
        
        //1.没有配图
        if count==0 {
            pictureViewBottomConstraint.constant=0
            return CGSizeZero
        }
        pictureViewBottomConstraint.constant=10
        
        let layout = pictureCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //2.一张图片需要下载之后再加载大小
        if count==1 {
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(viewModel?.picUrls.last?.absoluteString)
            layout.itemSize = CGSize(width: image.size.width*2, height: image.size.height*2)
            return CGSize(width: image.size.width*2, height: image.size.height*2)
        }
        
        //4张图片
        let imageVWH = (UIScreen.mainScreen().bounds.width - 2*(edgeMargin+itemMargin))/3
        layout.itemSize = CGSize(width: imageVWH, height: imageVWH)
        if count==4 {
            let picViewWH = imageVWH*2+itemMargin + 1
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        //其他张配图
        let rows = CGFloat((count - 1)/3 + 1)
        let picHeight = rows * imageVWH + (rows - 1) * itemMargin
        let picWidth = UIScreen.mainScreen().bounds.width - 2*edgeMargin
        return CGSize(width: picWidth, height: picHeight)
        
    }
}























