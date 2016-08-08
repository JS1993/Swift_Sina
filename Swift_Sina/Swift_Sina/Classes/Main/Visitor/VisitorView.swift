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
    
}
