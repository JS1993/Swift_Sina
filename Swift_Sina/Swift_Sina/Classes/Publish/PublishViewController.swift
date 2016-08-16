//
//  PublishViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/14.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    
    //MARK :- 属性
    private lazy var publishTitleView : PublishTitleView = PublishTitleView()
    private lazy var images : [UIImage] = [UIImage]()
    
    @IBOutlet var publishTextView: JSPlaceHolderTextView!
    @IBOutlet var keyBoardToolBar: UIToolbar!
    @IBOutlet var picCollectionView: PicPickerCollectionView!
    
    @IBOutlet var pictureCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var keyBoradToolBarBottomConstraint: NSLayoutConstraint!
    
    //MARK :- 系统回掉方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNav()
        
        setUpNoti()
        
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
    
    private func setUpNoti(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PublishViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PublishViewController.addPhotoClick), name: "PicPickerNoti", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PublishViewController.removePhotoClick(_:)), name: "PicPickerNotiDelete", object: nil)
        
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

    @IBAction func picturePicker(sender: UIButton) {
        publishTextView.resignFirstResponder()
        pictureCollectionViewHeightConstraint.constant = UIScreen.mainScreen().bounds.height*0.65
        UIView.animateWithDuration(0.5) { 
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func atAction(sender: UIButton) {
    }
    @IBAction func thingAction(sender: UIButton) {
    }
    @IBAction func emotionAction(sender: UIButton) {
        publishTextView.resignFirstResponder()
        publishTextView.inputView = publishTextView.inputView != nil ? nil : UISwitch()
        publishTextView.becomeFirstResponder()
    }
    @IBAction func keyBoardAction(sender: UIButton) {
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


// MARK: - 添加、删除照片事件
extension PublishViewController{
    @objc private func addPhotoClick() {
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            return
        }
        
        let ipc = UIImagePickerController()
        
        ipc.sourceType = .PhotoLibrary
        
        ipc.delegate = self
        
        presentViewController(ipc, animated: true, completion: nil)
    }
    
    @objc private func removePhotoClick(noti : NSNotification) {
        
        guard  let image = noti.object as? UIImage else {
            return
        }
        
        guard let index = images.indexOf(image) else {
           return
        }
        
        images.removeAtIndex(index)
        
        picCollectionView.images = images
    }
}

// MARK: -UIImagePicker代理方法
extension PublishViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        picCollectionView.images = images;
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
















