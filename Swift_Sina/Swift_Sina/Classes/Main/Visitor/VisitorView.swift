//
//  VisitorView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/8.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    class func createVisitorView()->VisitorView{
        
        return NSBundle.mainBundle().loadNibNamed("VisitorView", owner: nil, options: nil).first as! VisitorView
        
    }
    
    //MARK: -控件属性
    @IBOutlet var rotationView: UIImageView!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var tipLabel: UILabel!
    
    //MARK: -设置属性
    func setUpVisitorViewInfo(iconName:String,title:String)  {
        rotationView.hidden=true
        iconView.image=UIImage(named: iconName)
        tipLabel.text=title
    }
    
    //MARK: -设置动画
    func addAnimation() {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue=0
        rotationAnimation.toValue=M_PI*2
        rotationAnimation.repeatCount=MAXFLOAT
        rotationAnimation.duration=5.0
        rotationAnimation.removedOnCompletion=false
        
        rotationView.layer.addAnimation(rotationAnimation, forKey: nil)
    }
    
}
