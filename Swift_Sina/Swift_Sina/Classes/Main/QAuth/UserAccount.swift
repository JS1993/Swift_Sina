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
    var expires_in : NSTimeInterval = 0.0
    var uid : String?
    
    //MARK:-自定义构造函数
    convenience init(dict:[String : AnyObject]) {
        self.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
    //MARK: - 重写description属性
    override var description: String{
        return dictionaryWithValuesForKeys(["access_token","expires_in","uid"]).description
    }
}
