//
//  WelcomeViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/11.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    @IBOutlet var headImageV: UIImageView!
    @IBOutlet var bottomMargin: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        headImageV.layer.cornerRadius=45
        headImageV.layer.masksToBounds=true
        
        let proFileUrlString = UserAccountViewModel.shareIntance.account?.profile_image_url
        //？？语法：如果？？前面有值则赋值，没值则赋后面的
        let url = NSURL(string: proFileUrlString ?? "")

        headImageV.sd_setImageWithURL(url, placeholderImage: UIImage(named: "avatar_default"))
        //添加动画
        bottomMargin.constant = UIScreen.mainScreen().bounds.size.height-200
        
        //执行动画
        UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            
            self.view.layoutIfNeeded()
            
            }) { (_) in
                
        }
    }

}
