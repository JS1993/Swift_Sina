//
//  JSRightImageButton.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/8.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class JSRightImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //swift中规定，重写控件的init（frame）方法或，必须重写init?(coder aDecoder:NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame.origin.x=0
        imageView?.frame.origin.x=(titleLabel?.frame.size.width)!+8
        
    }

}
