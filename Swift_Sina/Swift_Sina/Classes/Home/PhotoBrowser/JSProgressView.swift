//
//  JSProgressView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/22.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class JSProgressView: UIView {

    //Mark :- 属性
    
    var progress : CGFloat = 0 {
        didSet{
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let center = CGPoint(x: rect.width*0.5, y: rect.height*0.5)
        let radius = rect.width*0.5-4
        let startAngle = CGFloat(-M_PI*0.5)
        let endAngle = CGFloat(2 * M_PI ) * progress + startAngle
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.addLineToPoint(center)
        path.closePath()
        
        UIColor(white: 1.0, alpha: 0.4).setFill()
        
        path.fill()
    }


}
