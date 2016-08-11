//
//  StatusModel.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class StatusModel: NSObject {

    //MARK:-属性
    var created_at : String? 
    var source : String?
    var text : String?
    var mid : Int = 0
    
    var user : UserModel?
    
    
    //MARK:-自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        if let userDict = dict["user"] as? [String : AnyObject] {
            user=UserModel(dict: userDict)
        }
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
