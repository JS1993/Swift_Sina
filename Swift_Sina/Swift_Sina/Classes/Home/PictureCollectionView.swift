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
        NSNotificationCenter.defaultCenter().postNotificationName(ShowPhotoBrowserNote, object: nil, userInfo: userInfo)
        
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











