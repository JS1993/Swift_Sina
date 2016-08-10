//
//  QAuthViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/10.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SVProgressHUD

class QAuthViewController: UIViewController {
    
    //MARK:-控件属性
    @IBOutlet var webView: UIWebView!
    
    //MARK:-系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav()
        
        loadPage()
        
    }

}

// MARK: - 设置界面
extension QAuthViewController{
    
    private func setUpNav(){
        navigationItem.leftBarButtonItem=UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(QAuthViewController.clooseBtnClicked))
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "填充", style: .Plain, target: self, action:#selector(QAuthViewController.fillBtnClicked))
        
        title="登录"
    }
    
    private func loadPage(){
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(appkey)&redirect_uri=\(redirect)")
        webView .loadRequest(NSURLRequest(URL: url!))
    }
}

// MARK: - 按钮事件监听
extension QAuthViewController{
    
    @objc private func clooseBtnClicked(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //填充帐号密码
    @objc private func fillBtnClicked(){
        
        //1.书写js代码
        let jscode="document.getElementById('userId').value='18175022904';document.getElementById('passwd').value='123456JS@';"
        
        //2.执行js代码
        webView.stringByEvaluatingJavaScriptFromString(jscode)
        
    }
}

// MARK: - webView的代理方法
extension QAuthViewController : UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }
    
    //当准备加载某个网页就会执行该方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //1.获取当前加载网页的NSURL
        guard let url = request.URL else {
            
            return true
        }
        
        //2.获得URL字符串
        let urlStr = url.absoluteString
        
        //3.判断该字符串是否包含code
        guard urlStr.containsString("code=") else {
            return true
        }
        
        //4.将code截取出来
        let codeStr = urlStr.componentsSeparatedByString("code=").last!
        
        //5.请求accessToken
        JSNetWorkingTools.shareInstance.loadAccessToken(codeStr) { (result, error) in
            
            //1.错误校验
            if error != nil{
                print(error)
                return
            }
            
            //2.拿到结果
            guard let accountDict = result else {
                print("没有获取授权后的数据")
                return
            }
            
            //3.将字典转成模型对象
            let account = UserAccount(dict: accountDict)
            
            print(account)
        }
        
        return false
    }
}















