//
//  PublishViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    
    private lazy var publishTitleView : PublishTitleView = PublishTitleView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
    }

    

}

// MARK: - 设置UI
extension PublishViewController{
    
    private func setUpNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(PublishViewController.closeVC))
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: #selector(PublishViewController.publishAction))
        navigationItem.rightBarButtonItem?.enabled = false
        
        publishTitleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = publishTitleView
    }
}

// MARK: - 监听事件
extension PublishViewController{
    @objc private func closeVC(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func publishAction(){
        print("发布")
    }
}