//
//  StatusViewModel.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {

    //MARK:-定义属性
    var status : StatusModel?
    //MARK:-用户数据处理
    var verifiedImage : UIImage?
    var  mbrankImage : UIImage?
    var sourceText : String?
    var  creatAtText : String?
    var  profileImageUrl : NSURL?
    var picUrls : [NSURL] = [NSURL]()
    
    
    
    init(status : StatusModel) {
        super.init()
        self.status = status
        
        //处理来源
        if let source=status.source where status.source != "" {
            //<a href="http://weibo.com" rel="nofollow">新浪微博</a>"
            let startIndex = (source as NSString).rangeOfString(">").location + 1
            let length = (source as NSString).rangeOfString("</").location - startIndex
            sourceText = (source as NSString).substringWithRange(NSRange(location: startIndex, length: length))
        }
        
        //处理时间
        if let creatAt = status.created_at {
            creatAtText=NSDate.createDateString(creatAt)
        }
        
        //处理认证
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage=UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage=UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage=UIImage(named: "avatar_grassroot")
        default:
            verifiedImage=nil
        }
        
        //处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank>0&&mbrank<7 {
            mbrankImage=UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        
        //处理用户头像
        let profileURLStr = status.user?.profile_image_url ?? ""
        profileImageUrl = NSURL(string: profileURLStr)
        
        //处理配图数据
        if let picUrlDicts = status.pic_urls {
            for picUrlDict in picUrlDicts {
                guard let picUrlStr = picUrlDict["thumbnail_pic"] else {
                    continue
                }
                picUrls.append(NSURL(string:picUrlStr)!)
            }
        }
        
        
    }
    
    
}
