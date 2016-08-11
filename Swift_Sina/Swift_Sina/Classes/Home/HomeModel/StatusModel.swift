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
    var created_at : String? {
        didSet {
            guard let created_at = created_at else {
                return
            }
            createText = NSDate.createDateString(created_at)
        }
    }
    var source : String? {
        didSet {
            
            guard let source = source where source != "" else {
               return
            }
            //<a href="http://weibo.com" rel="nofollow">新浪微博</a>"
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
    }
    var text : String?
    var mid : Int = 0
    
    var sourceText : String?
    var createText : String?
    
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
