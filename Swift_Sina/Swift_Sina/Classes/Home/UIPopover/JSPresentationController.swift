//
//  JSPresentationController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/10.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class JSPresentationController: UIPresentationController {
    
    var presentFrame :CGRect = CGRectZero

    private lazy var coverView: UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView()?.frame=presentFrame
        
        setUpCoverView()
        
    }
}

// MARK: - 设置蒙版
extension JSPresentationController{
    
    private func setUpCoverView(){
        
       containerView?.insertSubview(coverView, atIndex: 0)
        
        coverView.backgroundColor=UIColor(white: 0.8, alpha: 0.8)
        coverView.frame=containerView!.bounds
        
        let tapGes = UITapGestureRecognizer(target:self,action: #selector(JSPresentationController.coverClick) )
        coverView.addGestureRecognizer(tapGes)
        
    }
}

// MARK: - 监听蒙版点击事件
extension JSPresentationController{
    
    @objc private func coverClick()  {
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}