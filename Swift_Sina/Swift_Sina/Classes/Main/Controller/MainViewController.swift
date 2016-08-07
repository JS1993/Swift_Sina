//
//  MainViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
        
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
