//
//  PhotoBrowserCell.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/19.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserCell: UICollectionViewCell {
    
    var picURL : NSURL? {
        didSet{
            guard let picURL = picURL else{
                return
            }
            
            //取出image对象
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
            //计算imageV的frame
            let x :CGFloat = 0
            let width = UIScreen.mainScreen().bounds.width
            let hight = width/image.size.width*image.size.height
            var y :CGFloat = 0
            if hight>UIScreen.mainScreen().bounds.height {
                y = 0
            }else{
                y = (UIScreen.mainScreen().bounds.height - hight)*0.5
            }
            imageV.frame = CGRect(x: x, y: y, width: width, height: hight)
            //设置图片
            imageV.image = image
            
        }
    }
    
    private lazy var scrollView : UIScrollView =  UIScrollView()
    private lazy var imageV : UIImageView = UIImageView()
    
    //MARK :-构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(Coder) : has not been implemented")
    }

}

// MARK: - 设置控件内容
extension PhotoBrowserCell{
    private func setUpUI(){
       contentView.addSubview(scrollView)
        scrollView.addSubview(imageV)
        scrollView.frame = contentView.bounds
    }
}





















