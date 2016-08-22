//
//  PictureCollectionView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/12.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage

class PictureCollectionView: UICollectionView {
    
    var picUrls : [NSURL] = [NSURL](){
        didSet{
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dataSource = self
        delegate = self
    }


}

extension PictureCollectionView : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pictureCell", forIndexPath: indexPath) as! PicCollectionViewCell
        cell.picURL=picUrls[indexPath.row]
        return cell
    }
    
}

extension PictureCollectionView : UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let userInfo = ["indexPath" : indexPath , "picUrls" : picUrls]
        NSNotificationCenter.defaultCenter().postNotificationName(ShowPhotoBrowserNote, object: self, userInfo: userInfo)
        
    }
}

extension PictureCollectionView : AnimatorPresentedDelegate{
    
    func startRect(indexPath: NSIndexPath) -> CGRect {
        let cell = self.cellForItemAtIndexPath(indexPath)!
        let startFrame = self.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        return startFrame
    }
    
    func endRect(indexPath: NSIndexPath) -> CGRect {
        let picURL = picUrls[indexPath.item]
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
        let width = UIScreen.mainScreen().bounds.width
        let height = width / image.size.width * image.size.height
        var y : CGFloat = 0
        
        if height > UIScreen.mainScreen().bounds.width {
            y = 0
        }else{
            y = (UIScreen.mainScreen().bounds.height - height)*0.5
        }
        return CGRect(x: 0, y: y, width: width, height: height)
    }
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        let imageView = UIImageView()
        let picURL = picUrls[indexPath.item]
        let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(picURL.absoluteString)
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

class PicCollectionViewCell: UICollectionViewCell {
    
    var picURL : NSURL?{
        didSet{
            guard let picUrlx = picURL else {
                return
            }
            
            imageV.sd_setImageWithURL(picUrlx, placeholderImage: UIImage(named: "empty_picture"), completed: nil)
        }
    }
       @IBOutlet var imageV: UIImageView!
}











