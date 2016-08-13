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
    var pic_urls : [[String : String]]?
    var retweeted_status : StatusModel?
    
    
    var user : UserModel?
    
    
    //MARK:-自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
        
        //将用户字典转模型
        if let userDict = dict["user"] as? [String : AnyObject] {
            user=UserModel(dict: userDict)
        }
        
        //将转发微博字典转模型
        if let reweetedStatusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = StatusModel(dict: reweetedStatusDict)
        }
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
}
