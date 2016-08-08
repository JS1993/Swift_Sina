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
    private lazy var visitorView: VisitorView = VisitorView.createVisitorView()
    
    //MARK: -定义变量
    var isLogin : Bool = false
    
    //MARK: -系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

// MARK: - 设置访客视图
extension BaseViewController{
    
    private func setUpVisitorView()  {
        view=visitorView
    }
}
