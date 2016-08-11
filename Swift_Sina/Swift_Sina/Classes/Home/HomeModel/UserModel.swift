//
//  UserModel.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var profile_image_url : String?
    var verified_type : Int = -1
    var screen_name : String?
    var mbrank : Int = 0
    
    //MARK:-构造函数
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
}
