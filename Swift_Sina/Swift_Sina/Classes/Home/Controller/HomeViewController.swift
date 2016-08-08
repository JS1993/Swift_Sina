//
//  HomeViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addAnimation()
        
//        if !isLogin {
//            return
//        }
        
        setUpNav()
    }
    


}

// MARK: - 设置UI界面
extension HomeViewController{
 
    private func setUpNav(){
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "navigationbar_friendattention")
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(imageName: "navigationbar_pop")
    }
}