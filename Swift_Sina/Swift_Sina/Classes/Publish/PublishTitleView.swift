//
//  PublishTitleView.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SnapKit

class PublishTitleView: UIView {
    
    private lazy var titleLabel : UILabel = UILabel()
    private lazy var screenNameLabel : UILabel = UILabel()

    //MARK :-构造函数
   override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(Coder) : has not been implemented")
    }
    
    

}

// MARK: - 设置UI界面
extension PublishTitleView{
    private func setUpUI(){
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        screenNameLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp_centerX)
            make.top.equalTo(titleLabel.snp_bottom).offset(3)
        }
        titleLabel.font = UIFont.systemFontOfSize(16.0)
        screenNameLabel.font = UIFont.systemFontOfSize(14.0)
        screenNameLabel.textColor = UIColor.lightGrayColor()
        
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
}










