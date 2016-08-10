//
//  UserAccount.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/10.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

    var access_token : String?
    
    var expires_in : NSTimeInterval = 0.0 {
        //属性监听
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
            //let nowDate = NSDate()
        }
    }
    var uid : String?
    
    //过期日期属性
    var expires_date : NSDate?
    
    //昵称
    var screen_name :String?
    //头像
    var profile_image_url : String?
    
    
    
    //MARK:-自定义构造函数
    convenience init(dict:[String : AnyObject]) {
        self.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //MARK: - 重写description属性
    override var description: String{
        return dictionaryWithValuesForKeys(["screen_name","profile_image_url","access_token","expires_date","uid"]).description
    }
}
