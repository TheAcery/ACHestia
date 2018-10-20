//
//  ACHFirstViewTranslationAnimtor.m
//  ACHestia
//
//  Created by Acery on 2018/10/14.
//  Copyright © 2018年 Acery. All rights reserved.
//  废弃

#import "ACHFirstViewTranslationAnimtor.h"


@interface ACHFirstViewTranslationAnimtor ()


@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, weak) UIView *toView;

@property (nonatomic, weak) UIViewController *toVC;

@property (nonatomic, weak) UIView *fromView;

@property (nonatomic, weak) UIViewController *fromVC;

@end

@implementation ACHFirstViewTranslationAnimtor

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    /**实现动画*/
    
    [self getVCsAndViews:transitionContext];
    
    //判断是否是pop
    NSInteger toVCIndex = [self.toVC.navigationController.childViewControllers indexOfObject:self.toVC];
    NSInteger fromVCIndex = [self.fromVC.navigationController.childViewControllers indexOfObject:self.fromVC];
    
    if (fromVCIndex > toVCIndex)
    {
       
        [self prepareAnimtorForPOP];
    }
    else
    {
        [self prepareAnimtorForPUSH];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (fromVCIndex > toVCIndex)
        {
            [self animtorForPOP];
        }
        else
        {
            [self animtorForPUSH];
        }
        
    } completion:^(BOOL finished) {
        
        [self endAnimtor];
        BOOL isfinish = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isfinish];
        
    }];
}

#pragma mark - funs
/****************************************************************************************************************/


-(void)getVCsAndViews:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.containerView = transitionContext.containerView;
    
    //get toVC
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.toView = self.toVC.view;
    
    //get fromVC
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromView = self.fromVC.view;
}

-(void)animtorForPOP
{
    //移动控制器视图
    self.fromView.transform = CGAffineTransformTranslate(self.fromView.transform,SCRENNBOUNDS.size.width, 0);
//    self.toVC.navigationController.navigationBar.alpha = 0.0;
    
    //移动tabBar
    
//    self.fromVC.tabBarController.tabBar.frame = CGRectMake(0, 667 - 49, 375, 49);
    //移动navigationBar
    self.fromVC.navigationController.navigationBar.transform = CGAffineTransformTranslate(self.fromVC.navigationController.navigationBar.transform, SCRENNBOUNDS.size.width, 0);
    

}


-(void)animtorForPUSH
{
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,-SCRENNBOUNDS.size.width,0);
    self.fromView.transform = CGAffineTransformTranslate(self.fromView.transform,-SCRENNBOUNDS.size.width,0);
    self.toVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;

    
}


-(void)prepareAnimtorForPOP
{
   
    [self.containerView addSubview:self.toView];
    
//    self.fromView.frame = CGRectMake(0, -667 + 49 + 64, 375, 667);
//    self.fromView.bounds = CGRectMake(0, 64, 375, 700);
//    self.fromVC.tabBarController.tabBar.clipsToBounds = NO;
//    self.fromVC.tabBarController.tabBar.frame = CGRectMake(0, 667 - 49, 375, 49);
//    [self.fromVC.tabBarController.tabBar addSubview:self.fromView];
    [self.containerView addSubview:self.fromView];
//    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,-SCRENNBOUNDS.size.width,0);
    
//    self.fromVC.tabBarController.tabBar.hidden = YES;

}

-(void)prepareAnimtorForPUSH
{
    self.toView.frame = CGRectMake(0, 64, SCRENNBOUNDS.size.width, SCRENNBOUNDS.size.height - 64);
    [self.containerView addSubview:self.fromView];
    [self.containerView addSubview:self.toView];
    self.toView.transform = CGAffineTransformTranslate(self.toView.transform,SCRENNBOUNDS.size.width,0);
    self.toVC.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(SCRENNBOUNDS.size.width, 0);
}

-(void)endAnimtor
{
    //恢复导航栏
//    self.fromVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
//    self.toVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    //恢复控制器视图
//    self.toView.transform = CGAffineTransformIdentity;
//    self.fromView.transform = CGAffineTransformIdentity;
    
    self.toVC.navigationController.navigationBar.alpha = 1.0;
    
    self.fromVC.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    
}

@end
