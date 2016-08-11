//
//  UserAccount.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/10.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding{

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
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //MARK: - 重写description属性
    override var description: String{
        return dictionaryWithValuesForKeys(["screen_name","profile_image_url","access_token","expires_date","uid"]).description
    }
    
    required init?(coder aDecoder: NSCoder) {
       access_token = aDecoder.decodeObjectForKey("access_token") as? String
       uid = aDecoder.decodeObjectForKey("uid") as? String
       expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
       profile_image_url = aDecoder.decodeObjectForKey("profile_image_url") as? String
       screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(profile_image_url, forKey: "profile_image_url")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
}
