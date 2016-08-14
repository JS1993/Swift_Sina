//
//  PicPickerCell.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class PicPickerCell: UICollectionViewCell {

    var image : UIImage? {
        didSet{
            if image != nil {
                imageV.image = image
                deletePhotoClick.hidden = false
                imageBtn.userInteractionEnabled = false
            }else{
                imageV.image = nil
                deletePhotoClick.hidden = true
                imageBtn.userInteractionEnabled = true
            }
        }
    }
    
    @IBOutlet var imageV: UIImageView!
    
    @IBOutlet var deletePhotoClick: UIButton!
    @IBOutlet var imageBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func addPhotoClick(sender: UIButton) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("PicPickerNoti", object: nil)
        
    }
    @IBAction func deletePhotoAction(sender: UIButton) {
        NSNotificationCenter.defaultCenter().postNotificationName("PicPickerNotiDelete", object: imageV.image)
    }
}
