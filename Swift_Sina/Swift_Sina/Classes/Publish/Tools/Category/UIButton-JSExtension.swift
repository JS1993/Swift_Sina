//
//  UIButton-JSExtension.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/8.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func creatButton(imageName:String,bgImageName:String)->UIButton{
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName+"_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: bgImageName+"_highlighted"), forState: .Highlighted)
        return btn
        
    }
    
    //便利构造函数,注意，必须调用self.init()
    convenience init(imageName:String,bgImageName:String) {
       self.init()
        setImage(UIImage(named: imageName), forState: .Normal)
        setImage(UIImage(named: imageName+"_highlighted"), forState: .Highlighted)
        setBackgroundImage(UIImage(named: bgImageName), forState: .Normal)
        setBackgroundImage(UIImage(named: bgImageName+"_highlighted"), forState: .Highlighted)
    }
}
