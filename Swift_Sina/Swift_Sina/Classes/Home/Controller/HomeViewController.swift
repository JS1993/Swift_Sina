//
//  HomeViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import MJRefresh

class HomeViewController: BaseViewController {
    
    private lazy var titleBtn:JSRightImageButton = JSRightImageButton()
    
    private lazy var statusViewModels : [StatusViewModel] = [StatusViewModel]()
    
    //注意：在闭包或者函数中出现歧义，使用当前对象的属性或者调用方法，需要加self
    private lazy var popoverAnimation:JSPopoverAnimation = JSPopoverAnimation {[weak self] (isPresented) in
        
        self?.titleBtn.selected = isPresented
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addAnimation()
        
        setUpNav()
        
        setUpRefresh()
        
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
}

// MARK: - 设置导航栏UI
extension HomeViewController{
 
    private func setUpNav(){
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(imageName: "navigationbar_friendattention")
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        titleBtn.setTitle("jiangsu", forState: .Normal)
        titleBtn.sizeToFit()
        titleBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClicked), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView=titleBtn
        
        self.tableView.tableFooterView = UIView()
    }
    
    //设置下拉刷新
    private func setUpRefresh(){
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(HomeViewController.loadNewStatus))
        header.setTitle("下拉刷新", forState: .Idle)
        header.setTitle("松开刷新", forState: .Pulling)
        header.setTitle("加载中...", forState: .Refreshing)
        tableView.mj_header = header
        tableView.mj_header .beginRefreshing()
        
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget:self, refreshingAction: #selector(HomeViewController.loadMoreStatus))
        
    }
    
}

// MARK: - 监听titleBtn的点击事件
extension HomeViewController{
    
    @objc private func titleBtnClicked(){
        
        let popoverVC = JSPopoverViewController()
        //设置modal样式为custom则底下的view不会被移除
        popoverVC.modalPresentationStyle = .Custom
        popoverVC.transitioningDelegate = popoverAnimation
        popoverAnimation.presentFrame=CGRect(x: 100, y: 55, width: 180, height: 250)
        presentViewController(popoverVC, animated: true, completion: nil)
    }
}

// MARK: - 请求数据
extension HomeViewController{
    
    @objc private func loadNewStatus() {
        loadStatus(true)
    }
    
    @objc private func loadMoreStatus(){
        loadStatus(false)
    }
    private func loadStatus(isNew : Bool) {
        
        //获取sinceID/maxID
        var sinceID = 0
        var maxID = 0
        if isNew {
            sinceID = statusViewModels.first?.status?.mid ?? 0
        }else{
            maxID = statusViewModels.last?.status?.mid ?? 0
            maxID = maxID == 0 ? 0 : maxID-1
        }
        
        JSNetWorkingTools.shareInstance.loadStatus(sinceID,max_id: maxID) { (result, error) in
            if error != nil {
                print(error)
                return
            }
            guard let resultArray = result else {
                return
            }
            var tempStatuses : [StatusViewModel] = [StatusViewModel]()
            for statusDict in resultArray {
                let status = StatusModel(dict: statusDict)
                let statusViewModel=StatusViewModel(status: status)
                tempStatuses.append(statusViewModel)
            }
            
            if isNew {
               self.statusViewModels = tempStatuses + self.statusViewModels
            }else{
                self.statusViewModels = self.statusViewModels + tempStatuses
            }
            self.cacheImages(self.statusViewModels)
            
        }
    }
    
    //缓存图片
    private func cacheImages(viewModels : [StatusViewModel]){
        
        //创建组
        let group = dispatch_group_create()
        
        for viewModel in viewModels {
            for picURL in viewModel.picUrls {
                dispatch_group_enter(group)
                SDWebImageManager.sharedManager().downloadImageWithURL(picURL, options: [], progress: nil, completed: { (_, _, _, _,_) in
                    //下载完成离开组
                    dispatch_group_leave(group)
                })
            }
        }
        
        //组任务完成时，刷新表格
        dispatch_group_notify(group, dispatch_get_main_queue()) {
          
            self.tableView.reloadData()
            self.tableView.mj_header .endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
}

// MARK: - tableViewDataSource
extension HomeViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusViewModels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCell")! as! HomeViewCell
        let statusViewModel = self.statusViewModels[indexPath.row]
        cell.viewModel=statusViewModel
        return cell
    }
}
