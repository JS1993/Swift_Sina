//
//  UIBarButtonItem-JSExtension.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/8.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(imageName:String) {
        self.init()
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), forState: .Highlighted)
        btn.sizeToFit()
        
        self.customView=btn
    }
    
}
