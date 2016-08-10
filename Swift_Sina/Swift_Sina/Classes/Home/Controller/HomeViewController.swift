//
//  HomeViewController.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/7.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var isPresented:Bool = false;
    
    private lazy var titleBtn:JSRightImageButton = JSRightImageButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addAnimation()
        
//        if !isLogin {
//            return
//        }
        
        setUpNav()
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
    }
}

// MARK: - 监听titleBtn的点击事件
extension HomeViewController{
    
    @objc private func titleBtnClicked(){
        
        titleBtn.selected = !titleBtn.selected
        
        let popoverVC = JSPopoverViewController()
        //设置modal样式为custom则底下的view不会被移除
        popoverVC.modalPresentationStyle = .Custom
        popoverVC.transitioningDelegate = self
        presentViewController(popoverVC, animated: true, completion: nil)
    }
}

// MARK: -自定义转场的代理方法
extension HomeViewController:UIViewControllerTransitioningDelegate{
    
    //改变弹出view的尺寸
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return JSPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    //改变弹出动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented=true
        
        return self
    }
    
    //改变消失动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented=false
        
        return self
    }
    
}

// MARK: - 弹出和消失动画的代理方法
extension HomeViewController:UIViewControllerAnimatedTransitioning{
    
    //动画时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    //获取的“转场的上下文”：可以用过转场上下文获取弹出的view和消失的view
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissView(transitionContext)
    }
    
    private func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning){
        
        //1.获取弹出的View
        let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        //2.将弹出的View添加到containerView中
        transitionContext.containerView()?.addSubview(presentedView)
        
        //3.执行动画
        presentedView.transform=CGAffineTransformMakeScale(1.0, 0.0)
        
        //设置锚点
        presentedView.layer.anchorPoint=CGPoint(x: 0.5, y: 0)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            presentedView.transform=CGAffineTransformIdentity
        }) { (isCompleted:Bool) in
            
            //4.告诉转场上下文动画已经完成
            transitionContext.completeTransition(true)
        }
        
        
    }
    
    private func animationForDismissView(transitionContext: UIViewControllerContextTransitioning){
        
        //1.获取消失的View
        let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
            dismissView.transform=CGAffineTransformMakeScale(1.0, 0.0001)
        }) { (isCompleted:Bool) in
            
            //2.从父控件移除
            dismissView.removeFromSuperview()
            //3.告诉转场上下文动画已经完成
            transitionContext.completeTransition(true)
        }
    }
    
    
    
}