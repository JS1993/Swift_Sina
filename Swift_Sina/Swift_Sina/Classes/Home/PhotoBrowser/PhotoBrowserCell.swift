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
            
           setUpContent(picURL)
        }
    }
    private lazy var progressView : JSProgressView = JSProgressView()
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
        contentView.addSubview(progressView)
        scrollView.addSubview(imageV)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.mainScreen().bounds.width*0.5, y: UIScreen.mainScreen().bounds.height*0.5)
        progressView.hidden = true
        progressView.backgroundColor = UIColor.clearColor()
        
        scrollView.frame = contentView.bounds
        scrollView.frame.size.width -= 20
    }
}

// MARK: - 设置内容
extension PhotoBrowserCell{
 
    private func setUpContent(url:NSURL){
        //取出image对象
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(url.absoluteString)
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
        
        imageV.sd_setImageWithURL(getBigUrl(url), placeholderImage: image, options: [], progress: { (current, total) in
            
            self.progressView.hidden = false
            
            self.progressView.progress = CGFloat(current)/CGFloat(total)
            }) { (_, _, _, _) in
             self.progressView.hidden = true
        }
        
        scrollView.contentSize = CGSize(width: 0, height: hight)
        
    }
    
    private func getBigUrl(url:NSURL) ->NSURL {
        
        return NSURL(string: url.absoluteString.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle"))!
    }
}



















