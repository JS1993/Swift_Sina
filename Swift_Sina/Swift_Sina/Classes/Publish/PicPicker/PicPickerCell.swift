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
                imageBtn.setBackgroundImage(image, forState: .Normal)
                deletePhotoClick.hidden = false
                imageBtn.userInteractionEnabled = false
            }else{
                imageBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: .Normal)
                deletePhotoClick.hidden = true
                imageBtn.userInteractionEnabled = true
            }
        }
    }
    
    
    @IBOutlet var deletePhotoClick: UIButton!
    @IBOutlet var imageBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func addPhotoClick(sender: UIButton) {
        
        NSNotificationCenter.defaultCenter().postNotificationName("PicPickerNoti", object: nil)
        
    }
    @IBAction func deletePhotoAction(sender: UIButton) {
    }
}
