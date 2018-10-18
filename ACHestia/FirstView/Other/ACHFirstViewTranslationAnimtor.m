//
//  ACHFirstViewTranslationAnimtor.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  使用自定义的转场动画取消navcpop时导航栏仍显示的问题

#import "ACHFirstViewTranslationAnimtor.h"

@implementation ACHFirstViewTranslationAnimtor

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    /**实现动画*/
    
    UIView *containerView = transitionContext.containerView;
    
    //toVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    
    //fromVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    
    //判断是否是pop
    NSInteger toVCIndex = [toVC.navigationController.childViewControllers indexOfObject:toVC];
    NSInteger fromVCIndex = [fromVC.navigationController.childViewControllers indexOfObject:fromVC];
    
    if (fromVCIndex > toVCIndex)
    {
        [containerView addSubview:fromView];
        [containerView addSubview:toView];
        toView.transform = CGAffineTransformTranslate(fromView.transform,- SCRENNBOUNDS.size.width, 0);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        toView.transform = CGAffineTransformIdentity;
        fromVC.navigationController.navigationBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        
        fromVC.navigationController.navigationBar.alpha = 1.0;
        BOOL isfinish = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isfinish];
        
    }];
}


@end
