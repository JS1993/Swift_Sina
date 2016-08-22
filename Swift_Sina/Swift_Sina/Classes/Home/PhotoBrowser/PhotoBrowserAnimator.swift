//
//  PhotoBrowserAnimator.swift
//  Swift_Sina
//
//  Created by  江苏 on 16/8/22.
//  Copyright © 2016年 Hunter. All rights reserved.
//

import UIKit

protocol AnimatorPresentedDelegate : NSObjectProtocol {
    func startRect(indexPath : NSIndexPath) -> CGRect
    func endRect(indexPath : NSIndexPath) -> CGRect
    func imageView(indexPath : NSIndexPath) -> UIImageView
}

class PhotoBrowserAnimator: NSObject {
    
    var isPresented : Bool = false
    var presentedDelegate : AnimatorPresentedDelegate?
    var indexPath : NSIndexPath?    
    
}

extension PhotoBrowserAnimator : UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension PhotoBrowserAnimator : UIViewControllerAnimatedTransitioning{
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animationForPresentView(transitionContext)
        }else{
            animationForDismissView(transitionContext)
        }
        
    }
    
    func animationForPresentView(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentedDelegate = presentedDelegate, indexPath = indexPath else {
            return
        }
        
        let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)
        transitionContext.containerView()?.addSubview(presentedView!)
        let imageView = presentedDelegate.imageView(indexPath)
        transitionContext.containerView()?.addSubview(imageView)
        imageView.frame = presentedDelegate.startRect(indexPath)
        
        presentedView?.alpha = 0.0
        transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            imageView.frame = presentedDelegate.endRect(indexPath)
        }) { (_) in
            presentedView?.alpha = 1.0
            imageView.removeFromSuperview()
            transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        let dissmissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        transitionContext.containerView()?.addSubview(dissmissView!)
        
        dissmissView?.alpha = 1.0
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            dissmissView?.alpha = 0.0
        }) { (_) in
            
            dissmissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}