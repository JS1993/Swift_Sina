//
//  JSNetWorkingTools.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/10.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import AFNetworking
import SVProgressHUD

// 定义枚举类型
enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}

class JSNetWorkingTools: AFHTTPSessionManager {
    // let是线程安全的
    static let shareInstance : JSNetWorkingTools = {
        let tools = JSNetWorkingTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
}

// MARK:- 封装请求方法
extension JSNetWorkingTools {
    func request(methodType : RequestType, urlString : String, parameters : [String : AnyObject], finished : (result : AnyObject?, error : NSError?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : NSURLSessionDataTask, result : AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            finished(result: nil, error: error)
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}


// MARK:- 请求AccessToken
extension JSNetWorkingTools {
    func loadAccessToken(code : String, finished : (result : [String : AnyObject]?, error : NSError?) -> ()) {
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 2.获取请求的参数
        let parameters = ["client_id" : appkey, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect, "code" : code]
        
        // 3.发送网络请求
        request(.POST, urlString: urlString, parameters: parameters) { (result, error) -> () in
            finished(result: result as? [String : AnyObject], error: error)
        }
    }
}

// MARK: - 请求用户信息
extension JSNetWorkingTools{
   
    func loadUserInfo(access_token : String, uid : String, finished : (result : [String : AnyObject]?, error : NSError?) ->()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token":access_token,"uid":uid]
        
        request(.GET, urlString: urlString, parameters: parameters) { (result, error) in
            finished(result:result as? [String : AnyObject], error: error)
        }
        
    }
    
}

// MARK: - 请求首页数据
extension JSNetWorkingTools{
    func loadStatus(since_id: Int,max_id : Int ,finished:(result : [[String : AnyObject]]?,error : NSError?)->()){
        
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token" : (UserAccountViewModel.shareIntance.account?.access_token)!,
                          "since_id" : "\(since_id)","max_id" : "\(max_id)"]
        request(.GET, urlString: urlStr, parameters: parameters) { (result, error)->() in
            
            guard let resultDict = result as? [String : AnyObject] else {
                finished(result: nil, error: error)
                return
            }
            
            finished(result:resultDict["statuses"] as? [[String : AnyObject]], error: error)
        }
    }
}


// MARK:- 发送微博
extension JSNetWorkingTools {
    
    func sendStatus(statusText : String, isSuccess : (isSuccess : Bool) -> () ){
        // 1.获取请求的URLString
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 2.获取请求的参数
        let parameters = ["access_token" : (UserAccountViewModel.shareIntance.account?.access_token)!, "status" : statusText]
        
        // 3.发送网络请求
        request(.POST, urlString: urlString, parameters: parameters) { (result, error) -> () in
            if result != nil {
                isSuccess(isSuccess: true)
            } else {
                isSuccess(isSuccess: false)
            }
        }
    }
}



















