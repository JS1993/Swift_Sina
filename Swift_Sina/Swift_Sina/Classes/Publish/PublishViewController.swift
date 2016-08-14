//
//  PublishViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    
    private lazy var publishTitleView : PublishTitleView = PublishTitleView()
    @IBOutlet var publishTextView: JSPlaceHolderTextView!
    @IBOutlet var keyBoardToolBar: UIToolbar!
    
    @IBOutlet var keyBoradToolBarBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PublishViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        publishTextView.becomeFirstResponder()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}

// MARK: - 设置UI
extension PublishViewController{
    
    private func setUpNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(PublishViewController.closeVC))
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "发布", style: .Plain, target: self, action: #selector(PublishViewController.publishAction))
        navigationItem.rightBarButtonItem?.enabled = false
        
        publishTitleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = publishTitleView
    }
}

// MARK: - 监听事件
extension PublishViewController{
    @objc private func closeVC(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func publishAction(){
        print("发布")
    }
    
    @objc private func keyboardWillChangeFrame(note : NSNotification){
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let y = endFrame.origin.y
        
        let margin = UIScreen.mainScreen().bounds.height - y
        keyBoradToolBarBottomConstraint.constant = margin
        UIView.animateWithDuration(duration) { 
            self.view.layoutIfNeeded()
        }
        
        
        
        
    }
}

// MARK: - textView代理方法
extension PublishViewController : UITextViewDelegate{
    func textViewDidChange(textView: UITextView) {
        publishTextView.placeHolderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        publishTextView.resignFirstResponder()
    }
}






















