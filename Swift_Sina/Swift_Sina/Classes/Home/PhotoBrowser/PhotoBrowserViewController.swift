//
//  PhotoBrowserViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/19.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SnapKit

private let PhotoBrowserCellID = "PhotoBrowserCell"

class PhotoBrowserViewController: UIViewController {
    
    var indexPath : NSIndexPath
    var picUrls : [NSURL]
    
    
    private lazy var collectionView : UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout: PhotoBrowserColletionViewLayout())
    private lazy var closeBtn : UIButton = UIButton()
    private lazy var saveBtn : UIButton = UIButton()
    
    //MARK :-构造函数
    init(indexPath : NSIndexPath , picUrls : [NSURL]) {
        self.indexPath = indexPath
        self.picUrls = picUrls
        super.init(nibName : nil ,bundle : nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(Coder) : has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

}

// MARK: - 设置UI
extension PhotoBrowserViewController{
    private func setUpUI() {
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        collectionView.frame = view.bounds
        collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserCellID)
        
        collectionView.dataSource = self
        
        
        
        closeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        closeBtn.addTarget(self, action: #selector(PhotoBrowserViewController.closeBtnClicked), forControlEvents: .TouchUpInside)
        
        saveBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(closeBtn)
            make.size.equalTo(closeBtn.snp_size)
        }
        saveBtn.addTarget(self, action: #selector(PhotoBrowserViewController.saveBtnClicked), forControlEvents: .TouchUpInside)
        
        closeBtn.setTitle("关 闭", forState: .Normal)
        saveBtn.setTitle("保 存", forState: .Normal)
        closeBtn.backgroundColor = UIColor.darkGrayColor()
        saveBtn.backgroundColor = UIColor.darkGrayColor()
    }
}

extension PhotoBrowserViewController{
    @objc private func closeBtnClicked(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClicked(){
        
    }
    
}

extension PhotoBrowserViewController : UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return picUrls.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellID, forIndexPath: indexPath) as! PhotoBrowserCell
        cell.picURL = picUrls[indexPath.item]
        return cell
    }
}


class PhotoBrowserColletionViewLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
    
        itemSize = (collectionView?.frame.size)!
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
















