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
        dataSource=self
        
    }


}

extension PictureCollectionView : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pictureCell", forIndexPath: indexPath) as! PicCollectionViewCell
        cell.imageV.sd_setImageWithURL(picUrls[indexPath.row])
        return cell
    }
    
}

class PicCollectionViewCell: UICollectionViewCell {
       @IBOutlet var imageV: UIImageView!
}











