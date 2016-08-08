//
//  BaseViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/8.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    //MARK: -懒加载属性
    lazy var visitorView: VisitorView = VisitorView.createVisitorView()
    
    //MARK: -定义变量
    var isLogin : Bool = false
    
    //MARK: -系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav()
        
    }
}

// MARK: - 设置访客视图
extension BaseViewController{
    
    private func setUpVisitorView()  {
        view=visitorView
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerAction), forControlEvents: .TouchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginAction), forControlEvents: .TouchUpInside)
    }
}

// MARK: - 设置导航栏左右item
extension BaseViewController{
    
    private func setUpNav(){
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "注册", style: .Plain, target: self, action: #selector(BaseViewController.registerAction))
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "登录", style: .Plain, target: self, action: #selector(BaseViewController.loginAction))
    }
    
    @objc private func registerAction() {
        print("点击了注册")
    }
    
    @objc private func loginAction() {
        print("点击了登录")
    }
    
}
