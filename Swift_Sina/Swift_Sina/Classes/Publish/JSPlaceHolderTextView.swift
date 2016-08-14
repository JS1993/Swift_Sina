//
//  JSPlaceHolderTextView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SnapKit

class JSPlaceHolderTextView: UITextView {
    
    lazy var placeHolderLabel : UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        setUpUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - 设置UI
extension JSPlaceHolderTextView{
    private func setUpUI() {
        
        addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(7)
        }
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        
        textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}












