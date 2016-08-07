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

        let childVC = HomeViewController()
        childVC.view.backgroundColor=UIColor .redColor()
        childVC.title="首页"
        childVC.tabBarItem.image=UIImage(named: "tabbar_home")
        childVC.tabBarItem.selectedImage=UIImage(named: "tabbar_home_highlighted")
        let childNav = UINavigationController(rootViewController: childVC)
        addChildViewController(childNav)
    }
    
    func addChildViewController(childVC:UIViewController,title:String,imageName:String)  {
        
    }

}
