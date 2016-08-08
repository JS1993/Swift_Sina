//
//  MainViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    private lazy var publishBtn:UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }

}

// MARK: - 设置UI界面
extension MainViewController{
    func setUpUI() {
        publishBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        publishBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        publishBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        publishBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        publishBtn.sizeToFit()
        publishBtn.center=CGPointMake(tabBar.center.x, tabBar.bounds.size.height*0.5)
        tabBar.addSubview(publishBtn)
    }
}

// MARK: - 代码添加子控制器
extension MainViewController{
    
    func addChildVCS() {
        
    }
    
    func addChildViewController(childVC:UIViewController,title:String,imageName:String)  {
        
        childVC.view.backgroundColor=UIColor .redColor()
        childVC.title=title
        childVC.tabBarItem.image=UIImage(named:imageName)
        childVC.tabBarItem.selectedImage=UIImage(named: imageName+"_highlighted")
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
        
    }
}
