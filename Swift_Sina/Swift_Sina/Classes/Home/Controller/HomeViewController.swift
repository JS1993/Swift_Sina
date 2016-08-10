//
//  HomeViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn:JSRightImageButton = JSRightImageButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addAnimation()
        
//        if !isLogin {
//            return
//        }
        
        setUpNav()
    }
}

// MARK: - 设置导航栏UI
extension HomeViewController{
 
    private func setUpNav(){
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "navigationbar_friendattention")
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        titleBtn.setTitle("jiangsu", forState: .Normal)
        titleBtn.sizeToFit()
        titleBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClicked), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView=titleBtn
    }
}

// MARK: - 监听titleBtn的点击事件
extension HomeViewController{
    
    @objc private func titleBtnClicked(){
        
        titleBtn.selected = !titleBtn.selected
        
        let popoverVC = JSPopoverViewController()
        //设置modal样式为custom则底下的view不会被移除
        popoverVC.modalPresentationStyle = .Custom
        popoverVC.transitioningDelegate = self
        presentViewController(popoverVC, animated: true, completion: nil)
    }
}

// MARK: -UIViewControllerTransitioningDelegate
extension HomeViewController:UIViewControllerTransitioningDelegate{
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return JSPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
}