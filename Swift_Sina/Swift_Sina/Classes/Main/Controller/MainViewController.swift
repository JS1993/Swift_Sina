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
        publishBtn.addTarget(self, action:#selector(MainViewController.publishAction), forControlEvents: .TouchUpInside)
        tabBar.addSubview(publishBtn)
    }
}

// MARK: - 监听发布按钮点击
//发送消息是OC特性，将方法@SEL-->类中查找方法-->根据@SEL找到imp指针（函数指针）-->执行函数
//如果swift中声明一个方法是private，那么该函数不会被添加到方法列表中
//如果在private加上@objc,那么该方法依然会被添加到方法列表当中
extension MainViewController{
    @objc private func publishAction() {
        let publishVC = PublishViewController()
        let publishNav = UINavigationController(rootViewController: publishVC)
        presentViewController(publishNav, animated: true, completion: nil)
        
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
