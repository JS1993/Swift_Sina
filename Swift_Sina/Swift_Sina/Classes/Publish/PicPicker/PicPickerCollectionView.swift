//
//  PicPickerCollectionView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

private let picPickerCellID = "picPickerCellID"
private let margin : CGFloat = 10

class PicPickerCollectionView: UICollectionView {
    
    var images : [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        registerNib(UINib(nibName: "PicPickerCell",bundle: nil), forCellWithReuseIdentifier: picPickerCellID)
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.mainScreen().bounds.width-4*margin)/3
        layout.itemSize = CGSize(width:itemWH, height: itemWH)
        
        contentInset = UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
        
    }
    
    
    

}

extension PicPickerCollectionView : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(picPickerCellID, forIndexPath: indexPath) as! PicPickerCell
        
        cell.image = indexPath.item <= images.count-1 ? images[indexPath.item] : nil
        
        return cell
    }
}













