//
//  UserAccountTool.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class UserAccountViewModel {
    
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    var account : UserAccount?
    
    var accountPath : String{
        var accountPath=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        accountPath = (accountPath as NSString).stringByAppendingPathComponent("account.plist")
        print(accountPath)
        return accountPath
    }
    
    var isLogin : Bool {
        
        if account==nil {
            return false
        }
        
        guard let expiresDate=account?.expires_date else {
            return false
        }
        
        return expiresDate.compare(NSDate()) == NSComparisonResult.OrderedDescending
    }
    
    
    init(){
        //读取信息
         account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? UserAccount
    }
}
